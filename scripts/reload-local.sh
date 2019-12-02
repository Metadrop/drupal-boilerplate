#!/bin/bash
set -e

# Set defautl constants.
########################
DEFAULT_SITE="lyreco"
DEFAULT_REMOTE_ENVIRONMENT="stg"
VALID_ENVIRONMENTS=("dev" "stg")

# Set the target remote Environment to download database.
REMOTE_ENVIRONMENT=$DEFAULT_REMOTE_ENVIRONMENT
SITE=$DEFAULT_SITE

PROJECT_ROOT="./"

# Scripts/executables.
DOCKER_EXEC_PHP="docker-compose exec php"
DOCKER_EXEC_TTY_PHP="docker-compose exec -T php"
DOCKER_EXEC_NPM="docker-compose exec node"
COMPOSER_EXEC="composer"
RM_EXEC="rm"



# Default flags values.
NO_ACTION=false
DATABASE_ONLY=false
NO_DATABASE=false
REFRESH_LOCAL_DUMP=false

# Having a month based db backup filename ensures the database is refreshed at least every month.
BACKUP_FILE_NAME_TEMPLATE=db-$(date +%Y-%m)


function show_help() {
cat << EOF

Reloads a site's local environment with data from a given remote environment.

Reloads includes:
  - Execute composer install.
  - Download database from remote environment and site (if needed).
  - Imports downloaded database in local environment and site.
  - Drupal update (updb and cim).
  - Frontend assets generation  (./scripts/frontend-build.sh)

Usage: ${0##*/} [-d|--database-only] [-e|--env=(ENVIRONMENT_NAME)] [-s|--site=(SITE_NAME)]
  -h|--help         Show this help and exit.

  -d
  --database-only   Perfom only database sync operation (composer install and site update is not done).

  --no-database     Do not perform database sync operation.

  -e=ENV
  --env=ENV         The environment from which to syncronize the database. Defaults to stg. Valid environments are dev, stg.

  -s=SITE
  --site=SITE       The site to reload. Defaults to main.

  -r
  --refresh         Refresh the local dump file before importing it. This is always done if no local file is found.

  -n
  --no-action       Show actions that would be done but do not execute any command. Useful for debugging purposes.
EOF
}

#######################################
# Create database if not exist and grant privileges.
# Globals:
#   PROJECT_ROOT
#   SITE
# Arguments:
#   None
# Returns:
#   None
#######################################
function create_database() {
  # Get connection credentials from .env file.
  MYSQL_ROOT_PASS=`egrep DB_ROOT_PASSWORD ${PROJECT_ROOT}/.env | sed s/DB_ROOT_PASSWORD=//`
  MYSQL_HOST=`egrep DB_HOST ${PROJECT_ROOT}/.env | sed s/DB_HOST=//`
  MYSQL_DB_NAME=`egrep DB_NAME ${PROJECT_ROOT}/.env | sed s/DB_NAME=//`
  MYSQL_DB_USER=`egrep DB_USER ${PROJECT_ROOT}/.env | sed s/DB_USER=//`

  if [ $SITE != $DEFAULT_SITE ]
  then
    MYSQL_DB_NAME="${MYSQL_DB_NAME}_${SITE}"
  fi

  # Create DB.
  $DOCKER_EXEC_PHP mysql -u root -p${MYSQL_ROOT_PASS} -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DB_NAME};GRANT ALL PRIVILEGES ON ${MYSQL_DB_NAME}.* TO  '${MYSQL_DB_USER}'@'%';"
}

# Process script options.
#########################
for i in "$@"
do
  case ${i} in
    -h|--help)
        show_help    # Display a usage synopsis.
        exit
        ;;
    -d|--database-only)
        DATABASE_ONLY=true
        ;;
    --no-database)
        NO_DATABASE=true
        ;;
    -e=*|--env=*)       # Takes an option argument; ensure it has been specified.
        REMOTE_ENVIRONMENT="${i#*=}"
        ;;
    -s=*|--site=*)       # Takes an option argument; ensure it has been specified.
        SITE="${i#*=}"
        ;;
    -r|--refresh)
        REFRESH_LOCAL_DUMP=true
        ;;
    -n|--no-action)
        NO_ACTION=true
        ;;
    --)              # End of all options.
        shift
        break
        ;;
    -?*|*)
        printf 'ERROR: Unknown option: %s\n' "$1" >&2
        show_help
        exit 1
        ;;
  esac
shift
done


# Perform some sanity checks.
#############################

if [ ${NO_DATABASE} = true ] && [ ${DATABASE_ONLY} = true ]
then
  printf 'ERROR: The options --database-only and --no-database are not compatible.\n' "$1" >&2
  show_help
  exit 1
fi

IS_VALID_ENVIRONMENT=$(echo "${VALID_ENVIRONMENTS[@]}" | grep -o "${REMOTE_ENVIRONMENT}" | wc -w)
if [ "${IS_VALID_ENVIRONMENT}" = 0 ]
then
  echo "ERROR: Wrong environment: ${REMOTE_ENVIRONMENT}. Valid environments are ${VALID_ENVIRONMENTS[@]}"
  show_help
  exit 1
else
  echo "Reloading local environment ${SITE} site with database from $REMOTE_ENVIRONMENT remote environment."
fi


# Setup some calculated constants.
if [ $NO_ACTION = true ]
then
    DOCKER_EXEC_PHP="echo $DOCKER_EXEC_PHP"
    DOCKER_EXEC_TTY_PHP="echo $DOCKER_EXEC_TTY_PHP"
    COMPOSER_EXEC="echo $COMPOSER_EXEC"
    RM_EXEC="echo $RM_EXEC"
    DOCKER_EXEC_NPM="echo $DOCKER_EXEC_NPM"
fi

if [ $SITE = $DEFAULT_SITE ]
then
    LOCAL_ALIAS="self"
else
    LOCAL_ALIAS="$SITE"
fi

REMOTE_ALIAS="$SITE.$REMOTE_ENVIRONMENT"

BACKUP_FILE_NAME=${BACKUP_FILE_NAME_TEMPLATE}.${SITE}.${REMOTE_ENVIRONMENT}.sql
LOCAL_FILE=${PROJECT_ROOT}tmp/${BACKUP_FILE_NAME}

cd ${PROJECT_ROOT}

if [[ ${DATABASE_ONLY} = false ]]
then
  # Install dependencies and compile css.
  $COMPOSER_EXEC install --ignore-platform-reqs

fi

if [[ ${NO_DATABASE} = false ]]
then

  create_database

  # Do we need to download a remote dump?
  # Best if we do this before droping current database.
  if [ ${REFRESH_LOCAL_DUMP} = true ] || [ ! -f $LOCAL_FILE ]
  then
    echo "Either no local dump was found or refresh local dump options was passed."
    # Ensure using your personal ssh-key before trying to connect to remote alias for downloading the database.
    ssh-add -k
    $DOCKER_EXEC_PHP drush sql:sync @${REMOTE_ALIAS} @${LOCAL_ALIAS} -y
    $DOCKER_EXEC_PHP drush @${LOCAL_ALIAS} sql:sanitize -y

    if [ $? -ne 0 ]
    then
      echo "There was an error downloading the remote DB dump."
      exit -1
    fi
  else
    # Drop current database.
    $DOCKER_EXEC_PHP drush @${LOCAL_ALIAS} sql-drop -y

    echo "Loading database from local file:  ${LOCAL_FILE}"
    cat ${LOCAL_FILE} | $DOCKER_EXEC_TTY_PHP  drush @${LOCAL_ALIAS} sql-cli
  fi

fi

if [[ ${DATABASE_ONLY} = false ]]
then

  # Execute updates and import configuration.
  $DOCKER_EXEC_PHP drush @${LOCAL_ALIAS} updb -y

  $DOCKER_EXEC_PHP drush @${LOCAL_ALIAS} cim sync -y

  make fronted ${NPM_RUN_COMMAND}

  # Show one-time login link.
  $DOCKER_EXEC_PHP drush @${LOCAL_ALIAS} uli

fi

if [ ${REFRESH_LOCAL_DUMP} = true ] || [ ! -f $LOCAL_FILE ]
  then
    echo "Updating local dump."
    $DOCKER_EXEC_PHP drush @${LOCAL_ALIAS} sql:dump --result-file=../$LOCAL_FILE
fi

cat << EOF
//////////////////////////////
//  RELOAD LOCAL COMPLETED  //
//////////////////////////////
EOF

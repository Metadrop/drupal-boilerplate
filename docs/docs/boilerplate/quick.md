# Quick Reference

The project provides some commands using [make](makefiles.md). Please, try the following command int he repository root to see all the commands available:

```
make help
```

## How to configure the project

Select `yes` when asked to run the configuration wizard during the boilerplate installation process (this is when running the `composer create-project` command).

If you didn't select `yes` during the boilarplate installation you can run it once installed using `composer`:

`composer scripthor:assistant`


!!! warning
    This command will overwrite any configuration you have done on the files it handles.


Or you can use the `make setup` command. This commands prepares de containers, does a minimal configuration, installs composer packages and tries to reload the local environment with data from a remote environment.


## How to manage containers

You can use `docker-compose`as you usually would do. However, there are some `make` commands to easily perform some common actions:

- Bring containers up to work on the project:

  `make` or `make up`

  Both run the same actions.

- Stop containers:

  `make stop` or `make down`

- Remove all containers:

  `make prune`

## Get a shell inside a container

`make shell` for a shell inside the PHP container.

`make shell <CONTAINER NAME>` for a shel in antoher container.


## Run a drush command on the PHP container

`make drush <command>` to run a Drush command.

## Access the MaraiDB database CLI as root

First, connect to the database container:

`make shell mariadb`

Once inside the MariaDB database container run:

`mysql -u root -ppassword -b drupal`

If you have changed any of default values you will have to update them in the previous command. Check your `.env` file for the current values.

## Reload project with data from a remote environment


You can use the Scripthor script to reload the data:

`scripts/reload-local.sh --site=<SITE_ALIAS>`

SITE_ALIAS would be the Drush alias fromt the remote environment you want to load data from.


## Get project URL and related tools

  Run the info command:

  `make info`

## See captured emails

Please go to the Mailhog URL. Use the `make info` to get the URL.

Mailhog is an email testing tool for developers. All outgoing emails are configured to be catched by Mailhog, so you can read them and make sure they are what you expect.



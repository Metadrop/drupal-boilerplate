#!/usr/bin/env bash

# Creates secondary database. Usage: ./scripts/create-database legacy
set -e

DB_NAME=$1
PROJECT_ROOT="./"
MYSQL_ROOT_PASS=`egrep DB_ROOT_PASSWORD ${PROJECT_ROOT}/.env | sed s/DB_ROOT_PASSWORD=//`
MYSQL_HOST=`egrep DB_HOST ${PROJECT_ROOT}/.env | sed s/DB_HOST=//`

docker compose exec -T mariadb mysql -u root -p${MYSQL_ROOT_PASS} -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO  'drupal'@'%';"

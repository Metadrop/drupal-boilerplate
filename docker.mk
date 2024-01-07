include .env

default: up

COMPOSER_ROOT ?= /var/www/html
DRUPAL_ROOT ?= /var/www/html/web

## help	:	Print commands help.
.PHONY: help
help :
	@sed -n 's/^##//p' Makefile
	@sed -n 's/^##//p' docker.mk


## up	:	Start up containers.
.PHONY: up
up:
	@echo "Starting up containers for $(PROJECT_NAME)..."
	$(DOCKER_COMPOSE_CMD) pull
	$(DOCKER_COMPOSE_CMD) up -d --remove-orphans

.PHONY: mutagen
mutagen:
	$(DOCKER_COMPOSE_CMD) up -d mutagen
	mutagen project start -f mutagen/config.yml

## down	:	Stop containers.
.PHONY: down
down: stop

## start	:	Start containers without updating.
.PHONY: start
start:
	@echo "Starting containers for $(PROJECT_NAME) from where you left off..."
	@$(DOCKER_COMPOSE_CMD) start

## stop	:	Stop containers.
.PHONY: stop
stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@$(DOCKER_COMPOSE_CMD) stop

## prune	:	Remove containers and their volumes.
##		You can optionally pass an argument with the service name to prune single container
##		prune mariadb	: Prune `mariadb` container and remove its volumes.
##		prune mariadb solr	: Prune `mariadb` and `solr` containers and remove their volumes.
.PHONY: prune
prune:
	@echo "Removing containers for $(PROJECT_NAME)..."
	@$(DOCKER_COMPOSE_CMD) down -v $(filter-out $@,$(MAKECMDGOALS))

## ps	:	List running containers.
.PHONY: ps
ps:
	@docker ps --filter name='$(PROJECT_NAME)*'

## shell	:	Access `php` container via shell.
##		You can optionally pass an argument with a service name to open a shell on the specified container
.PHONY: shell
shell:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='$(PROJECT_NAME)_$(or $(filter-out $@,$(MAKECMDGOALS)), 'php')' --format "{{ .ID }}") sh

## composer	:	Executes `composer` command in a specified `COMPOSER_ROOT` directory (default is `/var/www/html`).
##		To use "--flag" arguments include them in quotation marks.
##		For example: make composer "update drupal/core --with-dependencies"
.PHONY: composer
composer:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") composer --working-dir=$(COMPOSER_ROOT) $(filter-out $@,$(MAKECMDGOALS))

## drush	:	Executes `drush` command in a specified `DRUPAL_ROOT` directory (default is `/var/www/html/web`).
##		To use "--flag" arguments include them in quotation marks.
##		For example: make drush "watchdog:show --type=cron"
.PHONY: drush
drush:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") drush -r $(DRUPAL_ROOT) $(filter-out $@,$(MAKECMDGOALS))

## logs	:	View containers logs.
##		You can optinally pass an argument with the service name to limit logs
##		logs php	: View `php` container logs.
##		logs nginx php	: View `nginx` and `php` containers logs.
.PHONY: logs
logs:
	@$(DOCKER_COMPOSE_CMD) logs -f $(filter-out $@,$(MAKECMDGOALS))

## xdebug	:	Enable xdebug.
.PHONY: xdebug
xdebug:
	@echo "Enabling xdebug in $(PROJECT_NAME)."
	@echo "¡¡CAUTION!! X-debug will only work if you have correctly configured docker-compose.xdebug.override.yml file."
	$(DOCKER_COMPOSE_CMD) stop php
	$(DOCKER_COMPOSE_CMD) pull php
	$(DOCKER_COMPOSE_CMD) -f docker-compose.yml -f docker-compose.override.yml -f docker-compose.xdebug.override.yml up -d php

## xdebug-disable	:	Disable xdebug.
.PHONY: xdebug-stop
xdebug-stop:
	@echo "Disabling xdebug in $(PROJECT_NAME)."
	$(DOCKER_COMPOSE_CMD) stop php
	$(DOCKER_COMPOSE_CMD) -f docker-compose.yml -f docker-compose.override.yml up -d php

# https://stackoverflow.com/a/6273809/1826109
%:
	@:

include docker.mk

DRUPAL_VER ?= 8
PHP_VER ?= 7.1
BEHAT ?= "vendor/bin/behat"
SITE ?= "default"
# Update this with the base drush alias for your site.
# Example, if your site's drush aliases are contained into mysite.site.yml
# then the default site alias will be "mysite"
DEFAULT_SITE_ALIAS ?= "sitename"


## info	:	Show project info
.PHONY: info
info:
	@scripts/get_info.sh

## test	:	Run Unit tests. Pass the path to a file or directory with the Unit test. Example: make test web/modules/contrib/devel/tests/src/Unit
.PHONY: test
test:
	docker-compose exec php phpunit $(filter-out $@,$(MAKECMDGOALS))

## behat	:	Run project Behat tests
.PHONY: behat
behat:
	docker-compose exec php  ${BEHAT} --colors

## Localtunnel	:	Setup a local tunnel to make the site available
.PHONY: localtunnel
localtunnel:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml -f docker-compose.localtunnel.yml up -d && docker-compose logs localtunnel | grep -Po --color=never "your(.*)?"

## localtunnel-stop	:	Stop the created local tunnel
.PHONY: localtunnel-stop
localtunnel-stop:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml -f docker-compose.localtunnel.yml stop localtunnel && docker-compose -f docker-compose.yml -f docker-compose.override.yml -f docker-compose.localtunnel.yml rm -fsv localtunnel

## frontend	:	Generate frontend assets like compiling scss
.PHONY: frontend
frontend:
	docker-compose exec node sh ${DOCKER_PROJECT_ROOT}/scripts/frontend-build.sh $(filter-out $@,$(MAKECMDGOALS))

## backstopjs-reference	:	Generate BackstopJS reference files
.PHONY: backstopjs-reference
backstopjs-reference:
	docker-compose exec backstopjs backstop reference

## backstopjs-test	:	Run BackstopJS tests
.PHONY: backstopjs-test
backstopjs-test:
	docker-compose exec backstopjs backstop test

## setup	:	Prepares the site and loads it with data from the reference site
.PHONY: setup
setup:
	chmod u+w web/sites/default -R
	cp docker-compose.override.yml.dist docker-compose.override.yml
	cp -n docker-compose.xdebug.override.yml.dist docker-compose.xdebug.override.yml
	cp web/sites/${SITE}/example.settings.local.php web/sites/${SITE}/settings.local.php
	docker-compose up -d
	docker-compose exec -T php composer install
	scripts/reload-local.sh --site=${DEFAULT_SITE_ALIAS}

## setup-from-config	:	Prepares the site and installs it using the Drupal configuration files
.PHONY: setup-from-config
setup-from-config:
		docker-compose exec -T php drush si --existing-config -y
## solr-sync	:	Reload docker Solr cores from local files.
.PHONY: solr-sync
solr-sync:
	./scripts/solr-sync.sh ${PROJECT_NAME} ${SOLR_CONTAINER} ${CORES}

## solr-rebuild	:	Re-creates the Solr core
.PHONY: solr-rebuild
solr-rebuild:
	docker-compose stop solr && docker-compose rm -f solr && docker-compose up -d solr && make solr-sync

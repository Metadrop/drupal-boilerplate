include docker.mk

.PHONY: test

DRUPAL_VER ?= 8
PHP_VER ?= 7.1
BEHAT ?= "vendor/bin/behat"
BEHAT_YML ?= "tests/behat/behat.yml"
SITE ?= "default"
# Update this with the base drush alias for your site.
# Example, if your site's drush aliases are contained into mysite.site.yml
# then the default site alias will be "mysite"
DEFAULT_SITE_ALIAS ?= "mysite"

## test	:	Run project unit tests
test:
	docker-compose exec php phpunit

## behat	:	Run project Behat tests
behat:
	docker-compose exec -u www-data -T php ${BEHAT} --config ${BEHAT_YML} --colors $(params)

## ngrok	:	Setup a ngrok tunnel to make the site available
ngrok:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml -f ci/docker-compose.ngrok.yml up -d && docker-compose exec php curl http://ngrok:4040/api/tunnels | grep -Po "https"://[^\"]+

## ngrok-stop	:	Stop the created ngrok tunnel
ngrok-stop:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml -f ci/docker-compose.ngrok.yml stop ngrok && docker-compose -f docker-compose.yml -f docker-compose.override.yml -f ci/docker-compose.ngrok.yml rm -fsv ngrok

## frontend	:	Generate frontend assets like compiling scss
frontend:
	docker-compose exec node sh ${DOCKER_PROJECT_ROOT}/scripts/frontend-build.sh $(filter-out $@,$(MAKECMDGOALS))

## backstopjs-reference	:	Generate BackstopJS reference files
backstopjs-reference:
	docker-compose exec backstopjs backstop reference

## backstopjs-test	:	Run BackstopJS tests
backstopjs-test:
	docker-compose exec backstopjs backstop test
## setup	:	Prepares the site and loads it with data from the reference site
setup:
	chmod u+w web/sites/default -R
	cp docker-compose.override.yml.dist docker-compose.override.yml
	cp web/sites/${SITE}/example.settings.local.php web/sites/${SITE}/settings.local.php
	docker-compose up -d
	docker-compose exec -T php composer install
	scripts/reload-local.sh --site=${DEFAULT_SITE_ALIAS}

## solr-sync	:	Reload docker Solr cores from local files.
solr-sync:
	./scripts/solr-sync.sh ${PROJECT_NAME} ${SOLR_CONTAINER} ${CORES}

## solr-rebuild	:	Re-creates the Solr core
solr-rebuild:
	docker-compose stop solr && docker-compose rm -f solr && docker-compose up -d solr && make solr-sync

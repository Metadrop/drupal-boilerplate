include docker.mk

.PHONY: test

DRUPAL_VER ?= 8
PHP_VER ?= 7.1
BEHAT ?= "vendor/bin/behat"
BEHAT_YML ?= "tests/behat/behat.yml"

test:
	docker-compose exec php phpunit

behat:
	docker-compose exec -u www-data -T php ${BEHAT} --config ${BEHAT_YML} --colors $(params)

ngrok:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml -f ci/docker-compose.ngrok.yml up -d && docker-compose exec php curl http://ngrok:4040/api/tunnels | grep -Po "https"://[^\"]+

ngrok-stop:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml -f ci/docker-compose.ngrok.yml stop ngrok && docker-compose -f docker-compose.yml -f docker-compose.override.yml -f ci/docker-compose.ngrok.yml rm -fsv ngrok

frontend:
	docker-compose exec node sh ${DOCKER_PROJECT_ROOT}/scripts/frontend-build.sh $(filter-out $@,$(MAKECMDGOALS))

backstopjs-reference:
	docker-compose exec backstopjs backstop reference

backstopjs-test:
	docker-compose exec backstopjs backstop test

setup:
	cp docker-compose.override.yml.dist docker-compose.override.yml
	cp web/sites/default/example.settings.local.php web/sites/default/settings.local.php
	docker-compose up -d
	docker-compose exec -T php composer install
	scripts/reload-local.sh
#docker-compose exec -T php drush si --existing-config -y

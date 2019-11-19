include docker.mk

.PHONY: test

DRUPAL_VER ?= 8
PHP_VER ?= 7.1
BEHAT ?= "vendor/bin/behat"
BEHAT_YML ?= "tests/behat/behat.yml"

test:
	cd ./test/$(DRUPAL_VER) && PHP_VER=$(PHP_VER) ./run

behat:
	docker-compose exec -u www-data -T php ${BEHAT} --config ${BEHAT_YML} --colors $(params)

ngrok:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml -f ci/docker-compose.ngrok.yml up -d && docker-compose exec php curl http://ngrok:4040/api/tunnels | grep -Po "https"://[^\"]+

ngrok-stop:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml -f ci/docker-compose.ngrok.yml stop ngrok && docker-compose -f docker-compose.yml -f docker-compose.override.yml -f ci/docker-compose.ngrok.yml rm -fsv ngrok

## mdrop :	Start mdrop theme with gulp.
mdrop:
	@docker-compose exec node sh scripts/mdrop-start.sh $(filter-out $@,$(MAKECMDGOALS))

# Manual configuration

If you didn't allow the assistant to autoconfigure the project or do want to know which steps are needed this list is for you:

Steps to configure the project:

1. Copy the `.env.example` file to `.env` and edit it to fit your needs.
1. Copy the `drush/sites/sitename.site.yml` file to `drush/sites/<SITENAME>.site.yml` using the proper sitename and edit it.
1. Edit the `behat.yml` file and edit the `example` in the URLs to point to your project's URL. Usually, you have to use the PROJECT_NAME value you have used in the `.env` file.
1. Edit the `tests/backstopjs/backstop_data/engine_scripts/cookies.json` file replacing the `example` string with your project's URL like you have done in the previous step.
1. Copy the `docker-compose.override.yml.dist` file to `docker-compose.override.yml`. Look for the
services.traefik.ports value. There you have the port mapping in the form `<your local machine port>:<container port>`.
Note that WEB_SERVER_PORT is the local machine port which is mapped to point the web server port inside the container.
1. Start containers running `docker-compose up -d` in repository root.
1. To access the site go to URL: http://\<PROJECT_BASE_URL\>:\<WEBSERVER_PORT\>/
1. To access the project's documentation go to URL: http://docs.\<PROJECT_BASE_URL\>:\<WEBSERVER_PORT\>/






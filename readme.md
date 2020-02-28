# Metadrop's Drupal Boilerplate

This repository is a Drupal project that can be setup locally using docker.

## Installation

To create a new project based on this boilerplate, the recommended method is using composer create-project:

```
composer create-project metadrop/drupal-boilerplate:master-dev my-project
```

Then, complete the setup following these steps:

1. Check `.env` file for PROJECT_BASE_URL variable.
2. Check `docker-compose.override.yml` file. Look for the services.traefik.ports value. There you have the port mapping in the form `<your local machine port>:<container port>`. Remember as WEBSERVER_PORT the local machine port that seems to point to a webserver port on the container ports side.
3. Start containers running `docker-compose up -d` in repository root.
4. To access the site go to URL: http://\<PROJECT_BASE_URL\>:\<WEBSERVER_PORT\>/
5. To access the project's documentation go to URL: http://docs.\<PROJECT_BASE_URL\>:\<WEBSERVER_PORT\>/



# Docker containers

Based on [wodby/docker4drupal](https://github.com/wodby/docker4drupal), with some tweaks to speed-up your development.

Docker4Drupal provides many containers ready to be added to your stack. Not only a standard web stack (Nginx or Apache as web server, MariaDB as database server and a PHP engine), it includes other tools like Node.js, PostgreSQL, Varnish, Memcached, Redis, Elasticsearch, Kibana or Solr, among others.

Check the [complete list](https://github.com/wodby/docker4drupal#stack).

## Configuration

The main stack is configured in the `docker-compose.yml`. This file shoudl be committed and contains the main containers of the stack like the web server, database and PHP engine.  To enable more containers uncomment the lines of the desired container to enable.

There is a `docker-compose.override.yml.dist` file including some container definitions like Adminer and MkDocs that are used during local development.
This is done with the purpose of differencing the local environment stack from the stack of other environments.

The `docker-compose.override.yml` is git-ignored.










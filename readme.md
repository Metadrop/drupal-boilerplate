# Metadrop's Drupal Boilerplate

## Introduction
This repository is a Drupal project that can be setup locally using docker.

## Stack
### docker-compose infrastructure
Based on [wodby/docker4drupal](https://github.com/wodby/docker4drupal), with some tweaks to speed-up your development.
The stack is configured as follows:

| Container       | Versions               | Default version | Service name    | Image                              | Enabled by default |
| --------------  | ---------------------- | --------------- | --------------- | ---------------------------------- | ------------------ |
| [Nginx]         | 1.17, 1.16             | 1.17            | `nginx`         | [wodby/nginx]                      | ✓                  |
| [Apache]        | 2.4                    | 2.4             | `apache`        | [wodby/apache]                     |                    |
| [PHP]           | 7.4, 7.3, 7.2          | 7.3`            | `php`           | [wodby/drupal-php]                 | ✓                  |
| [MariaDB]       | 10.4, 10.3, 10.2, 10.1 | 10.4            |` mariadb`       | [wodby/mariadb]                    | ✓                  |
| [PostgreSQL]    | 12, 11, 10, 9.x        | 11              |` postgres`      | [wodby/postgres]                   |                    |
| [Redis]         | 5, 4                   | 4               |` redis`         | [wodby/redis]                      |                    |
| [Memcached]     | 1                      | 1               |` memcached`     | [wodby/memcached]                  |                    |
| [Varnish]       | 6.0, 4.1               | 6.0             |` varnish`       | [wodby/varnish]                    |                    |
| [Node.js]       | 12, 10, 8              | 12              |` node`          | [wodby/node]                       | ✓                  |
| [Drupal node]   | 1.0                    | 1.0             | `drupal-node`   | [wodby/drupal-node]                |                    |
| [Solr]          | 8, 7, 6, 5             | 8               | `solr`          | [wodby/solr]                       |                    |
| [Elasticsearch] | 7, 6                   | 7               | `elasticsearch` | [wodby/elasticsearch]              |                    |
| [Kibana]        | 7, 6                   | 7               |` kibana`        | [wodby/kibana]                     |                    |
| [OpenSMTPD]     | 6.0                    | 6.0             | `opensmtpd`     | [wodby/opensmtpd]                  |                    |
| [Mailhog]       | latest                 | latest          | `mailhog`       | [mailhog/mailhog]                  | ✓                  |
| [AthenaPDF]     | 2.10.0                 | 2.10.0          | `athenapdf`     | [arachnysdocker/athenapdf-service] |                    |
| [Rsyslog]       | latest                 | latest          | `rsyslog`       | [wodby/rsyslog]                    |                    |
| [Blackfire]     | latest                 | latest          | `blackfire`     | [blackfire/blackfire]              |                    |
| [Webgrind]      | 1                      | 1               | `webgrind`      | [wodby/webgrind]                   |                    |
| [Xhprof viewer] | latest                 | latest          | `xhprof`        | [wodby/xhprof]                     |                    |
| Adminer         | 4.6                    | 4.6             | `adminer`       | [wodby/adminer]                    | ✓                  |
| phpMyAdmin      | latest                 | latest          | `pma`           | [phpmyadmin/phpmyadmin]            |                    |
| Selenium chrome | 3.141                  | 3.141           | `chrome`        | [selenium/node-chrome]             | ✓                  |
| Selenium hub    | 3.141                  | 3.141           | `hub   `        | [selenium/hub]                     | ✓                  |
| Portainer       | latest                 | latest          | `portainer`     | [portainer/portainer]              | ✓                  |
| Traefik         | latest                 | latest          | `traefik`       | [_/traefik]                        | ✓                  |
| Mkdocs          | latest                 | latest          | `mkdocs`        | [metadrop/docker-mkdocs]           | ✓                  |

There is a docker-compose.override.yml.dist file including some container definitions like adminer and mkdocs.
This is done with the purpose of differencing the local environment stack from the CI environment stack.
The docker-compose.override.yml is git-ignored so your stack gets clean.


### Drupal project folder structure
The folder structure skafold is based on [drupal-composer/drupal-project](https://github.com/drupal-composer/drupal-project) 
so all your dependencies are managed by composer, drupal is required as [drupal/core](https://github.com/drupal/core) package 
and web-root files are automatically generated via [drupal-scaffold](https://github.com/drupal-composer/drupal-scaffold) composer plugin.

### Drush (Drupal Shell)
Drush is a command line shell for Drupal, and a swiss army knife letting developers
to do mostly everything can be done by user interface, and much more. Drush is delivered
with a excelent code generator to speed-up the development process.

Get more information about drush:
- [Drush marketing site](https://drush.org)
- [Drush official documentation](https://docs.drush.org/en/master/)
- [Drush commands](https://drushcommands.com/drush-9x/)

### Mkdocs documentation manager.
The simplest way to manage your project documentation, written in markdown format, and displayed in a comfortable and 
styled html autogenerated site.
The text-plain markdown format have the following advantages over other systems:
- It's quick to maintain.
- It's supported by version control systems.
- It's reviewable via merge requests.
- It's standard.
- It's free.

[Mkdocs official site](https://www.mkdocs.org/).
    
### Grumphp and (do not) forget about codding standards.
Because quality matters, the metadrop/drupal-boilerplate is delivered with [Grumphp](https://github.com/phpro/grumphp) 
a tool to ensure developers follow the Drupal codding standards and best practices.
To make your projects fit the highest quality assurance, a git-hook is automatically installed so is not possible to 
commit any change without accomplishing those Quality requirements.
Grumphp is already configured (so you don't need to worry about that) making the following quality checks:
- [phplint](https://github.com/overtrue/phplint): Detects PHP files syntax errors.
- yamllint: Detects YAML files syntax errors.
- composer: Perform composer.json and composer.lock validation.
- [jsonlint](https://github.com/Seldaek/jsonlint): Detects json files syntax errors.
- [drupalcheck](https://github.com/mglaman/drupal-check): Check Drupal code for deprecations and discover bugs via static analysis. 
- [phpcpd](https://github.com/sebastianbergmann/phpcpd): Copy/Paste detector to avoid duplicated code. 
- [phpcs](https://github.com/squizlabs/PHP_CodeSniffer): Check if your code accomplish the following standards:
    - Drupal: The [Drupal coding standards](https://www.drupal.org/docs/develop/standards/coding-standards).
    - DrupalPractice: Drupal best practices.

### Behavior Driven Development on natural language with Behat.
Behavior Driven Development is supported on a natural language thanks to [Behat](https://docs.behat.org/en/latest/).
The boilerplate is delivered with Behat preconfigured, so you just need to start writing your tests. Some example tests 
are also provided. Aditionally to behat, some libraries are included improving the drupal support, adding several behat
testing steps for the common scenarios such as logging as a user with a particular role, creating testing content, finding
expressions withing content regions, etc.

Here are the bundled libraries:
- [drupal-extension](https://www.drupal.org/project/drupalextension)
- [nuvoleweb/drupal-behat](https://github.com/nuvoleweb/drupal-behat)
- [metadrop/behat-contexts](https://github.com/metadrop/behat-contexts)

### Unit testing with phpunit
Test Driven Development focus on testing your code to ensure it does what is expected across refactors. This kind of 
tests are known as Unit tests, and in PHP it can be done with (phpunit)[https://phpunit.de/].

PHPUnit is a framework to perform unit tests on your php projects. The boilerplate is bundled with phpunit preconfigured 
so you can focus on write your unit tests. 

### Scripthor toolset
[Scripthor](https://github.com/Metadrop/scripthor) is our set of scripts for our daily routine, to speed up the 
development workflow.

Til today, we provide the following scripts: 
- **reload-local.sh**: Reload your local environment setting everything up for a new developer, a new branch, or just
 to ensure your changes won't break production during the deployment.
- **frontend-build.sh**: Compile your sass and js-es6 files inside docker so you don't need to have node or gulp
 installed on your machine. Forget about version issues.
- **copy-content-config-entity-to-module.sh**: For given content entity (content type, paragraph, custom block type...)
will take the entity definition, all its fields, form configuration and view modes and will copy them to the module of 
your choice.

## Installation

To create a new project based on this boilerplate, the recommended method is using composer create-project:

```
composer create-project metadrop/drupal-boilerplate:master-dev my-project
```

Then, complete the setup following these steps:

1. Copy the `.env.example` file to `.env` and edit it to fit your needs.
2. Copy the `docker-compose.override.yml.dist` file to `docker-compose.override.yml`. Look for the 
services.traefik.ports value. There you have the port mapping in the form `<your local machine port>:<container port>`.
Note that WEB_SERVER_PORT is the local machine port which is mapped to point the web server port inside the container.
3. Start containers running `docker-compose up -d` in repository root.
4. To access the site go to URL: http://\<PROJECT_BASE_URL\>:\<WEBSERVER_PORT\>/
5. To access the project's documentation go to URL: http://docs.\<PROJECT_BASE_URL\>:\<WEBSERVER_PORT\>/

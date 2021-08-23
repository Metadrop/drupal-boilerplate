# Metadrop's Drupal Boilerplate

## Introduction

This repository is a boilerplate to create Drupal 8/9/10 projects faster with a lot tools already preconfigured.

Tools included out-of-the-box:

  - A docker infrastructure.
  - A boilerplate folder structure that fits all project needs.
  - A working and preconfigured Drush, the Drupal shell.
  - MkDocs to document your project using Markdown files.
  - Grumphp to enforce [Drupal coding standards](https://www.drupal.org/docs/develop/standards/coding-standards). It is configured to use [phplint](https://github.com/overtrue/phplint), yamlint,  [jsonlint](https://github.com/Seldaek/jsonlint), [drupalcheck](https://github.com/mglaman/drupal-check), [phpcpd](https://github.com/sebastianbergmann/phpcpd) and [phpcs](https://github.com/squizlabs/PHP_CodeSniffer).



It is based on [Docker4Drupal](https://wodby.com/docs/1.0/stacks/drupal/local/), which uses Docker and Docker Compose. To get all the information about available webservers, databases, PHP versions and other containers check their [wodby/docker4drupa repository](https://github.com/wodby/docker4drupal).

Because it uses Docker under the hood, you can customize whatever you want, add new containers or use any standard Docker funcionality to accomodate your project needs.

## Quickview
![Create project](./create-project.gif)


## Usage

To create a new project based on this boilerplate, the recommended method is using Composer's create-project command:

```
composer create-project  --ignore-platform-reqs metadrop/drupal-boilerplate my-project
```


Once Composer finalizes the project creation an assistant will be autmatically run. It will ask you a few questions:

 - The project name: this a machine name for the project. It will be used for Docker container names, project URL and some other places. Please, use only letters, numbers and underscores.

 - Setup a git repository? If yes, the assistant will initialize a git repository and make the initial commit.

 - Install Drupal? If thes, the assistan will configure and install a Drupal site.

 - Radix sub-theme: the asistant can create a [Radix](https://www.drupal.org/project/radix) subtheme for you. We quite often use Radix as the base theme of our projects. You can skip this and use your own theme, of course.


After the assistant finished, if you have selected to install Drupal your project will be running and the assitant will print the URL to access it.


## Included out-of-the-box

### docker-compose infrastructure

Based on [wodby/docker4drupal](https://github.com/wodby/docker4drupal), with some tweaks to speed-up your development.

The stack is configured as follows:

| Container       | Versions               | Service name    | Image                              | Enabled by default |
| --------------  | ---------------------- | --------------- | ---------------------------------- | ------------------ |
| Nginx           | 1.19, 1.18             | `nginx`         | [wodby/nginx]                      | ✓                  |
| Apache          | 2.4                    | `apache`        | [wodby/apache]                     |                    |
| PHP             | 8.0, 7.4, 7.3, 7.2     | `php`           | [wodby/drupal-php]                 | ✓                  |
| MariaDB         | 10.5, 10.4, 10.3, 10.2 |` mariadb`       | [wodby/mariadb]                    | ✓                  |
| PostgreSQL      | 13, 12, 11, 10, 9.x    |` postgres`      | [wodby/postgres]                   |                    |
| Redis           | 6, 5                   |` redis`         | [wodby/redis]                      |                    |
| Memcached       | 1                      |` memcached`     | [wodby/memcached]                  |                    |
| Varnish         | 6.0, 4.1               |` varnish`       | [wodby/varnish]                    |                    |
| Node.js         | 14, 12, 10             |` node`          | [wodby/node]                       | ✓                  |
| Drupal node     | 1.0                    | `drupal-node`   | [wodby/drupal-node]                |                    |
| Solr            | 8, 7, 6, 5             | `solr`          | [wodby/solr]                       |                    |
| Elasticsearch   | 7, 6                   | `elasticsearch` | [wodby/elasticsearch]              |                    |
| Kibana          | 7, 6                   |` kibana`        | [wodby/kibana]                     |                    |
| OpenSMTPD       | 6.0                    | `opensmtpd`     | [wodby/opensmtpd]                  |                    |
| Mailhog         | latest                 | `mailhog`       | [mailhog/mailhog]                  | ✓                  |
| AthenaPDF       | 2.16.0                 | `athenapdf`     | [arachnysdocker/athenapdf-service] |                    |
| Rsyslog         | latest                 | `rsyslog`       | [wodby/rsyslog]                    |                    |
| Blackfire       | latest                 | `blackfire`     | [blackfire/blackfire]              |                    |
| Webgrind        | 1.8                    | `webgrind`      | [wodby/webgrind]                   |                    |
| Xhprof viewer   | latest                 | `xhprof`        | [wodby/xhprof]                     |                    |
| Adminer         | 4                      | `adminer`       | [wodby/adminer]                    | ✓                  |
| phpMyAdmin      | latest                 | `pma`           | [phpmyadmin/phpmyadmin]            |                    |
| Selenium chrome | 3.141                  | `chrome`        | [selenium/node-chrome]             | ✓                  |
| Selenium hub    | 3.141                  | `hub   `        | [selenium/hub]                     | ✓                  |
| Traefik         | v2.0                   | `traefik`       | [_/traefik]                        | ✓                  |
| Mkdocs          | latest                 | `mkdocs`        | [metadrop/docker-mkdocs]           | ✓                  |
| Portainer       | latest                 | `portainer`     | [portainer/portainer]              | ✓                  |
| BackstopJS      | 4.4                    | `backstopjs`    | [backstopjs/backstopjs]            | ✓                  |

There is a docker-compose.override.yml.dist file including some container definitions like Adminer and MkDocs.
This is done with the purpose of differencing the local environment stack from the stack of other environments.
The docker-compose.override.yml is git-ignored so your stack gets clean.


### Drupal project folder structure
The folder structure scaffold is based on [drupal/recommended-project](https://github.com/drupal/recommended-project), the Drupal's [official recommended method to install Drupal](https://www.drupal.org/docs/develop/using-composer/using-composer-to-install-drupal-and-manage-dependencies#download-core). This way, all your dependencies are managed by Composer, Drupal is required as [drupal/core-recommended](https://github.com/drupal/core-recommended) package and web-root files are automatically generated via [drupal/core-composer-scaffold](https://github.com/drupal/core-composer-scaffold) Composer plugin.



The following folders are added to the folders created by core-composer-scaffold:

  - `backups`: backups are exported here by default. Ignored by Git.
  - `config`: Drupal configuration export/import folder.
  - `drush`: Drush configuration.
  - `reports`: reports from Behat and other tools are exported here.
  - `patches`: patches applied to the project codebase.
  - `scripts`: project scripts.
  - `solr/cores`: Solr core configuration files. Only useful if the project uses Solr.
  - `tests`: files related to porject testing.
    - `behat`: BDD Behat tests.
    - `phpunit`: Unit tests.
    - `backstop`: Backstop visual regression tests.


The codebase is located, as usual, in the  `web` folder. A default site is configured in `web/sites/default`.

#### Drupal settings

Drupal settings for all environments are placed in the `settings.php` file. This file includes a `settings.local.php` if it exists. This local settings file should include any configuration dependent from the environment such the database connection settings.


### Drush (Drupal Shell)

Drush is a command line shell for Drupal, and a swiss army knife letting developers to do mostly everything they can do by user interface, and much more. Drush is delivered
with an excellent code generator to speed-up the development process.

Get more information about drush:
- [Drush marketing site](https://drush.org)
- [Drush official documentation](https://docs.drush.org/en/master/)
- [Drush commands](https://drushcommands.com/drush-9x/)

@TODO: Explain the Drush configuration deployed with this boilerplate.

### Mkdocs documentation manager

The simplest way to manage your project documentation, written in Markdown format, and displayed in a comfortable and styled HTML autogenerated site.

The text-plain Markdown format have the following advantages over other systems:

- It's quick to maintain.
- It's supported by version control systems.
- It's reviewable via merge requests.
- It's standard.
- It's free.

[Mkdocs official site](https://www.mkdocs.org/).

### Grumphp and (do not) forget about coding standards

Because quality matters, the metadrop/drupal-boilerplate is delivered with [Grumphp](https://github.com/phpro/grumphp), a tool to ensure developers follow the Drupal coding standards and best practices.

To make your projects fit the highest quality assurance, a git-hook is automatically installed so is not possible to commit any change without accomplishing those quality requirements (unless you commit bypassing the git hooks).

Grumphp is already configured (so you don't need to worry about that) making the following quality checks:

- [Git commit message](https://github.com/phpro/grumphp/blob/master/doc/tasks/git_commit_message.md):
  - Ensures that the commit message subject line doesn't have a trailing period.
  - Ensures that the commit message subject match with `Issue #[0-9]: Subject` format.
  - Max subject width 130.

- [phplint](https://github.com/overtrue/phplint): Detects PHP files syntax errors.
- yamllint: Detects YAML files syntax errors.
- composer: Perform `composer.json` and `composer.lock` validation.
- [jsonlint](https://github.com/Seldaek/jsonlint): Detects JSON files syntax errors.
- [drupalcheck](https://github.com/mglaman/drupal-check): Check Drupal code for deprecations and discover bugs via static analysis.
- [phpcpd](https://github.com/sebastianbergmann/phpcpd): Copy/paste detector to avoid duplicated code.
- [phpcs](https://github.com/squizlabs/PHP_CodeSniffer): Check if your code accomplish the following standards:
    - Drupal: The [Drupal coding standards](https://www.drupal.org/docs/develop/standards/coding-standards).
    - DrupalPractice: Drupal best practices. @TODO: Is this in place?

### Phpqa

If you want use the static analysis tools manually or you need to add it to your continuous integration system there is a phpqa configuration for it.

To run it, just run:

```
docker-compose exec php phpqa
```

@TODO: Give more details. How is this different from using Grumphp?

### Behavior Driven Development on natural language with Behat

Behavior Driven Development is supported on a natural language thanks to [Behat](https://docs.behat.org/en/latest/).
The boilerplate is delivered with Behat preconfigured, so you just need to start writing your tests. Some example tests
are also provided. Aditionally to Behat, some libraries are included improving the Drupal support, adding several Behat
testing steps for the most common use cases such as logging as a user with a particular role, creating testing content, finding
expressions within content regions, etc.

Here are the bundled libraries:
- [drupal-extension](https://www.drupal.org/project/drupalextension)
- [nuvoleweb/drupal-behat](https://github.com/nuvoleweb/drupal-behat)
- [metadrop/behat-contexts](https://github.com/metadrop/behat-contexts)

#### Run Behat tests

If you want to execute every Behat tests just run:

```
docker-compose exec php behat
```

### Unit testing with phpunit

Test Driven Development focus on testing your code to ensure it does what is expected across refactors. This kind of
tests are known as unit tests, and in PHP can be implemented with [phpunit](https://phpunit.de/).

PHPUnit is a framework to perform unit tests on your PHP projects. The boilerplate is bundled with PHPUnit preconfigured
so you can focus on write your unit tests.

### Scripthor toolset

[Scripthor](https://github.com/Metadrop/scripthor) is our set of scripts for our daily routine, to speed up the
development workflow.

Til today, we provide the following scripts:
- **reload-local.sh**: Reload your local environment setting everything up for a new developer, a new branch, or just
  to ensure your changes won't break production during the deployment.
- **frontend-build.sh**: Compile your sass and js-es6 files inside docker so you don't need to have node or gulp
  installed on your machine. Forget about version issues.
- **copy-content-config-entity-to-module.sh**: For a given content entity (content type, paragraph, custom block type...)
  it will take the entity definition, all its fields, form configuration and view modes and will copy them to the module of
  your choice.
- **backup.sh**: Perform a full backup of the site, db and files.
- **setup-traefik-port.sh** Get the port generated by trefik and bulk it on .env.
- **update-helper.sh** Allows to update and commit drupal modules and dependencies.
- **solr-sync.sh** Reload docker solr cores from local files.

### Solr


Although the Solr container is not enabled by default, some commands to manage the Solr server are provided.

  - Core configuration sync: recreates the Solr core using the core configuration files from project.

    ```
    make solr-sync:
    ```

 -  Rebuild Solr server: sometimes Solr server needs to be completely recreated. This means completely delete and recreate the container and associated a data, a run the core configuration sync task to recreate the cores as well. To do so, run the following command:

    ```
    make solr-rebuild
    ```


### Backstopjs

[BackstopJS](https://github.com/garris/BackstopJS) automates visual regression testing of your responsive web UI by comparing DOM screenshots over time.

* [Documentation](https://github.com/garris/BackstopJS#using-backstopjs)

* Generate references:

      make backstopjs-reference

* Run regressions tests:

      make backstopjs-test

### Buffet of selected modules

We are updating or selection of required modules to ensure you won't forget anything. The modules bundled will solve
the needs of different areas such as SEO, security, content editing, themming or deployments across different environments.

### Stylelint CSS

[Stylelint](https://stylelint.io/) is a modern linter that helps you avoid errors and enforce conventions in your styles.


#### Installation

* Install stylelint as dependency on your custom theme folder:

      npm i stylelint --save-dev

* Install stylelint scss plugin, if you use sass

      npm i stylelint-scss --save-dev

* Install stylelint mix plugin in order to use it with webpack.

      npm i laravel-mix-stylelint --save-dev

* Create .stylelintrc.yml file with your [stylelint rules](https://stylelint.io/developer-guide/rules). For a reference, these
are [Metadrop's](https://gitlab.com/-/snippets/2067128).

* Run stylelint checker

      npx stylelint 'src/**/*.scss'

##### Run from npm

You can run stylelint from npm

Add to the package.json the following script:

```json
  "scripts": {
    "css:lint": "npx stylelint 'src/**/*.scss'"
  }
```

Then execute the following command

```bash
npm run css:lint
```

##### Run using Laravel Mix

Radix uses Laravel Mix, a wrapper around Webpack for common build processes.
You can add stylelint to your `webpack.mix.js` on your Radix subtheme.

Install webpack stylelint plugin:

```bash
npm i stylelint-webpack-plugin --save-dev
```

Then add the following lines to the webpack file.

```js
const stylelint = require('laravel-mix-stylelint');
mix
  .stylelint({
    configFile: path.join(__dirname, '.stylelintrc.yml'),
    context: './src',
    failOnError: false,
    files: ['**/*.scss']
  })
```

## Manual configuration

If you didn't allow the assistant to autoconfigure the project or do want to know which steps are needed this is list is for you:

Steps to configure the project:

1. Copy the `.env.example` file to `.env` and edit it to fit your needs.
1. Copy the `docker-compose.override.yml.dist` file to `docker-compose.override.yml`. Look for the
services.traefik.ports value. There you have the port mapping in the form `<your local machine port>:<container port>`.
Note that WEB_SERVER_PORT is the local machine port which is mapped to point the web server port inside the container.
1. Start containers running `docker-compose up -d` in repository root.
1. To access the site go to URL: http://\<PROJECT_BASE_URL\>:\<WEBSERVER_PORT\>/
1. To access the project's documentation go to URL: http://docs.\<PROJECT_BASE_URL\>:\<WEBSERVER_PORT\>/
1. (Optional) In the case you need access to remote environments inside PHP container, uncomment these lines at docker-compose.override.yml:
```yaml
#  php:
#    environment:
#      SSH_AUTH_SOCK: /ssh-agent
...
#    volumes:
#      - $SSH_AUTH_SOCK:/ssh-agent
```


## Additions from Docker4Drupal

### `.env` file

Added several variables:


@TODO:
 - DOCKER_PROJECT_ROOT:
 - THEME_PATH:
 - NPM_RUN_COMMAND:
 - DEFAULT_DRUSH_ALIAS:



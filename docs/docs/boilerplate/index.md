# Metadrop boilerplate

This project is built using [Metadrop's Boilerplate](https://github.com/Metadrop/drupal-boilerplate). In this section you cand fin all the information about the boilerplate, what tools are included and how to use them.



## General overview

This repository is a complete Drupal project that can be run locally using Docker based on [Wodby](https://wodby.com/)'s [Docker4Drupal](https://wodby.com/docs/1.0/stacks/drupal/local/).



## Provided tools

It provides the following tools:

  - Infrastrucure:
    - [Folder structure](folders.md): How to organize code, configuration and other files.
    - [Docker webstack containers](containers.md)
  - Additional containers:
    - Adminer: Database web interface.
    - Portanier: Docker web interface.
    - Mailhog: Captures outgoing mails so they can be reviewed during development.
    - [Solr](solr.md): A search engine (not enabled by default).
  - Developing tools:
    - [Drush](drush.md): The Drupal Shell, control Drupal from the command line.
    - [Grumphp](grumphp.md): Review code when committing.
    - [Phpqa](phpqa.md): Code statical analysis.
    - [Stylelint](stylelint.md): Check CSS files.
    - [Scripthor](scripthor.md): Scripts to help developing a Drupal site.
    - Xdebug: Allows to debug and profile PHP requests. @TODO: Add instructions to enable it.
  - Testing tools:
    - [Behat](behat.md): Behavior Driven Development easily!
    - [PHPUnit](phpunit.md): Unit testing framework.
    - [BackstopJS](backstopjs.md): Visual regression testing.
    - [Pally](pa11y.md): Accessibility testing tool.
    - [Lighthouse](lighthouse.md): Performance, SEO, PWA tests and more.
  - Documentation:
    - [MkDocs](mkdocs.md): Documentation on Markdown.
  - Helpers:
    - [Makefiles](makefiles.md): Most used actions as `make` commands.



## How it works?

Docker4Drupal is used to create a set of Docker containers to run the Drupal site. This includes the PHP engine, a webserver and a database server, among others.

A base composer.json is included. This file contains all the needed PHP packages to for a Drupal site.

With those two items you can run a Drupal site. However, this boilerplate aims to provide a lot of tools ready to be used. Each tool needs a different configuration, so this boilerplate includes all the configuration files for each tools already preconfigured. See each tool link in the [Provided tools](index.md#provided-tools) section to get more information on the configuration of each tool.

Because there are many tools available and it is hard to remember all the commands needed to use all of them, the boilerplate provides commands in the form of `make` commands for all the common and frequent actions. Try `make help` from the repository root.

Finally, all the tools use their standard configuration hand handling mechanism, so you don't have to learn any syntax or tool. If you need to modify or customize any tool just use the standard way the tools provides.


## Technical decisions

This boilerplate takes some technical decisions. Sometimes there are several ways to achieve something, and this boilerplate has an opinion on some of them.

### Drupal settings

For the Drupal settings, this boilerplate

Drupal settings for all environments are placed in the `settings.php` file. Hence, this file should be committed.

This `settings.php`, when read by Drupal, includes file includes a `settings.local.php` if it exists. This local settings file should include any configuration dependent from the environment such the database connection settings. This file must not be committed.

### Buffet of selected modules

This boilerplate provides a selection of Drupal modules. The modules bundled will solve the needs of different areas such as SEO, security, content editing, theming or deployments across different environments.

However, you may find some of them not needed for your setup, you may prefer other approach or any other reason. In that case, you can just remove them using composer. The boilerplate is not tied to any of the provided modules.

### Additions from Docker4Drupal

### `.env` file

Some variables have been added:

 - DOCKER_PROJECT_ROOT: Points to the root of the Drupal codebase in the PHP container. Used by commands in the Makefiles. Usually, you don't need to change it.
 - THEME_PATH: Points to the custom theme  of the Drupal codebase in the PHP container. Used by the Node.js container to build the frontend assets. It is automatically set if you instructed the wizard to generate a Radix subtheme. Usually, you don't need to change it (unless you didn't create the subtheme using the wizard).
 - NPM_RUN_COMMAND: Default parameter to pass to the rebuild frontend assets. Usually, you don't need to change it.
 - DEFAULT_DRUSH_ALIAS: When the local environment is reloaded, the boilerplate tries to reload data from a remote environment. This is the default Drush alias used for it. You may need to customize to fit your needs.

### Access remote environments from the PHP container

Probably, you will need access to remote environments inside PHP container. For example, when running `drush sql-sync` from inside the PHP container. In this case, you may want the PHP container to use your own SSH keys. This is available, but disabled by default. To enable it, uncomment these lines in the `docker-compose.override.yml` file:

```yaml
#  php:
#    environment:
#      SSH_AUTH_SOCK: /ssh-agent
...
#    volumes:
#      - $SSH_AUTH_SOCK:/ssh-agent
```

This configures Docker to mount your local SSH agent socket into the PHP container, allowing the container to use your SSH keys.

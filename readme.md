# Metadrop's Drupal Boilerplate

## Important notice

This project has reached the end of its life and is now obsolete. 
We are no longer providing updates or support.

Please consider using [DDEV Aljibe](https://github.com/Metadrop/ddev-aljibe/).

## Introduction

This repository is a boilerplate to create Drupal 8/9/10 projects with many tools already preconfigured with minimal effort. You can have a Drupal site running in your local in less than 3 minutes.

Tools included out-of-the-box:

  - A Docker infrastructure.
  - A boilerplate folder structure that fits all project needs.
  - A working and preconfigured Drush, the Drupal shell.
  - MkDocs to document your project using Markdown files.
  - Grumphp to enforce [Drupal coding standards](https://www.drupal.org/docs/develop/standards/coding-standards). It is configured to use [phplint](https://github.com/overtrue/phplint), yamlint,  [jsonlint](https://github.com/Seldaek/jsonlint), [drupalcheck](https://github.com/mglaman/drupal-check) and [phpcs](https://github.com/squizlabs/PHP_CodeSniffer).
  - Phpqa for static analysis.
  - Behat BDD testing configured and working.
  - PHPUnit for unit testing configured and working.
  - [BackstopJS](https://github.com/garris/BackstopJS) for visual regression testing.
  - [Stylelint](https://stylelint.io/) for checking style files.
  - [Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/) for checking performance, accessibility, PWA, SEO and more.
  - [Pa11y](https://pa11y.org) for in-depth accessibility checks.
  - [Scripthor](https://github.com/Metadrop/scripthor) toolset with some helper scripts for development.
  - Optionally, a Solr container ready to be used by Drupal.

It is based on [Docker4Drupal](https://wodby.com/docs/1.0/stacks/drupal/local/), which uses Docker and Docker Compose. To get all the information about available webservers, databases, PHP versions and other containers check their [wodby/docker4drupa repository](https://github.com/wodby/docker4drupal).

Because it uses Docker under the hood, you can customize whatever you want, add new containers or use any standard Docker functionality to accommodate your project needs.

## Quickview

https://github.com/Metadrop/drupal-boilerplate/assets/776453/2b3d53c6-e2bf-4c48-87a0-2e2fdd66db1d

## Requisites

 - [Docker](https://docs.docker.com/get-docker/)
 - [Docker Compose](https://docs.docker.com/compose/install/), version [V2](https://www.docker.com/blog/announcing-compose-v2-general-availability/).

 **Optionally**

 - Python 3 with PyYAML installed for the `make info` command

## Usage

To create a new project based on this boilerplate, the recommended method is using Composer's create-project command:

```
composer create-project  --ignore-platform-reqs metadrop/drupal-boilerplate my-project
```

Depending in the Drupal release you want you should use a different branch.



| Drupal release	| Boilerplate branch 	| Example command	|
|---	|---	|---	|
| 10.x | 3.x branch | composer create-project  --ignore-platform-reqs metadrop/drupal-boilerplate my-project     	|
| 9.x  | 2.x branch | composer create-project  --ignore-platform-reqs metadrop/drupal-boilerplate:^2 my-project 	|


NOTE: 2.x branch is minimally maintained because Drupal9 support ends November, 2023.


Because this boilerplate uses drupal/core-recommended under the hood you will get an updated release of the chosen core.


Once Composer finalizes the project creation an assistant will be automatically run. It will ask you a few questions:

 - The project name: this a machine name for the project. It will be used for Docker container names, project URL and some other places. Please, use only letters, numbers and underscores.

 - Setup a git repository? If yes, the assistant will initialize a git repository and make the initial commit.

 - Install Drupal? If yes, the assistant will configure and install a Drupal site.

 - Radix sub-theme: the assistant can create a [Radix](https://www.drupal.org/project/radix) subtheme for you. We quite often use Radix as the base theme of our projects. You can skip this and use your own theme, of course.


After the assistant finished, if you have selected to install Drupal your project will be running and the assistant will print the URL to access it.

!!! NOTE
    By default, drupal-boilerplate is installed with a minimal profile. If you want to install another profile, you must not install Drupal during the composer create-project installation problem, when the question 'Do you want to install Drupal?' appears.

After that, just install the profile you need with the `drush site-install` command into the PHP container, after the project creation has finished.

Example:

```
   drush site-install standard
```

Please note that if you install a profile that implements the hook_install the `make setup` command won't work as it makes a installation from configuration, and those installations requires the hook install to not be present.


## FAQ


### Is this for me?

This boilerplate is a good choice for medium to advanced users that want to have a full local environment with a complete set of tools ready to use for their Drupal projects in matter of minutes. However, you should be comfortable using Docker, Drush and another tools without a managing layer like DDEV provides.


### Why not Lando/DDEV/whatever?

We love them! However, we have had some issues trying to adapt them to a certain edge case projects. Those tools allows to handle complex topics like docker thanks to a managing layer. However, that layer imposes some limits. It is not easy to hit them, but when you do it is a hard limit. That's when this boilerplate can be helpful.

## Troubleshoting

### 'make info' command doesn't work

Python 3 with PyYML installed is needed.

### Unit tests are not working

You may encounter several errors when running the `make test` command. For example:

```
PHP Fatal error:  Declaration of Drupal\Tests\ultimate_cron\Kernel\UltimateCronQueueTest::setUp() must be compatible with Drupal\Tests\system\Kernel\System\CronQueueTest::setUp(): void in /var/www/html/web/modules/contrib/ultimate_cron/tests/src/Kernel/UltimateCronQueueTest.php on line 26
```

Or

```
Fatal error: Uncaught Error: Class 'Drupal\Tests\group\Functional\GroupBrowserTestBase' not found in /var/www/html/web/modules/contrib/webform/modules/webform_group/tests/src/Functional/WebformGroupBrowserTestBase.php:13
```

This is due `make test`tries to run all Unit tests and some modules have issues. For example, first error comes from this issue "[Kernel test not compatible with core [9.x]](https://www.drupal.org/project/ultimate_cron/issues/3208608)", while second error is handled on this other issue: "[Group Testing Fails in PHPUnit for Webform Group submodule](https://www.drupal.org/project/webform/issues/3132204)".

If you want to run all tests you need to address all those issues. But what for? You probably just want to run the test from a certain module. For that, just pass the proper path in the `make` command, like this:

```
make test web/modules/contrib/devel/tests/src/Unit
```

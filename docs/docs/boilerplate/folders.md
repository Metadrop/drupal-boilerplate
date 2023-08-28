# Folder structure


The folder structure scaffold is based on [drupal/recommended-project](https://github.com/drupal/recommended-project), the Drupal's [official recommended method to install Drupal](https://www.drupal.org/docs/develop/using-composer/using-composer-to-install-drupal-and-manage-dependencies#download-core). This way, all your dependencies are managed by Composer, Drupal is required as [drupal/core-recommended](https://github.com/drupal/core-recommended) package and web-root files are automatically generated via [drupal/core-composer-scaffold](https://github.com/drupal/core-composer-scaffold) Composer plugin.


The codebase is located, as usual, in the  `web` folder. A default site is configured in `web/sites/default`.

The project uses the following folders:


  - `backups/`: default folder to export backups (using [Scripthor's backup script](https://github.com/Metadrop/scripthor/blob/fb-backup-script/README.md#backup-sh)).
  - `docs/`: project documentation using MkDocs.
  - `config/`: folder to store the Drupal configuration files. Configuration export and import is done from/to this folder.
    - `default/`: global configuration (all environments, and all sites if this is a multisite project).
    - `envs/`: per environment configuration. The [Configuration Split module](https://www.drupal.org/project/config_split) needs to be configured to use these folders.
        - `local/`: local environment configuration.
        - `dev/`: development environment configuration.
        - ...
    - `site/`: per site configuration for multisite setups. You can add per site and per env configuration if needed. The [Configuration Split module](https://www.drupal.org/project/config_split) needs to be configured to use these folders.
        - `site1/`
            - `envs/`
                - `local/`
                - `prod/`
                - ...
        - `site2/`
        - ...
        - `siteN/`

  - `drush/`: Drush configurations. See [Drush section](drush.md).

  - `patches/`: Folder to store project's patches.

    - `custom/`: Custom patches that are not published. Used when a very specific modification is needed that no other project will benefit from. Usually is best to contribute patches.

    - `contrib/`: Contributed patches. You can link patches from its URL in composer.json or download them here and link using the file path.

  - `private-files/`: It contains the Drupal private files. Private files should not be stored under the website's docroot so they are stored here.

  - `public-html/`: Web server docroot. Initially, this is a symlink to web `web` folder.

  - `reports/`: Any tool that generates reports will place them here.

  - `scripts/`: Project's scripts. Initially, it contains scripts from [Scripthor](https://github.com/Metadrop/scripthor/) but any needed script can be added here.

  - `solr/cores/`: Solr cores can be customized using configuration files. In this folder those configuration can be stored.

  - `tests/`: Project tests. UPDATE! This doesn't match the current structure!

    - `behat/`: Behat tests and helper code.

    - `phpunit/`: Unit tests.

    - `backstop/`: Visual regression tests.

  - `tmp/`: Folder for any temporal files. Ignored by git.

  - `vendor/`: Composer's vendor folder.

  - `web/`: Drupal root.

    - `sites/default/`: default Drupal site.

      - `settings.php`: main settings with common settings for all environments. It should be committed to git.

      - `settings.local.php`: Environment specific settings like database credentials or enabled config splits. Ignored by git.

      - `example.settings.local.php`: settings local example file.

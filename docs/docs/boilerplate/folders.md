# Folder structure

The projects uses the following folders:

 - backups/: default folder to export backups (using [Scripthor's backup script](https://github.com/Metadrop/scripthor/blob/fb-backup-script/README.md#backup-sh)).

 - config/: folder to store the Drupal configuration files. Configuration export and import is done from/to this folder.

   - default/: global site configuration.

   - envs/: per environment configuration. The [Configuration Split module](https://www.drupal.org/project/config_split) needs to be configured to use these folders.

     - local/: local environment configuration.

     - ...

   - site/: per site configuration for multisite setups. You can add per site and per env configuration if needed.

     - site1/

       - envs/

         - local/

         - prod/

         - ...

     - site2/

     - ...

 - drush/: Drush configurations. See [Drush section](@TODO).

 - patches/: Folder to store project's patches.

   - custom/: Custom patches that are not published. Used when a very specific modification is needed that no other project will benefit from. Usually is best to contribute patches.

   - contrib/: Contributed patches. You can link patches from its URL in composer.json or download them here and link using the file path.

 - private-files/: It contains the Drupal private files. Private files should not be stored under the website's docroot so they are stored here.

 - public-html/: Web server docroot. Initially, this is a symlink to web `web` folder.

 - reports/: Any tool that generates reports will place them here.

 - scripts/: Project's scripts. Initially, it contains scripts from [Scripthor](https://github.com/Metadrop/scripthor/) but any needed script can be added here.

 - solr/cores/: Solr cores can be customized using configuration files. In this folder those configuration can be stored.

 - tests/: Project tests.

   - behat/: Behat tests and helper code.

   - phpunit/: Unit tests.

   - backstop/: Visual regression tests.

  - tmp/: Folder for any temporal files. Ignored by git.

  - vendor/: Composer's vendor folder.

  - web/: Drupal root.

    - sites/default/: default Drupal site.

      - settings.php: main settings with common settings for all environments. It should be committed to git.

      - settings.local.php: Environment specific settings like database credentials or enabled config splits. Ignored by git.

      - example.settings.local.php: settings local example file.

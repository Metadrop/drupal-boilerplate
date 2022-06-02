# Drush (Drupal Shell)

Drush is a command line shell for Drupal, and a Swiss army knife letting developers to do mostly everything they can do by user interface, and much more. Drush is delivered
with an excellent code generator to speed-up the development process.

Get more information about Drush:

- [Official documentation](https://www.drush.org/)

- [Drush commands](https://www.drush.org/latest/commands/all/)

- [Drush Github repository](https://github.com/drush-ops/drush/)




## Drush preconfiguration


This boilerplate adds some configuration to Drush on the `drush/` folder.

Drush is preconfigured to:

  - Skip cache table content on dumps.

  - Forbid write operations on the @prod environment (sql-sync and rsync).

  - Encourage Composer usage instead of using Drush to manage module code.

  - Sanitize passwords using `password` as password during SQL sync operations. Edit `drush/drush.yml` to use a less obvious value. See [drush.yml example file](https://www.drush.org/latest/examples/example.drush.yml/) to modify or add more configuration.



The file `drush/sites/site.site.yml` is an example of a Drush alias file. Extend it to cover your project's needs, usually adding the different available environments. See [Site aliases](https://www.drush.org/latest/site-aliases/) section from Drush help.






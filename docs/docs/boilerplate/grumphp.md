# Grumphp and (do not) forget about coding standards

Because quality matters, the metadrop/drupal-boilerplate is delivered with [Grumphp](https://github.com/phpro/grumphp), a tool to ensure developers follow the Drupal coding standards and best practices.

To make your projects fit the highest quality assurance, a git-hook is automatically installed so is not possible to commit any change without accomplishing those quality requirements (unless you commit bypassing the git hooks).

Grumphp is already configured (so you don't need to worry about that) making the following quality checks:

- [Git commit message](https://github.com/phpro/grumphp/blob/master/doc/tasks/git_commit_message.md):
  - Ensures that the commit message subject line doesn't have a trailing period.
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



## Configuration


Configuration is done in the `grumphp.yml` file. Check [GrumPHP repository](https://github.com/phpro/grumphp) for documentation.

By deafult, it only analizes custom folders (`./docroot/**/custom`).

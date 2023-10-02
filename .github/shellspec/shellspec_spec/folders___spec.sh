Describe 'Boilerplate folder structure' folders

  It 'has main boilerplate folders'

    The path 'backups' should be directory
    The path 'config' should be directory
    The path 'docs' should be directory
    The path 'drush' should be directory
    The path 'patches' should be directory
    The path 'private-files' should be directory
    The path 'reports' should be directory
    The path 'scripts' should be directory
    The path 'solr/cores' should be directory
    The path 'tests/common' should be directory
    The path 'tests/environment' should be directory
    The path 'tests/functional' should be directory
    The path 'tmp' should be directory
    The path 'vendor' should be directory
    The path 'web' should be directory
  End

  It 'has main boilerplate files'
    The path 'composer.json' should be file
    The path 'behat.yml' should be file
    The path 'docker-compose.yml' should be file
    The path "docker-compose.override.yml" should be file
    The path "web/sites/default/settings.local.php" should be file
  End

  It 'has main boilerplate symlinks'

    The path 'public_html' should be symlink
    The path 'docroot' should be symlink
  End



End

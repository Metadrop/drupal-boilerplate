Describe 'Boilerplate folder structure'
  It ''
    When call ls -la
    The output should include 'web'
    The output should include 'vendor'
    The output should include 'docs'
    The output should include 'drush'
    The output should include 'composer.json'
    The output should include 'behat.yml'
    The output should include 'docker-compose.yml'
    The output should include "docker-compose.override.yml"
  End
End

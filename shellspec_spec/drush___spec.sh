Describe 'Drush' drush

  It 'is installed and can be run'
    When run command make drush
    The status should be success
    The output should include "Drush Commandline Tool"
  End

  It 'has access to the Drupal database'
    When run command make drush status
    The status should be success
    The output should include "Database         : Connected"
  End

  # Make sure drush can access a full boostrapped Drupal.
  It 'can generate one-time login links'
    When run command make drush uli
    The status should be success
    The output should include "http://"
    The output should include "/user/reset/1/"
  End
End


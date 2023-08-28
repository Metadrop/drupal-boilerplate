Describe 'Behat' behat

  It 'is installed and can be run'
    When run command make behat
    The status should be success
    The output should include "Goutte driver works"
    The output should include "Selenium driver works"
  End


End


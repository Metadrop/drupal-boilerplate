Describe 'Pa11y' accessibility

  It 'is installed and can be run'
    When run command make pa11y http://apache
    The status should be success
    The output should include "Welcome to Pa11y"
    The output should include "No issues found!"
  End

End

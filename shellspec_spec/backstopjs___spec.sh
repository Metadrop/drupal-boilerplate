Describe 'BackstopJS' backstopjs

  It 'is installed and can be run'
    When run command docker-compose exec -T backstopjs backstop
    The status should be success
    The output should include "Welcome to BackstopJS"
  End

  It 'can create reference images'
    When run command make backstopjs-reference
    The status should be success
    The output should include "BackstopJS"
    The output should include "CREATING NEW REFERENCE FILE"
    The output should include 'Command "reference" successfully executed'
  End

  It 'can compare site with reference images'
    When run command make backstopjs-test
    The status should be success
    The output should include "BackstopJS"
    The output should include 'Command "test" successfully executed'
  End
End


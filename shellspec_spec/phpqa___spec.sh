Describe 'Phpqa' phpqa static-code-analisys

  It 'has its configuration file in place'
    The path '.phpqa.yml' should be file
  End

  It 'should detect no errors'
    When run command docker-compose exec php phpqa
    The status should be success
    The output should include 'No failed tools'
    The error should not include 'This is a dummy text to discard standard error output'
  End
End

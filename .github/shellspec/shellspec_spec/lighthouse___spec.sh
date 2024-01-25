Describe 'Lighthouse' lighthouse

  It 'is installed and can be run'
    When run command make lighthouse
    The status should be success
    The output should include "Healthcheck passed!"
    The output should include "Done running Lighthouse!"
    The path 'reports/lighthouse/_.report.html' should be file
    The path 'reports/lighthouse/_.report.json' should be file
    The path 'reports/lighthouse/manifest.json' should be file
  End

End

Feature:
  As a Developer
  I want to run Behat tests
  So that I can enjoy BDD!

  @behat
  Scenario: Goutte driver works
    Given I go to "/"
    Then the response status code should be 200

  @behat @javascript
  Scenario: Selenium driver works
    Given I go to "/"
    Then I should see "Log in"

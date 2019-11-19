Feature:
  As a Developer
  I want to run Behat tests
  So that I can enjoy BDD!

  @behat
  Scenario: Homepage
    Given I go to "/"
    Then the response status code should be 200

  @behat @javascript
  Scenario: Homepage with JavaScript
    Given I go to "/"
    Then I should see "Home"

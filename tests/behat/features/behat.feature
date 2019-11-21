Feature:
  As a Developer
  I want to run Behat tests
  So that I can enjoy BDD!

  @behat
  Scenario: Pagina principal
    Given I go to "/"
    Then the response status code should be 200

  @behat @javascript
  Scenario: Pagina principal con JS
    Given I go to "/"
    Then I should see "Home"

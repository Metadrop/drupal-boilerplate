Feature: As a user
  I want to create a Article
  So that I can build the site

  @sunnyday @api @article @create @administrator
  Scenario Outline: Simple Article creation
    Given I am logged in as a user with the <role> role
    When I go to "/node/add/article"
    Then I fill in "Title" with "Behat Test"
    And I press "Save"
    Then I should see "Behat Test"

    Examples:
      | role           |
      | administrator  |


  @error @api @article @create @validation @administrator
  Scenario Outline: Simple Article creation validation
    Given I am logged in as a user with the <role> role
    When I go to "/node/add/article"
    And I press "Save"
    And I should see "Title field is required."

    Examples:
      | role           |
      | administrator  |


  @error @api @article @create @anonymous
  Scenario: Simple Article creation anonymous access
    Given I am an anonymous user
    When I go to "/node/add/article"
    Then the response status code should be 403

  @error @api @article @create @authenticated
  Scenario Outline: Simple Article creation authenticated access
    When I go to "/node/add/article"
    Then the response status code should be 403

    Examples:
      | role           |
      | authenticated  |

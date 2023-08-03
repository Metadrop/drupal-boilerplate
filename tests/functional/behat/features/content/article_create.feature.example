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


  @error @api @article @create @authenticated @anonymous
  Scenario Outline: Simple Article creation role access
    Given I am a user with <role> role
    When I go to "/node/add/article"
    Then the response status code should be 403

    Examples:
      | role           |
      | anonymous      |
      | authenticated  |

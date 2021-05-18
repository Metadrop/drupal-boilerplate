Feature: As a user
  I want to create a Page
  So that I can build the site

  @sunnyday @api @page @create @administrator
  Scenario Outline: Simple Page creation
    Given I am logged in as a user with the <role> role
    When I go to "/node/add/page"
    Then I fill in "Title" with "Behat Test"
    And I press "Save"
    Then I should see "Behat Test"

    Examples:
      | role           |
      | administrator  |


  @error @api @page @create @validation @administrator
  Scenario Outline: Simple Page creation validation
    Given I am logged in as a user with the <role> role
    When I go to "/node/add/page"
    And I press "Save"
    And I should see "Title field is required."

    Examples:
      | role           |
      | administrator  |


  @error @api @page @create @authenticated @anonymous
  Scenario Outline: Simple Page creation role access
    Given I am a user with <role> role
    When I go to "/node/add/page"
    Then the response status code should be 403

    Examples:
      | role           |
      | anonymous      |
      | authenticated  |

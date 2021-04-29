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


  @error @api @page @create @anonymous
  Scenario: Simple Page creation anonymous access
    Given I am an anonymous user
    When I go to "/node/add/page"
    Then the response status code should be 403

  @error @api @page @create @authenticated
  Scenario Outline: Simple Page creation authenticated access
    When I go to "/node/add/page"
    Then the response status code should be 403

    Examples:
      | role           |
      | authenticated  |

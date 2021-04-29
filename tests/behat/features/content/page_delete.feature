Feature: As a user
  I want to delete a Page
  So that I can remove it

  Background:
    Given "page" content:
      | title           |
      | Behat page test |


  @sunnyday @api @javascript @page @delete @administrator
  Scenario Outline: Simple Page delete
    Given I am logged in as a user with the <role> role
    When I go to "delete" of the "node" entity with label "Behat page test"
    Then I should see "This action cannot be undone."
    Then I should see "Delete"
    When I press the "Delete" button
    Then I should see the message "The Basic page Behat page test has been deleted"

    Examples:
      | role           |
      | administrator  |


  @error @api @page @delete @anonymous
  Scenario: Simple Page delete anonymous access
    Given I am an anonymous user
    When I go to "delete" of the "node" entity with label "Behat page test"
    Then the response status code should be 403

  @error @api @page @delete @authenticated
  Scenario Outline: Simple Page delete authenticated access
    Given I am logged in as a user with the <role> role
    When I go to "delete" of the "node" entity with label "Behat page test"
    Then the response status code should be 403

    Examples:
      | role           |
      | authenticated  |

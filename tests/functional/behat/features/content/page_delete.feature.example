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
    Then I should see "The Basic page Behat page test has been deleted"

    Examples:
      | role           |
      | administrator  |

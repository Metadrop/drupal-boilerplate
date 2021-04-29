Feature: As a user
  I want to view a Page
  So that I can see it

  Background:
    Given "page" content:
      | title           |
      | Behat page test |


  @sunnyday @api @page @view @administrator @authenticated
  Scenario Outline: Simple Page view
    Given I am logged in as a user with the <role> role
    When I go to the "node" entity with label "Behat page test"
    Then the response status code should be 200
    Then I should see "Behat page test"

    Examples:
      | role           |
      | administrator  |
      | authenticated  |


  @api @page @view @anonymous
  Scenario: Simple Page view anonymous access
    When I go to the "node" entity with label "Behat page test"
    Then the response status code should be 200
    Then I should see "Behat page test"

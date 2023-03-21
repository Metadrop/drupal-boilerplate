Feature: As a user
  I want to view a Page
  So that I can see it

  Background:
    Given "page" content:
      | title           |
      | Behat page test |


  @sunnyday @api @page @view @administrator @authenticated @anonymous
  Scenario Outline: Simple Page view
    Given I am a user with <role> role
    When I go to the "node" entity with label "Behat page test"
    Then the response status code should be 200
    Then I should see "Behat page test"

    Examples:
      | role           |
      | anonymous      |
      | administrator  |
      | authenticated  |

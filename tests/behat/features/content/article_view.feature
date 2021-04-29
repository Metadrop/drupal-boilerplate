Feature: As a user
  I want to view a Article
  So that I can see it

  Background:
    Given "article" content:
      | title           |
      | Behat article test |


  @sunnyday @api @article @view @administrator @authenticated
  Scenario Outline: Simple Article view
    Given I am logged in as a user with the <role> role
    When I go to the "node" entity with label "Behat article test"
    Then the response status code should be 200
    Then I should see "Behat article test"

    Examples:
      | role           |
      | administrator  |
      | authenticated  |


  @api @article @view @anonymous
  Scenario: Simple Article view anonymous access
    Given I am an anonymous user
    When I go to the "node" entity with label "Behat article test"
    Then the response status code should be 200
    Then I should see "Behat article test"

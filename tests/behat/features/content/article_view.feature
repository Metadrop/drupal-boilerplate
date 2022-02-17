Feature: As a user
  I want to view a Article
  So that I can see it

  Background:
    Given "article" content:
      | title              |
      | Behat article test |


  @sunnyday @api @article @view @administrator @authenticated @anonymous
  Scenario Outline: Simple Article view
    Given I am a user with <role> role
    When I go to the "node" entity with label "Behat article test"
    Then the response status code should be 200
    Then I should see "Behat article test"

    Examples:
      | role           |
      | anonymous      |
      | administrator  |
      | authenticated  |


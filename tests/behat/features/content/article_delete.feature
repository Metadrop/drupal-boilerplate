Feature: As a user
  I want to delete a Article
  So that I can remove it

  Background:
    Given "article" content:
      | title              |
      | Behat article test |


  @sunnyday @api @javascript @article @delete @administrator
  Scenario Outline: Simple Article delete
    Given I am logged in as a user with the <role> role
    When I go to "delete" of the "node" entity with label "Behat article test"
    Then I should see "This action cannot be undone."
    Then I should see "Delete"
    When I press the "Delete" button
    Then I should see the message "The Article Behat article test has been deleted"

    Examples:
      | role           |
      | administrator  |


  @error @api @article @delete @anonymous
  Scenario: Simple Article delete anonymous access
    Given I am an anonymous user
    When I go to "delete" of the "node" entity with label "Behat article test"
    Then the response status code should be 403

  @error @api @article @delete @authenticated
  Scenario Outline: Simple Article delete authenticated access
    When I go to "delete" of the "node" entity with label "Behat article test"
    Then the response status code should be 403

    Examples:
      | role           |
      | authenticated  |

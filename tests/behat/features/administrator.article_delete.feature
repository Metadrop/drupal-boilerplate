Feature: As a Administrator
  I want to delete an article
  So that I can remove it

  Background:

    Given "article" content:
      | title              |
      | Behat article test |

    Given I am logged in as a user with the administrator role

  @sunnyday @api @administrator @article @delete
  Scenario: Simple Article delete
    When I go to "delete" of the "node" entity with label "Behat article test"
    Then I should see "This action cannot be undone."
    Then I should see "Delete"
    When I press the "Delete" button
    Then the url should match "/"

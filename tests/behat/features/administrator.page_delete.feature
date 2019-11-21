Feature: As an Administrator
  I want to delete a page
  So that I can build the site

  Background:

    Given "page" content:
      | title           |
      | Behat page test |

    Given I am logged in as a user with the administrator role

  @sunnyday @api @administrator @page @delete
  Scenario: Simple Page delete
    When I go to "delete" of the last entity "node" with "page" bundle created
    Then I should see "This action cannot be undone."
    Then I should see "Delete"
    When I press the "Delete" button
    Then the url should match "/"

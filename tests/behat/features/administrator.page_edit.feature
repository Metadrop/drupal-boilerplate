Feature: As a Administrator
  I want to edit an Page
  So that I can modify it

  Background:

    Given "page" content:
      | title           |
      | Behat page test |

    Given I am logged in as a user with the administrator role

  @sunnyday @api @administrator @page @edit
  Scenario: Simple Page edit
    When I go to "edit" of the "node" entity with label "Behat page test"
    And I fill in "Title" with "Behat page test edited"
    And I press the "Save" button
    Then I should see "Behat page test edited"

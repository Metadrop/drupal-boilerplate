Feature: As an Administrator
  I want to create a Page
  So that I can build the site

  Background:

    Given I am logged in as a user with the administrator role

  @sunnyday @api @administrator @page @create
  Scenario: Simple Page creation
    When I go to "/node/add/page"
    Then I fill in "Title" with "Behat Test"
    And I press "Save"
    Then I should see "Behat Test"

  @error @api @administrator @page @create
  Scenario: Simple Page creation
    When I go to "/node/add/page"
    And I press "Save"
    And I should see "Title field is required."

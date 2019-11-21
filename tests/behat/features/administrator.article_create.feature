Feature: As an Administrator
  I want to create a Article
  So that I can build the site

  Background:

    Given users:
      | name      |
      | BehatUser |

    Given I am logged in as a user with the administrator role

  @sunnyday @api @administrator @article @create
  Scenario: Simple Article creation
    When I go to "/node/add/article"
    Then I fill in "Title" with "Behat Test"
    And I press "Save"
    Then I should see "Behat Test"

  @error @api @administrator @article @create
  Scenario: Article creation errors
    When I go to "/node/add/article"
    And I press "Save"
    And I should see "Title field is required."

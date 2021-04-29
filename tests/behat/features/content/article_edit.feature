Feature: As a user
  I want to edit a Article
  So that I can modify it

  Background:
    Given "article" content:
      | title              |
      | Behat article test |


  @sunnyday @api @article @edit @administrator
  Scenario Outline: Simple Article edit
    Given I am logged in as a user with the <role> role
    When I go to "edit" of the "node" entity with label "Behat article test"
    And I fill in "Title" with "Behat article test edited"
    And I press the "Save" button
    Then I should see "Behat article test edited"

    Examples:
      | role           |
      | administrator  |


  @error @api @article @edit @anonymous
  Scenario: Simple Article edit anonymous access
    Given I am an anonymous user
    When I go to "edit" of the "node" entity with label "Behat article test"
    Then the response status code should be 403

  @error @api @article @edit @authenticated
  Scenario Outline: Simple Article edit authenticated access
    Given I am logged in as a user with the <role> role
    When I go to "edit" of the "node" entity with label "Behat article test"
    Then the response status code should be 403

    Examples:
      | role           |
      | authenticated  |

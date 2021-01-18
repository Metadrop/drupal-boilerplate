Feature: As a Administrator
  I want to edit an article
  So that I can modify it

  Background:

    Given users:
      | name       |
      | BehatUser  |
      | Behat2User  |

    Given "article" content:
      | title              | field_intro              | field_author_ref |
      | Behat article test | Behat article intro test | BehatUser        |

    Given I am logged in as a user with the administrator role

  @sunnyday @api @administrator @article @edit
  Scenario: Simple Article edit
    When I go to "edit" of the "node" entity with label "Behat article test"
    And I fill in "Title" with "Behat article test edited"
    And I press the "Save" button
    Then I should see "Behat article test edited"

  @error @api @administrator @article @edit
  Scenario: Article edit
    When I go to "edit" of the "node" entity with label "Behat article test"
    And I fill in "Title" with ""
    And I press the "Save" button
    And I should see "Title field is required."

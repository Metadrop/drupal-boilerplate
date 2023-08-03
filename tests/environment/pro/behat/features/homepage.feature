Feature: As a user
  I want to visit the homepage
  So that I can browse the site!

  @homepage @nojs
  Scenario Outline: Homepage
    Given I go to "<domain>"
    Then the response status code should be 200
    Examples:
      | domain                        |
      | /                             |

  @homepage @javascript
  Scenario: Homepage with JavaScript
    When I go to "/"
    Then I should see "Example"

Feature: As a system
  I want to protect Article access per status
  So that only published content is accessible to not privileged users

  Background:
    Given "article" content:
      | title                           | status   |
      | Behat article test published    | 1        |
      | Behat article test unpublished  | 0        |

  @sunnyday @api @article @access @authenticated @anonymous
  Scenario Outline: Simple article access by moderation state
    Given I am a user with <role> role

    # View:
    When I go to the "node" entity with label "Behat article test published"
    Then the response status code should be 200
    When I go to the "node" entity with label "Behat article test unpublished"
    Then the response status code should be 403

    # Edit:
    When I go to "edit" of the "node" entity with label "Behat article test published"
    Then the response status code should be 403
    When I go to "edit" of the "node" entity with label "Behat article test unpublished"
    Then the response status code should be 403

    # Delete:
    When I go to "delete" of the "node" entity with label "Behat article test published"
    Then the response status code should be 403
    When I go to "delete" of the "node" entity with label "Behat article test unpublished"
    Then the response status code should be 403

    Examples:
      | role           |
      | anonymous      |
      | authenticated  |

  @sunnyday @api @article @access @administrator
  Scenario Outline: Simple article access by moderation state (administrative roles)
    Given I am a user with <role> role

    # View:
    When I go to the "node" entity with label "Behat article test unpublished"
    Then the response status code should be 200

    # Edit:
    When I go to "edit" of the "node" entity with label "Behat article test unpublished"
    Then the response status code should be 200

    # Delete:
    When I go to "delete" of the "node" entity with label "Behat article test unpublished"
    Then the response status code should be 200

    Examples:
      | role           |
      | administrator  |

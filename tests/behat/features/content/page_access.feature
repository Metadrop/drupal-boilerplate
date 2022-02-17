Feature: As a system
  I want to protect Page access per moderation state
  So that only published content is accessible to not privileged users

  Background:
    Given "page" content:
      | title                        | status    |
      | Behat page test published    | 1         |
      | Behat page test unpublished  | 0         |

  @sunnyday @api @page @access @authenticated @anonymous
  Scenario Outline: Simple Page access by moderation state
    Given I am a user with <role> role

    # View:
    When I go to the "node" entity with label "Behat page test published"
    Then the response status code should be 200
    When I go to the "node" entity with label "Behat page test unpublished"
    Then the response status code should be 403

    # Edit:
    When I go to "edit" of the "node" entity with label "Behat page test published"
    Then the response status code should be 403
    When I go to "edit" of the "node" entity with label "Behat page test unpublished"
    Then the response status code should be 403

    # Delete:
    When I go to "delete" of the "node" entity with label "Behat page test published"
    Then the response status code should be 403
    When I go to "delete" of the "node" entity with label "Behat page test unpublished"
    Then the response status code should be 403

    Examples:
      | role           |
      | anonymous      |
      | authenticated  |

  @sunnyday @api @page @access @administrator
  Scenario Outline: Simple Page access by moderation state (administrative roles)
    Given I am a user with <role> role

    # View:
    When I go to the "node" entity with label "Behat page test unpublished"
    Then the response status code should be 200

    # Edit:
    When I go to "edit" of the "node" entity with label "Behat page test unpublished"
    Then the response status code should be 200

    # Delete:
    When I go to "delete" of the "node" entity with label "Behat page test unpublished"
    Then the response status code should be 200

    Examples:
      | role           |
      | administrator  |

Feature: Trip participation windows

  Scenario: A member's view starts from their join date
    Given a member joined on 2026-06-05
    And expenses exist on 2026-06-03 and 2026-06-06
    When Tally builds the member's default expense view
    Then the 2026-06-03 expense should be hidden
    And the 2026-06-06 expense should be visible

  Scenario: Leaving a trip closes the participation window
    Given a member joined on 2026-06-01
    And the member left on 2026-06-07
    And an expense occurred on 2026-06-08
    When Tally determines eligible members
    Then the member should not be eligible for the expense

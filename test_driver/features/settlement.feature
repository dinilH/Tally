Feature: Simplified settlements

  Scenario: A debtor settles part of their debt
    Given Charlie owes Alice Rs 500
    When Charlie records a settlement payment of Rs 200 to Alice
    Then the recorded settlement amount should be Rs 200
    And Charlie's remaining debt to Alice should be Rs 300
    And the original expense should remain unchanged

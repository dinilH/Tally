Feature: Expense balances

  Scenario: A single payer pays more than their share
    Given a trip expense totals Rs 80
    And Alice paid Rs 80
    And Alice consumed Rs 40
    And Bob consumed Rs 40
    When Tally calculates the member balances
    Then Alice should be owed Rs 40
    And Bob should owe Rs 40

  Scenario: Multiple payers and uneven consumption
    Given a trip expense totals Rs 80
    And Alice paid Rs 50
    And Bob paid Rs 30
    And Alice consumed Rs 40
    And Bob consumed Rs 20
    And Charlie consumed Rs 20
    When Tally calculates the member balances
    Then Alice should be owed Rs 10
    And Bob should be owed Rs 10
    And Charlie should owe Rs 20

  Scenario: Itemized items are shared only with assigned members
    Given an item "Pizza" costs Rs 600 and is assigned to Alice and Bob
    And an item "Drinks" costs Rs 200 and is assigned to Alice, Bob and Charlie
    When Tally calculates item shares
    Then Alice should consume Rs 366.67 within rounding tolerance
    And Bob should consume Rs 366.67 within rounding tolerance
    And Charlie should consume Rs 66.66 within rounding tolerance

  Scenario: Members who join later are excluded by default
    Given Alice joined the trip on 2026-06-01
    And Bob joined the trip on 2026-06-05
    And an expense of Rs 60 occurred on 2026-06-03
    When Tally determines eligible members
    Then Alice should be eligible
    And Bob should not be eligible

  Scenario: A settlement is separate from the original expense
    Given Bob owes Alice Rs 500
    When Bob records a settlement payment of Rs 200 to Alice
    Then the settlement should be recorded from Bob to Alice for Rs 200
    And the original expense should remain unchanged

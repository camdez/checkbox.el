Feature: Using custom states
  Background:
    Given I switch to buffer "custom-checkbox.txt"
    And I set checkbox-states to ("TODO" "DONE" "HOLD")
    And I clear the buffer
    And I insert:
      """
      Line 1
      """
    And I go to beginning of buffer
    And I bind key "C-c C-t" to "checkbox-toggle"

  Scenario: Add checkbox
    When I go to word "1"
    And I press "C-c C-t"
    Then I should see:
      """
      TODO Line 1
      """

  Scenario: Cycle checkbox
    When I go to word "1"
    And I press "C-c C-t" "3" times
    Then I should see:
      """
      HOLD Line 1
      """

  Scenario: Add specific checkbox
    When I go to word "1"
    And I press "C-u 2 C-c C-t"
    Then I should see:
      """
      HOLD Line 1
      """

  Scenario: Change to specific checkbox
    When I go to word "1"
    And I press "C-c C-t"
    And I press "C-u 2 C-c C-t"
    Then I should see:
      """
      HOLD Line 1
      """

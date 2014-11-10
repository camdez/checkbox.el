Feature: Toggle checkbox on line
  Background:
    Given I switch to buffer "checkbox.txt"
    And I clear the buffer
    And I insert:
      """
      Line 1
      [ ] Line 2
      [x] Line 3
      """
    And I go to beginning of buffer
    And I bind key "C-c C-t" to "checkbox-toggle"

  Scenario: Add checkbox
    When I go to word "1"
    And I press "C-c C-t"
    Then I should see:
      """
      [ ] Line 1
      [ ] Line 2
      [x] Line 3
      """
    And I should not see pattern "^ "
    And the cursor should be before "1"

  Scenario: Check checkbox
    When I go to word "2"
    And I press "C-c C-t"
    Then I should see:
      """
      Line 1
      [x] Line 2
      [x] Line 3
      """
    And the cursor should be before "2"

  Scenario: Uncheck checkbox
    When I go to word "3"
    And I press "C-c C-t"
    Then I should see:
      """
      Line 1
      [ ] Line 2
      [ ] Line 3
      """
    And the cursor should be before "3"

  Scenario: Remove checkbox
    When I go to word "3"
    And I press "C-u C-c C-t"
    Then I should see:
      """
      Line 1
      [ ] Line 2
      Line 3
      """
    And the cursor should be before "3"

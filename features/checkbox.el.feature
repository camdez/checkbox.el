Feature: Toggle checkbox
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
    And I bind key "C-c C-t" to "checkbox/toggle"

  Scenario: Add checkbox
    When I press "C-c C-t"
    Then I should see:
      """
      [ ] Line 1
      [ ] Line 2
      [x] Line 3
      """

  Scenario: Check checkbox
    When I go to line "2"
    And I press "C-c C-t"
    Then I should see:
      """
      Line 1
      [x] Line 2
      [x] Line 3
      """

  Scenario: Uncheck checkbox
    When I go to line "3"
    And I press "C-c C-t"
    Then I should see:
      """
      Line 1
      [ ] Line 2
      [ ] Line 3
      """

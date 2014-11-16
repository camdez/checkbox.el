Feature: Put cursor after new checkbox (sometimes)
  As an Emacs user
  In order to rapidly type out new checkbox descriptions
  I want checkbox.el to leave point after new checkboxes (as appropriate)

  Background:
    Given I switch to buffer "prefix.txt"
    And I clear the buffer
    And I go to beginning of buffer
    And I bind key "C-c C-t" to "checkbox-toggle"

  Scenario: Insert on new line in text-mode
    When I turn on text-mode
    And I press "C-c C-t"
    Then I should see:
      """
      [ ]
      """
    And the cursor should be after "[ ] "

  Scenario: Insert on a line with only prefix chars in text-mode
    When I turn on text-mode
    And I insert:
      """
      -
      """
    And I press "C-c C-t"
    Then I should see:
      """
      - [ ]
      """
    And the cursor should be after "[ ] "

  Scenario: Point at end but not blank
    When I turn on text-mode
    And I insert:
      """
      - foobar
      """
    And I press "C-c C-t"
    Then I should see:
      """
      - [ ] foobar
      """
    And the cursor should be after "foobar"

  Scenario: Insert on a line with blank comment in prog-mode
    When I turn on c-mode
    And I insert:
      """
      /* */
      """
    And I press "C-c C-t"
    Then I should see:
      """
      /* [ ] */
      """
    And the cursor should be after "[ ] "

  Scenario: Insert on a line with comment with only prefix chars in prog-mode
    When I turn on c-mode
    And I insert:
      """
      /* - */
      """
    And I press "C-c C-t"
    Then I should see:
      """
      /* - [ ] */
      """
    And the cursor should be after "[ ] "

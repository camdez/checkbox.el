Feature: Toggle checkbox on line in a programming mode
  Background:
    Given I switch to buffer "checkbox.el"
    And I load the following:
      """
      (emacs-lisp-mode)
      (setq indent-tabs-mode nil)
      """
    And I clear the buffer
    And I insert:
      """
      (setq foo 1)
      (setq bar 2)                            ; [ ] words
      (setq baz 3)                            ; [x] more words
      (setq qux 4)                            ; all the words
      """
    And I go to beginning of buffer
    And I bind key "C-c C-t" to "checkbox/toggle"

  Scenario: Add checkbox
    When I go to word "1"
    And I press "C-c C-t"
    Then I should see:
      """
      (setq foo 1)                            ; [ ] 
      """
    And the cursor should be after "[ ] "

  Scenario: Check checkbox
    When I go to word "2"
    And I press "C-c C-t"
    Then I should see:
      """
      (setq foo 1)
      (setq bar 2)                            ; [x] words
      (setq baz 3)                            ; [x] more words
      (setq qux 4)                            ; all the words
      """
    And the cursor should be before "2"

  Scenario: Uncheck checkbox
    When I go to word "3"
    And I press "C-c C-t"
    Then I should see:
      """
      (setq foo 1)
      (setq bar 2)                            ; [ ] words
      (setq baz 3)                            ; [ ] more words
      (setq qux 4)                            ; all the words
      """
    And the cursor should be before "3"

  Scenario: Add checkbox to comment
    When I go to word "4"
    And I press "C-c C-t"
    Then I should see:
      """
      (setq foo 1)
      (setq bar 2)                            ; [ ] words
      (setq baz 3)                            ; [x] more words
      (setq qux 4)                            ; [ ] all the words
      """
    And the cursor should be before "4"

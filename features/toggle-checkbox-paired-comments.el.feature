Feature: Toggle checkbox in a mode with paired comment markers
  As an Emacs user
  In order to edit checkboxes in modes like C
  I want checkbox.el to understand paired comment markers

  Background:
    Given I switch to buffer "checkbox.c"
    And I turn on c-mode
    And I load the following:
      """
      (c-mode)
      """
    And I clear the buffer
    And I go to beginning of buffer
    And I bind key "C-c C-t" to "checkbox-toggle"

  Scenario: Add checkbox to blank comment
    When I insert:
      """
      /* */
      """
    And I press "C-c C-t"
    Then I should see:
      """
      /* [ ] */
      """

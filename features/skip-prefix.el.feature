Feature: Skipping prefix characters
  As an Emacs user
  In order to create checkbox lists
  I want checkbox.el to skip over prefix syntax

  Background:
    Given I switch to buffer "prefix.txt"
    And I clear the buffer
    And I go to beginning of buffer
    And I bind key "C-c C-t" to "checkbox/toggle"

  Scenario: Leading prefix in text-mode
    When I insert:
      """
      - foobar
      """
    And I press "C-c C-t"
    Then I should see:
      """
      - [ ] foobar
      """

  Scenario: Leading prefix in prog-mode
    When I insert:
      """
      /* - foobar */
      """
    And I turn on c-mode
    And I press "C-c C-t"
    Then I should see:
      """
      /* - [ ] foobar */
      """

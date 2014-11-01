(Given "^I bind key \"\\([^\"]+\\)\" to \"\\([^\"]+\\)\"$"
  (lambda (key fn-name)
    (global-set-key (kbd key) (intern fn-name))))

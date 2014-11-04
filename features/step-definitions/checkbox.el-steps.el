(Given "^I bind key \"\\([^\"]+\\)\" to \"\\([^\"]+\\)\"$"
  (lambda (key fn-name)
    (global-set-key (kbd key) (intern fn-name))))

(Given "^I press \"\\([^\"]+\\)\" \"\\([^\"]+\\)\" times$"
  (lambda (key times)
    (dotimes (n (string-to-number times))
      (Given "I press \"%s\"" key))))

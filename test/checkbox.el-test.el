(ert-deftest checkbox/next-state-test ()
  (should (string= (checkbox/next-state "[ ]") "[x]"))
  (should (string= (checkbox/next-state "[x]") "[ ]"))
  (should (string= (checkbox/next-state "NONSENSE") "[ ]"))
  (should (string= (checkbox/next-state) "[ ]")))

(require 'f)

(defvar checkbox-test-path
  (f-dirname load-file-name))

(defvar checkbox-root-path
  (f-parent checkbox-test-path))

(add-to-list 'load-path checkbox-root-path)

(require 'checkbox)

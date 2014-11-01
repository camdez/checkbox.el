(require 'f)

(defvar checkbox-support-path
  (f-dirname load-file-name))

(defvar checkbox-features-path
  (f-parent checkbox-support-path))

(defvar checkbox-root-path
  (f-parent checkbox-features-path))

(add-to-list 'load-path checkbox-root-path)

(require 'checkbox)
(require 'espuds)

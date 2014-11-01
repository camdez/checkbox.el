;;; checkbox.el --- Quick manipulation of textual checkboxes -*- lexical-binding: t; -*-

;; Copyright (C) 2014 Cameron Desautels

;; Author: Cameron Desautels <camdez@gmail.com>
;; Version: 0.1.0
;; Keywords: convenience
;; Homepage: http://github.com/camdez/checkbox.el

;; This file is NOT part of GNU Emacs.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; checkbox.el is a tiny library for working with textual checkboxes
;; in Emacs buffers.  Use it to keep grocery lists in text files,
;; feature requests in source files, or task lists on GitHub PRs.

;; For example, if you have a simple to-do list in a Markdown file
;; like this:

;;   - [ ] Buy gin<point>
;;   - [ ] Buy tonic

;; And you invoke `checkbox/toggle', you'll get the following:

;;   - [x] Buy gin<point>
;;   - [ ] Buy tonic

;; Invoke it again and you're back to the original unchecked version.

;;   - [ ] Buy gin<point>
;;   - [ ] Buy tonic

;; Next, if we add a line without a checkbox...

;;   - [ ] Buy gin
;;   - [ ] Buy tonic
;;   - Buy limes<point>

;; We can invoke the command again to insert a new checkbox.

;;   - [ ] Buy gin
;;   - [ ] Buy tonic
;;   - [ ] Buy limes<point>

;; If we want to remove a checkbox entirely we can do so by passing a
;; prefix argument (`C-u') to `checkbox-toggle'.

;; Finally, checkbox.el treats programming modes specially, wrapping
;; inserted checkboxes in comments so we can quickly go from this:

;;   (save-excursion
;;     (beginning-of-line)<point>
;;     (let ((beg (point)))

;; To this:

;;   (save-excursion
;;     (beginning-of-line)                ; [ ] <point>
;;     (let ((beg (point)))

;;; Code:

(defun checkbox/toggle (&optional arg)
  "Toggle checkbox (\"[ ]\" or \"[x]\") on the current line.
If checkbox does not exist, an empty checkbox will be inserted
before the first word constituent.
In programming modes, checkboxes will be inserted in comments.
With prefix ARG, delete checkbox."
  (interactive "P")
  (if arg
      (save-excursion
        (beginning-of-line)
        (when (re-search-forward "\\[[^]]\\]" (line-end-position) t)
          (delete-char -3)
          (if (looking-at "^")
              (delete-horizontal-space)
            (just-one-space))))
    (condition-case nil
        (save-excursion
          (beginning-of-line)
          (re-search-forward "\\[[^]]\\]" (line-end-position))
          (progn
            (backward-char 2)
            (let ((mark-char (if (looking-at "x")
                                 " "
                               "x")))
              (delete-char 1)
              (insert mark-char))))
      (search-failed
       (if (derived-mode-p 'prog-mode)
           (comment-dwim nil)
         (progn
           (beginning-of-line)
           (skip-syntax-forward "^w" (line-end-position))))
       (unless (looking-at "^")
         (just-one-space))
       (insert "[ ] ")))))

(provide 'checkbox)
;;; checkbox.el ends here

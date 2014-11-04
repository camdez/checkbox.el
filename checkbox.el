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

(require 'cl-lib)

(defgroup checkbox nil
  "Quick manipulation of textual checkboxes."
  :group 'convenience)

(defcustom checkbox/markers '("[ ]" "[x]")
  "Checkbox states to cycle between.
First item will be the state for new checkboxes."
  :group 'checkbox
  :type '(repeat string))

(make-variable-buffer-local 'checkbox/markers)
(put 'checkbox/markers 'safe-local-variable
     (lambda (v)
       (and (listp v)
            (cl-every #'stringp v))))

(defun checkbox/regexp ()
  "Return regexp matching all checkbox types."
  (regexp-opt checkbox/markers))

(defun checkbox/nth-marker (&optional idx wrap)
  "Return the nth marker (or first without IDX).
WRAP means module IDX by the number of markers rather than
erroring."
  (let* ((idx1 (or idx 0))
         (idx2 (if wrap
                   (mod idx1 (length checkbox/markers))
                 idx1)))
    (or (nth idx2 checkbox/markers)
        (error "No such marker"))))

(defun checkbox/next-marker (&optional old-marker)
  "Return the marker to cycle to after OLD-MARKER.
Zero-argument form returns marker to use for new checkboxes."
  (let* ((old-marker-pos (cl-position old-marker checkbox/markers :test 'string=))
         (new-marker-pos (when old-marker-pos (1+ old-marker-pos))))
    (checkbox/nth-marker new-marker-pos t)))

(defun checkbox/toggle (&optional arg)
  "Toggle checkbox (\"[ ]\" or \"[x]\") on the current line.
If checkbox does not exist, an empty checkbox will be inserted
before the first word constituent.
In programming modes, checkboxes will be inserted in comments.
With prefix ARG, delete checkbox."
  (interactive "P")
  (if (consp arg)
      (checkbox/remove)
    (condition-case nil
        (save-excursion
          (beginning-of-line)
          (re-search-forward (checkbox/regexp) (line-end-position))
          ;; Have checkbox, so toggle
          (let ((new-marker (if arg
                                (checkbox/nth-marker arg)
                              (checkbox/next-marker (match-string 0)))))
            (delete-region (match-beginning 0) (match-end 0))
            (insert new-marker)))
      (search-failed
       ;; No checkbox, so insert
       (if (derived-mode-p 'prog-mode)
           ;; prog-mode, so checkbox should be in a comment
           (if (checkbox/comment-on-line-p)
               (save-excursion
                 (comment-dwim nil)
                 (checkbox/insert-at-point arg))
             (progn
               (comment-dwim nil)
               (checkbox/insert-at-point arg)))
         ;; Non-prog-mode, simple case
         (save-excursion
           (beginning-of-line)
           (skip-syntax-forward "^w" (line-end-position))
           (checkbox/insert-at-point arg)))))))

(defun checkbox/insert-at-point (&optional marker-idx)
  "Insert an unchecked checkbox at point.
Or, with MARKER-IDX, insert nth marker."
  (unless (looking-at "^")
    (just-one-space))
  (insert (checkbox/nth-marker marker-idx) " "))

(defun checkbox/remove ()
  "Remove checkbox on line, if any."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (if (re-search-forward (checkbox/regexp) (line-end-position) t)
        (progn
          (delete-region (match-beginning 0) (match-end 0))
          (if (looking-at "^")
              (delete-horizontal-space)
            (just-one-space)))
      (message "No comment on line"))))

(defun checkbox/comment-on-line-p ()
  "Return non-nil if there is a comment on the current line."
  (save-excursion
    (beginning-of-line)
    (comment-normalize-vars)
    (comment-search-forward (line-end-position) t)))

(provide 'checkbox)
;;; checkbox.el ends here

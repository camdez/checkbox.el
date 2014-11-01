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

;; Commentary coming soon!

;; [x] Insert in a comment if we can't find a checkbox.
;; [x] Make it work in Markdown / text mode.
;; [x] With prefix arg, remove.
;; [ ] Document.
;; [ ] Consider making this active *only* for comments if in
;;     programming mode.
;; [ ] Would be nice if it could handle TODO as well.
;; [ ] Consider the case where a list (-) is in a comment in a
;;     programming mode (broken right now).
;; [ ] Consider writing tests for this.
;; [ ] If there's an active region, toggle checkboxes in region.
;; [ ] Numeric prefix to jump to a specific state.
;; [ ] If we have a comment with only a checkbox, maybe `'C-u M-x
;;     checkbox/toggle' should kill the comment.

;;; Code:

(defun checkbox/toggle (&optional p)
  (interactive "P")
  (if p
      (save-excursion
        (beginning-of-line)
        (when (re-search-forward "\\[[^]]\\]" (line-end-position) t)
          (delete-char -3)
          (just-one-space)))
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

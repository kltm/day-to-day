;;;; -*- mode: Lisp -*-
;;;;
;;;; ...
;;;;

(in-package :day-to-day)

(defun filter (list &rest funcs)
  "Filter a list on various functions."
  (let ((funx (alexandria:flatten funcs))) ; nested lists on recursion
    (if (car funx)
	(progn
	  (filter (remove-if (car funx) list) (cdr funx)))
	list)))

(defun plist-keys (plist)
  "Retrieve a list of plist keys."
  (if plist
      (append (list (car plist))
              (plist-keys (cddr plist)))))

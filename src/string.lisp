;;;; -*- mode: Lisp -*-
;;;;
;;;; ...
;;;;

(in-package :day-to-day)

;;;
;;; Handy utilities for getting files and data into the
;;; environment. Sometimes used in later functions.
;;;

(defmacro ccat (&rest strings)
  "Concatenate a number on strings."
  `(concatenate 'string ,@strings))

(defun join-strings (list &key (with ""))
  "Concatenate a list of strings, with optional an separator."
  (format nil (concatenate 'string "~{~A~^" with "~}") list))

(defun ll (obj)
  "Print a little, return true."
  (format t "~A~%" obj) t)

;;;; -*- mode: Lisp -*-
;;;;
;;;;

(in-package :day-to-day)

;; From cl-user snippet.
(defun file->string (path)
  "Whole file as string."
  (with-open-file (s path)
    (let* ((len (file-length s))
           (data (make-string len)))
      (values data (read-sequence data s)))))

(defun file->lines (file-string &key (function #'(lambda (x) x)))
  "Read in a file line by line, optionally exectuting a function on
each line as a string, and collect the output into a list. The default
function is to do nothing."
  (with-open-file (stream file-string)
    (loop
       for line = (read-line stream nil)
       while line
       collect (funcall function line))))

(defun file->characters (file-string)
  "A file into a list of single characters separated by nothing, new
lines ignored."
  (alexandria:flatten
   (file->lines file-string :function #'(lambda (x) (cl-ppcre::split "" x)))))

(defun marshal (file-string &optional (thing nil))
  "Read in (or out) a \"simple\" lisp object."
  (if thing
      (with-open-file (stream file-string :direction :output
			      :if-exists :supersede)
	;;(format stream "~S" (print thing)))
	(print thing stream) t) ; surpress output to console
      (with-open-file (stream file-string)
	(read stream))))

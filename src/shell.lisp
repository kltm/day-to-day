;;;; -*- mode: Lisp -*-
;;;;
;;;; I found this worrying and switched over to a simulate directory:
;;;; http://coding.derkeiler.com/Archive/Lisp/comp.lang.lisp/2006-04/msg01411.html
;;;;

(in-package :day-to-day)

;; Not ment to be shared.
(defparameter +cwd+ nil "The simulated current working directory.")

;; 
(defun decide-initial-cwd ()
  "Find the current working directory as much as possible."
  #+(or sbcl)
  (truename ".")
  #-(or sbcl)
  (error "get-cwd not implemented"))

;;
(defun pwd ()
  "Return the path of the simulated current working directory."
  +cwd+)

;; What should be the behavior of (cd)?
(defun cd (&optional (path nil))
  "Change the directory given a path string."
  (cond
    (path
     (let ((new-path (merge-pathnames path (pwd))))
       (setf +cwd+ (truename new-path))))
    (t
     (setf +cwd+ *default-pathname-defaults*))))

;; TODO: filter for file/directory.
(defun ls (&optional (location nil))
  ""
  (cond
    (location (list-directory location))
    (t (list-directory (pwd)))))

(defun here (path)
  ""
  (truename (merge-pathnames path (pwd))))

(defun shell (cmd)
  "Run a shell command."
  (trivial-shell:shell-command cmd))

;;;
;;; Set +cwd+ on load.
;;;

(when (null +cwd+) (setf +cwd+ (decide-initial-cwd)))

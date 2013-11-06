;;;; -*- mode: Lisp -*-
;;;;
;;;; 
;;;;


(defpackage :day-to-day-asd
  (:use :cl :asdf))
(in-package :day-to-day-asd)

;;
(defsystem day-to-day
  :name "Common Lisp Day-to-day."
  :version "0.1.0"
  :author "Seth Carbon <lisp@genkisugi.net>"
  :maintainer "Seth Carbon <lisp@genkisugi.net>"
  :licence "Modified BSD"
  :description "General purpose utilities for day-to-day tasks."
  :long-description "General purpose utilities for day-to-day tasks."
  :components ((:static-file "day-to-day.asd")
               (:module :src
                        :serial t
                        :components ((:file "package")
				     (:file "string")
				     (:file "list")
				     (:file "shell")
				     (:file "time")
				     (:file "filesystem"))))
  :depends-on (:cl-ppcre
	       :cl-fad
	       :trivial-shell
	       :local-time
	       :alexandria)

  ;; TODO: Auto doc info...
)

;; Add day-to-day to our features.
(defmethod asdf:perform :after ((op asdf:load-op)
				(system (eql (asdf:find-system :day-to-day))))
  (pushnew :day-to-day cl:*features*))

;; Describe the testing system.
(defsystem :day-to-day-test
  :components ((:module :t
                        :serial t
                        :components ((:file "day-to-day-test"))))
  :depends-on (:day-to-day
	       :lift))

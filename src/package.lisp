;;;; -*- mode: Lisp -*-
;;;;
;;;; Day-to-day package definition.
;;;;

(require 'cl-fad)
(require 'cl-ppcre)
(require 'trivial-shell)
(require 'alexandria)
(require 'local-time)

(defpackage :day-to-day
  (:nicknames d2d)
  (:use :cl
	:cl-fad)
  (:export
   ;; Files/filesystem.
   :file->string
   :file->lines
   :file->characters
   :marshal
   ;; Shell.
   :pwd
   :cd
   :ls
   :here
   :shell
   ;; String.
   :ccat
   :ll
   :join-strings
   ;; List.
   :filter
   :plist-keys
   ;; Time.
   :timestamp
   :date-string
   :humanstamp
   :timer
   :seconds))
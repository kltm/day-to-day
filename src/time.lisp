;;;; -*- mode: Lisp -*-
;;;;
;;;; NOTE: Backed this with local-time.
;;;;

;;(require :local-time)
(in-package :day-to-day)

;; Example usage: (tdb-time-stamp (get-universal-time))
;; Example usage: (tdb-time-stamp)
(defun timestamp (&optional (utime (local-time:timestamp-to-universal
				    (local-time:now))))
  "Return a string representing universal time."
  utime)

;; TODO: unneeded?
;; Example:
;;    (date-string (local-time:timestamp-to-universal (local-time:now)))
(defun date-string (&optional (utime (timestamp)))
  "Return a date string representing universal time. Example
usage: (date-string (get-universal-time))."
  (let ((day-names '("Monday" "Tuesday" "Wednesday" "Thursday"
                     "Friday" "Saturday" "Sunday")))
    (multiple-value-bind
	  (second minute hour date month year day-of-week dst-p tz)
        (decode-universal-time utime)
      (declare (ignore dst-p))
      (format nil "~2,'0d:~2,'0d:~2,'0d on ~a, ~d/~2,'0d/~d (GMT~@d)"
              hour
              minute
              second
              (nth day-of-week day-names)
              month
              date
              year
              (- tz)))))

;; Example usage: (tdb-time-stamp (get-universal-time))
;; Example usage: (tdb-time-stamp)
(defun humanstamp (&optional (utime (timestamp)))
  "Return a date integer representing the inputted utime."
  (when utime
    (multiple-value-bind
	(second minute hour date month year day-of-week dst-p tz)
	(decode-universal-time utime)
      (declare (ignore tz dst-p day-of-week))
      ;; Sorry for let--don't want to return two values here.
      (let ((retval (parse-integer
		     (format nil "~d~2,'0d~2,'0d~2,'0d~2,'0d~2,'0d"
			     year
			     month
			     date
			     hour
			     minute
			     second))))
	retval))))

;;;

(defclass timer ()
  ((start-time
    :accessor start-time
    :initform (local-time:now)
    :initarg :start-time)
   (last-time
    :accessor last-time
    :initform 0)))

(defgeneric seconds (in-timer)
  (:documentation "..."))

(defmethod seconds ((in-timer timer))
  (let ((then (start-time in-timer)))
    (- (local-time:timestamp-to-universal (local-time:now))
       (local-time:timestamp-to-universal then))))

  ;; (let ((now (get-universal-time)))
    ;; (- now (start-time in-timer))))

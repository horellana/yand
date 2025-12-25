(add-to-load-path "modules")

(use-modules (srfi srfi-1))
(use-modules (ice-9 format))
(use-modules (yand system))
(use-modules (yand rules))

(define my-rules
  (list (make-rule "guile" '() -1)))

(define (log-match rule process pid)
  (format #t "Match! PID: ~a | Command: ~a | Nice level: ~a~%"
		    pid
		    (process-name process)
		    (rule-nice rule)))

(define (should-change-nice-value new-value pid)
  (and new-value
       (not (equal? new-value (getpriority PRIO_PROCESS pid)))))

(define (update-nice-levels)
  (for-each
   (lambda (pid)
     (let* ((name (get-command pid))
	    (args (get-proc-args pid))
	    (process (make-process name args)))
       (for-each
	(lambda (rule)
	  (let ((nice-value (match-rule rule process)))
	    (when (should-change-nice-value nice-value pid)
	      (setpriority PRIO_PROCESS pid nice-value)
	      (log-match rule process pid))))
	my-rules)))
   (list-pids)))

(while #t
  (update-nice-levels)
  (sleep 5))


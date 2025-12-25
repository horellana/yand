(define-module (yand core)
  :use-module (ice-9 format)
  :use-module (yand rules)
  :use-module (yand system)
  :export (update-nice-levels))

(define (log-match rule process pid)
  (format #t "Match! PID: ~a | Command: ~a | Nice level: ~a~%"
	  pid
	  (process-name process)
	  (rule-nice rule)))

(define (should-change-nice-value new-value pid)
  (and new-value
       (not (equal? new-value (getpriority PRIO_PROCESS pid)))))

(define (update-nice-levels rules)
  (for-each
   (lambda (pid)
     (false-if-exception
      (let* ((name (get-command pid))
	     (args (get-proc-args pid))
	     (process (make-process name args)))
	(for-each
	 (lambda (rule)
	   (let ((nice-value (match-rule rule process)))
	     (when (should-change-nice-value nice-value pid)
	       (setpriority PRIO_PROCESS pid nice-value)
	       (log-match rule process pid))))
	 rules))))
   (list-pids)))

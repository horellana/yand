(define-module (yand system)
  :use-module (ice-9 ftw)
  :use-module (ice-9 textual-ports)
  :export (list-pids get-command get-proc-args))

(define (list-pids)
  (filter identity
	  (map string->number
	       (scandir "/proc"))))

(define (proc-command-path pid)
  (string-concatenate (list "/proc/" (number->string pid) "/comm")))

(define (proc-args-path pid)
  (string-concatenate (list "/proc/" (number->string pid) "/cmdline")))

(define (get-command pid)
  (call-with-input-file (proc-command-path pid)
    (lambda (port)
      (get-line port))))

(define (get-proc-args pid)
  (call-with-input-file (proc-args-path pid)
    (lambda (port)
      (filter (lambda (s) (not (string= "" s)))
	      (cdr (string-split (get-string-all port) #\nul))))))

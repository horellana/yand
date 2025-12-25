(define-module (nicer system)
  :use-module (ice-9 ftw)
  :use-module (ice-9 textual-ports)
  :export (list-pids get-command))

(define (list-pids)
  (filter string->number
	  (scandir "/proc")))

(define (proc-command-path pid)
  (string-concatenate (list "/proc/" (number->string pid) "/comm")))

(define (get-command pid)
  (call-with-input-file (proc-command-path pid)
    (lambda (port)
      (get-line port))))

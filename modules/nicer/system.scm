(define-module (nicer system)
  :use-module (ice-9 ftw)
  :export (list-pids))

(define (list-pids)
  (filter string->number
	  (scandir "/proc")))

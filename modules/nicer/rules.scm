(define-module (nicer rules)
  :export (make-rule match-rule make-process))

(use-modules (srfi srfi-9))

(define-record-type <process>
  (make-process name)
  process?
  (name process-name))

(define-record-type <rule>
  (make-rule name nice)
  rule?
  (name rule-name)
  (nice rule-nice))

(define (match-rule rule process)
  (if (eq? (rule-name rule)
	     (process-name process))
      (rule-nice rule)
      #f))

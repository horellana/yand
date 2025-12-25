(define-module (nicer rules)
  :use-module (srfi srfi-9)
  :use-module (srfi srfi-1)
  :export (make-rule match-rule make-process))

(define-record-type <process>
  (make-process name args)
  process?
  (name process-name)
  (args process-args))

(define-record-type <rule>
  (make-rule name args nice)
  rule?
  (name rule-name)
  (args rule-args)
  (nice rule-nice))

(define (match-rule rule process)
  (if (> (length (rule-args rule)) 0)
      (match-by-cli-args rule process)
      (match-by-name rule process)))

(define (match-cli-args rule-args process-args)
  (lset<= string=? rule-args process-args))

(define (match-by-name rule process)
  (if (eq? (rule-name rule)      
	   (process-name process))
      (rule-nice rule)
      #f))

(define (match-by-cli-args rule process)
  (if (and (match-by-name rule process)
	   (match-cli-args (rule-args rule) (process-args process)))
      (rule-nice rule)
      #f))



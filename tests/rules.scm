(use-modules (srfi srfi-64))
(use-modules (yand rules))

(test-begin "rules")

(test-equal "helper: matches cli args correctly"
  #t
  ((@@ (yand rules) match-cli-args)
   (list "--compile")
   (list "--compile" "--no-site-lisp")))

(let ((emacs-rule (make-rule "emacs" (list) -5))
      (process (make-process "emacs" (list))))
  (test-equal "match rule by name"
    -5
    (match-rule emacs-rule process)))

(let ((emacs-rule (make-rule 'emacs (list "--compile") -5))
      (process (make-process 'emacs (list "--debug"))))
  (test-equal "does match rule by name and command line args if process was launched with different args"
    #f
    (match-rule emacs-rule process)))

(let ((test-cases
       `(((expected-output . 0)
	  (description . "It handles absolute command path")
	  (rule . ,(make-rule "guile" '() 0))
	  (process . ,(make-process
		      "/gnu/store/ccxagad0fnzyh0z5xflh3wjlxn4la79n-guile-wrapper/bin/guile"
		      '())))
	 ((expected-output . 0)
	  (description . "It handles bare command name")
	  (rule . ,(make-rule "guile" '() 0))
	  (process . ,(make-process "guile" '()))))))
  (for-each
    (lambda (test-case)
      (let* ((expected-output (assq-ref test-case 'expected-output))
	     (process (assq-ref test-case 'process))
	     (description (assq-ref test-case 'description))
	     (rule (assq-ref test-case 'rule))
	     (output (match-rule rule process)))
	(test-equal description expected-output output)))
    test-cases))

(test-end "rules")

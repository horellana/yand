(add-to-load-path "modules")

(use-modules (srfi srfi-64))
(use-modules (nicer rules))

(test-begin "rules")

(test-equal "helper: matches cli args correctly"
  #t
  ((@@ (nicer rules) match-cli-args)
   (list "--compile")
   (list "--compile" "--no-site-lisp")))

(let ((emacs-rule (make-rule 'emacs (list) -5))
      (process (make-process 'emacs (list))))
  (test-equal "match rule by name"
    -5
    (match-rule emacs-rule process)))

(let ((emacs-rule (make-rule 'emacs (list "compile") -5))
      (process (make-process 'emacs (list "compile"))))
  (test-equal "match rule by name and command line args"
    -5
    (match-rule emacs-rule process)))

(let ((emacs-rule (make-rule 'emacs (list "--compile") -5))
      (process (make-process 'emacs (list "--debug"))))
  (test-equal "does match rule by name and command line args if process was launched with different args"
    #f
    (match-rule emacs-rule process)))

(test-end "rules")

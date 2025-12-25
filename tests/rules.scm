(add-to-load-path "modules")

(use-modules (srfi srfi-64))
(use-modules (nicer rules))

(test-begin "rules")

(let ((emacs-rule (make-rule 'emacs -5))
      (process (make-process 'emacs)))
  (test-equal "match rule by name"
    -5
    (match-rule emacs-rule process)))

(let ((emacs-rule (make-rule 'emacs -5 (list "compile")))
      (process (make-process 'emacs (list "compile"))))
  (test-equal "match rule by name and command line args"
    -5
    (match-rule emacs-rule process)))

(test-end "rules")

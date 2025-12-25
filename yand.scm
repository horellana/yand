(add-to-load-path "modules")

(use-modules (yand core))
(use-modules (yand rules))

(define my-rules
  (list (make-rule "guile" '() -1)))

(while #t
  (update-nice-levels my-rules)
  (sleep 5))


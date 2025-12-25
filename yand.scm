(add-to-load-path "modules")

(use-modules (yand core))
(use-modules (yand rules))

(define rules (load-config "./my-rules.scm"))

(while #t
  (update-nice-levels rules)
  (sleep 5))


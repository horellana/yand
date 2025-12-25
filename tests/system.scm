(add-to-load-path "modules")

(use-modules (srfi srfi-64))
(use-modules (nicer system))

(test-begin "system")

(test-assert "list-pids: returns a non empty list"
  (> (length (list-pids))))

(test-assert "list-pipds: retuns a list that only contains integers (PIDs)"
  (and-map string->number (list-pids)))

(test-end "system")

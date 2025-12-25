(add-to-load-path "modules")

(use-modules (srfi srfi-64))
(use-modules (yand system))

(test-begin "system")

(test-assert "list-pids: returns a non empty list"
  (> (length (list-pids))))

(test-assert "list-pipds: retuns a list that only contains integers (PIDs)"
  (and-map string->number (list-pids)))

(test-assert "get-command: returns correct process name"
  (string= "guile" (get-command (getpid))))

(test-assert "get-proc-args: returns a list of elements"
  (let ((args (get-proc-args (getpid))))
    (and (list? args)
	 (> (length args) 0))))

(test-end "system")

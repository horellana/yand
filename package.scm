(define-module (yand package)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system guile)
  #:use-module (guix licenses)
  #:use-module (gnu packages guile))

(define-public yand
  (package
   (name "yand")
   (version "0.1.0")
   (source (local-file "." "yand-source"
		       #:recursive? #t))
   (build-system guile-build-system)
   (arguments
    '(#:phases
      (modify-phases %standard-phases
		     (delete 'check)
		     (add-after 'install 'install-bin
				(lambda* (#:key outputs #:allow-other-keys)
				  (let* ((out (assoc-ref outputs "out"))
					 (bin (string-append out "/bin")))
				    (install-file "yand.scm" bin)
				    ;; Optional: rename it to just "yand" and make executable
				    (rename-file (string-append bin "/yand.scm")
						 (string-append bin "/yand"))
				    (chmod (string-append bin "/yand") #o555)))))))
   (inputs
    (list guile-3.0))
   (synopsis "Yet Another Nice Daemon")
   (description "A daemon to auto-nice processes.")
   (home-page "https://github.com/horellana/yand")
   (license gpl3+)))

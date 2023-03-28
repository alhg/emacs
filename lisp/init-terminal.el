;; eat
;; "char" mode - Use C-M-m or M-RET to switch to semi-char mode
;; "semi-char" mode
;;   - C-c C-e to switch to emacs mode
;; "emacs" mode
;;   - C-c C-j to switch to semi-char mode
;;   - C-c M-d to switch to char mode
(straight-use-package
 '(eat :type git
       :host codeberg
       :repo "akib/emacs-eat"
       :files ("*.el" ("term" "term/*.el") "*.texi"
               "*.ti" ("terminfo/e" "terminfo/e/*")
               ("terminfo/65" "terminfo/65/*")
               ("integration" "integration/*")
               (:exclude ".dir-locals.el" "*-tests.el"))))

(use-package vterm)

(provide 'init-terminal)

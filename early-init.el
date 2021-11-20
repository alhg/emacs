;; Ideas for early-init taken from https://github.com/hlissner/doom-emacs/blob/develop/early-init.el

;; Contrary to what many Emacs users have in their configs, you don't need
;; more than this to make UTF-8 the default coding system:
(set-language-environment "UTF-8")

;; set-language-enviornment sets default-input-method, which is unwanted
(setq default-input-method nil)

;; Turn off GUI stuff before frame is rendered
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; set default fonts
(cond ((string-equal system-type 'gnu/linux) (add-to-list 'default-frame-alist '(font . "Liberation Mono-14")))
      ((string-equal system-type 'darwin) (add-to-list 'default-frame-alist '(font . "SF Mono-14")))
      ((string-equal system-type "windows-nt") (add-to-list 'default-frame-alist '(font . "Consolas-14"))))


;; disable package.el because straight.el is used
(setq package-enable-at-startup nil)


;; turn off GUI stuff before frame is rendered
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; set default fonts
(cond ((string-equal system-type 'gnu/linux)
       (add-to-list 'default-frame-alist '(font . "Go Mono-14")))
      ((string-equal system-type 'darwin)
       (add-to-list 'default-frame-alist '(font . "SF Mono-14")))
      ((string-equal system-type "windows-nt")
       (add-to-list 'default-frame-alist '(font . "Consolas-14"))))


;; have utf-8 as the default coding system
(set-language-environment "UTF-8")
;; set-language-enviornment sets default-input-method, which is unwanted
(setq default-input-method nil)


;; emacs28+, silent native comp warnings
(setq native-comp-async-report-warnings-errors 'silent)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; setup use-package, which is a nicer way of organizing config
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Configure and load use-package
(require 'use-package)
(setq use-package-always-ensure t)

(eval-when-compile
  (defvar use-package-verbose t)
  (require 'use-package))

;; diminish is used on packages to remove/change minor mode strings in modeline
(use-package diminish
  :ensure t)

;; place emacs generated custom settings to another file
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;; (use-package command-log-mode)

;; lightweight completion package that uses emac's
;; completion engine
;;(use-package vertico
;;  :ensure t
;;  :custom
;;  (vertico-cycle t)
;;  :init
;;  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

;; package for extra info on completion menu, cannot find package?
(use-package marginalia
  :after icomplete-vertical
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

;; Best git interface
(use-package magit
  :ensure t)

;; disable startup splash & message buffers
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t)

;; ask before killing emacs
(setq confirm-kill-emacs 'y-or-n-p)

;; turn off annoyances
(setq ring-bell-function 'ignore) ;; turn off all bells
;;(setq visible-bell nil)         ;; toggle between audio/video bells
(setq make-backup-files nil)
(setq auto-save-default nil)
(fset 'yes-or-no-p 'y-or-n-p)     ;; simplify Yes/No Prompts

(transient-mark-mode 1)
(show-paren-mode 1)

;; display line numbers for text and programming mode buffers only
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; show extra information on modeline
(setq-default column-number-mode t)
(display-time)

;; make cursor the width of the character it is under
;; i.e. full width of a TAB
(setq x-stretch-cursor t)

;; change the recenter-top-bottom behavior to leave lines when on top or bottom
(setq scroll-margin 3)

;; show all possible keyboard shortcuts
(use-package which-key
  :ensure t
  :diminish
  :config
  (which-key-mode))

;; keybindings
(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-p") #'backward-paragraph)

;; Crux, a Collection of Ridiculously Useful eXtensions for Emacs.
(use-package crux
  :ensure t
  :bind
   ;; goes to beginning of line of first char, then column 0 if used again
  (("C-a" . crux-move-beginning-of-line)
   ;; kills up to end of line, then kills whole line if used again
   ("C-k" . crux-smart-kill-line)
   ;; opens new buffer to init.el file
   ("C-c i" . crux-find-user-init-file)))

;; ;; completion matching (icomplete-vertical is built-in to emacs)
(use-package icomplete-vertical
  :ensure t
  :diminish
  :demand
  :custom
  (completion-styles '(partial-completion substring))
  (completion-category-overrides '((file (styles basic substring))))
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (completion-ignore-case t)
  :config
  (icomplete-mode)
  (icomplete-vertical-mode)
  (fido-mode 1)
  :bind (:map icomplete-minibuffer-map
              ("<down>" . icomplete-forward-completions)
              ("C-n" . icomplete-forward-completions)
              ("<up>" . icomplete-backward-completions)
              ("C-p" . icomplete-backward-completions)
              ("C-v" . icomplete-vertical-toggle)))

(use-package flycheck
  :ensure t)
;;  :init
;;  (global-flycheck-mode)
;;  :config
;;  (setq flycheck-global-modes '(not c-mode))

;; compilation settings
(setq compilation-scroll-output 'first-error) ;; always scroll to the first error

;; c/c++ stuff
(setq c-default-style "k&r")
(setq-default c-basic-offset 4)

;; have syntax highlighting up to modern C++20
(use-package modern-cpp-font-lock
  :ensure t)

;; d stuff
;;(use-package d-mode
;;  :ensure)

;; go stuff
(use-package go-mode
  :ensure t
  :init
  (add-hook 'before-save-hook 'gofmt-before-save))

;; Go - lsp-mode
;; Set up before-save hooks to format buffer and add/delete imports.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

;; lua stuff
(use-package lua-mode
  :defer t)

;; python stuff
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

(use-package elpy
  :defer t
  :init
  (elpy-enable))

;; rust stuff
(use-package rustic
  :defer t
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  (setq lsp-eldoc-hook nil)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm
 (setq-local buffer-save-without-query t))

;; sml
(use-package sml-mode
  :defer t)

;; zig
(use-package zig-mode
  :defer t
  :mode ("\\.zig\\'" . zig-mode))

;; lsp stuff
(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  ;;(lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)

  ;; go setup
  (add-hook 'go-mode-hook #'lsp-deferred)
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks))

(use-package lsp-ui
  :ensure
  :diminish
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

;; code completion
(use-package company
  :ensure
  :diminish
  :custom
  (company-idle-delay 0.5) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	("C-n". company-select-next)
	("C-p". company-select-previous)
	("M-<". company-select-first)
	("M->". company-select-last)))



(use-package nov
  :ensure t
  :config
  (setq nov-text-width 80)
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

;; Themes
;; modus-themes
;; vscode-dark-plus-theme
;; naysayer-theme
(use-package modus-themes
  :ensure t
  :init
  (modus-themes-load-themes)
  :config
  (modus-themes-load-vivendi) ;; OR (modus-themes-load-vivendi)
  :bind ("<f5>" . modus-themes-toggle))

;; pulses line of cursor when scrolling, switching windows
;; uses pulse behind the scene
;; Used to help locate cursor when moving it
(use-package beacon
  :ensure t
  :config
  (beacon-mode 1))


(use-package org
  :config
  (setq org-startup-indented t)
  (setq fill-column 80)
  :hook
  (auto-fill-mode))


(cond ((member "Go Mono" (font-family-list)) (set-frame-font "Go Mono-12" nil t))
      ((member "Liberation Mono" (font-family-list)) (set-frame-font "Liberation Mono-12" nil t)))

;; linux stuff
(when (string-equal system-type 'gnu/linux)
  (progn
    (use-package pdf-tools
      :ensure t)
    (use-package vterm
      :ensure t)))

;; macOS stuff
(when (string-equal system-type 'darwin)
  (progn
    ;; sets option key to 'alt, command key to 'meta
    (setq mac-option-modifier 'alt
	  mac-right-option-modifier 'alt
	  mac-command-modifier 'meta)
    ;; sets fn-delete to be right-delete
    (global-set-key [kp-delete] 'delete-char)))

;; Windows stuff
(when (string-equal system-type "windows-nt")
  (progn
    (cond ((member "Go Mono" (font-family-list)) (set-frame-font "Go Mono-14" nil t))
	  ((member "Consolas" (font-family-list)) (set-frame-font "Consolas-14" nil t)))
    (setq delete-by-moving-to-trash t)))

;;; init.el ends here

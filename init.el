;; this init.el assumes you are using emacs 27+

;; Add melpa to the package list and initialize our packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; setup use-package, which is a nicer way of organizing config
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Configure and load use-package
(setq use-package-always-ensure t)

(eval-when-compile
  (defvar use-package-verbose t)
  (require 'use-package))

;; diminish is used on packages to remove/change minor mode strings in modeline
(use-package diminish
  :ensure t)

;; Best git interface
(use-package magit
  :ensure t)

;; Theme
;; modus-operandi-theme (light)
;; modus-vivendi-theme (dark)
(use-package modus-vivendi-theme
  :ensure t
  :diminish
  :config
  (load-theme 'modus-vivendi t))

;; show all possible keyboard shortcuts
(use-package which-key
  :ensure t
  :diminish
  :config
  (which-key-mode))

;; Font
;; Go Mono is a really nice serif monospace font, use if available
(when (member "Go Mono" (font-family-list))
  (set-frame-font "Go Mono-12" nil t))

;; turn off UI stuff
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; disable startup splash & message buffers
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t)

;; turn off annoyances
(setq visible-bell 1)
(setq make-backup-files nil)
(setq auto-save-default nil)
(fset 'yes-or-no-p 'y-or-n-p)

(transient-mark-mode 1)
(global-display-line-numbers-mode)
(show-paren-mode 1)

(setq-default column-number-mode t)
(display-time)

;; keybindings
(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-p") #'backward-paragraph)

;; Crux, a Collection of Ridiculously Useful eXtensions for Emacs.
(use-package crux
  :ensure t
  :bind
  (("C-a" . crux-move-beginning-of-line)  ;; goes to beginning of line of first char, then column 0 if used again
   ("C-k" . crux-smart-kill-line)         ;; kills up to end of line, then kills whole line if used again
   ("C-c i" . crux-find-user-init-file))) ;; opens new buffer to init.el file

;; ido stuff
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always) ;; stop ido from asking for permission for new buffers

;; c/c++ stuff
(setq c-default-style "k&r")
(setq-default c-basic-offset 4)

;; Windows stuff
(cond ((string-equal system-type "windows-nt")
       (progn
	(when (member "Consolas" (font-family-list))
	  (set-frame-font "Consolas-12" nil t))
	(setenv "HOME" "c:/Users/Allan Hoang")
	(setq default-directory "~/")
	(setq delete-by-moving-to-trash t))))

;; Custom stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(crux which-key diminish use-package modus-vivendi-theme magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

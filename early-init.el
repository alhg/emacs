;;; early-init.el --- Early Init File -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; Don't initialize installed packages at early-init
;; disable package.el because straight.el is used
(setq package-enable-at-startup nil)

;; turn off GUI stuff before frame is rendered
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-x-resources t
      inhibit-startup-echo-area-message user-login-name
      inhibit-startup-buffer-menu t)

(when (eq window-system 'pgtk)
  (setq pgtk-wait-for-event-timeout 0))

;; temporarily increase gc to speedup startup
(defvar orig-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)

;; temporarily set file-name-handler to nil to increase performance
(defvar orig-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; restore temp changes after startup
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold orig-gc-cons-threshold
		  file-name-handler-alist orig-file-name-handler-alist)

	    ;; remove temp variables
	    (makunbound 'orig-gc-cons-threshold)
	    (makunbound 'orig-file-name-handler-alist)))

;; emacs28+, silent native comp warnings
(setq native-comp-async-report-warnings-errors 'silent)

;;; early-init.el ends here

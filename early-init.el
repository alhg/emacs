;; Ideas for early-init taken from
;; - https://github.com/hlissner/doom-emacs/blob/develop/early-init.el
;; - https://git.sr.ht/~protesilaos/dotfiles/tree/master/item/emacs/.emacs.d/early-init.el

;; Contrary to what many Emacs users have in their configs, you don't need
;; more than this to make UTF-8 the default coding system:
(set-language-environment "UTF-8")

;; set-language-enviornment sets default-input-method, which is unwanted
(setq default-input-method nil)

(setq frame-resize-pixelwise t)
(setq frame-inhibit-implied-resize t)

(dolist (var '(default-frame-alist initial-frame-alist))
  (add-to-list var '(width . (text-pixels . 1920)))
  ;; The height should be 1080, but the panel and the window's
  ;; deocrations reduce the effective value.  If I set 1080 here, Emacs
  ;; maximises the frame regardless of the width value, which I do not
  ;; want.
  (add-to-list var '(height . (text-pixels . 1080))))

;; Turn off GUI stuff before frame is rendered
(menu-bar-mode -1)
(tool-bar-mode -1)
;;(scroll-bar-mode) ;; scroll bar useful in knowing position of view on page.
(setq inhibit-splash-screen t)
(setq use-dialog-box t)
(setq use-file-dialog nil)

(setq inhibit-startup-echo-area-message user-login-name) ; read the docstring
(setq inhibit-startup-screen t)
(setq inhibit-startup-buffer-menu t)

;; set default fonts
(cond ((string-equal system-type 'gnu/linux)
	   (add-to-list 'default-frame-alist '(font . "Liberation Mono-12")))
      ((string-equal system-type 'darwin)
	   (add-to-list 'default-frame-alist '(font . "SF Mono-14")))
      ((string-equal system-type "windows-nt")
	   (add-to-list 'default-frame-alist '(font . "Consolas-14"))))

;; emacs28+ with native compilation
(setq native-comp-async-report-warnings-errors 'silent)

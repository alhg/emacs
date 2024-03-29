;;; init-completion.el --- Completion Configuration -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package vertico
  :init
  (vertico-mode +1))

;; Persist history after restart. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode +1))

;; Adds annotation to completions entries
(use-package marginalia
  ;; Turns marginalia on/off
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;; Adds completion buffer overlay
(use-package corfu
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-delay 0)
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin
  :bind
  (:map corfu-map
	;; Disable enter/return to select competion, because
	;; in shell, pressing enter will cause extra space to be selected
	;; when typing fast.
	("RET" . nil))
  :init
  (global-corfu-mode))

;; Allows corfu to work in terminal
(use-package corfu-terminal
  :config
  (unless (display-graphic-p) (corfu-terminal-mode +1)))

;; Use orderless for fuzzy finding completions
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'init-completion)

;;; init-completetion.el ends here

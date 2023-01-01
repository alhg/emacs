(use-package vertico
  :init
  (vertico-mode +1)
  ;; Enable cycling for `vertico-next' and `vertico-previous'.
  ;;(setq vertico-cycle t)
  )

;; Persist history after restart. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode +1))

;; Adds annotations to completions
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

  :init
  (global-corfu-mode))

(provide 'init-completion)

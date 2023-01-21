(use-package org
  :hook (org-mode . (lambda ()
		      (auto-fill-mode +1))))

(provide 'init-org)

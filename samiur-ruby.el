(prelude-require-packages '(flymake-ruby robe rvm projectile-rails))

(setenv "PAGER" (executable-find "cat"))

(require 'bundler)
(require 'robe)

(add-hook 'ruby-mode-hook 'projectile-on)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation ()
  (set (make-local-variable 'truncate-lines) nil))

(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))

(add-hook 'ido-setup-hook 'ido-define-keys)

(add-hook 'ruby-mode-hook 'robe-mode)

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

(add-hook 'robe-mode-hook 'robe-ac-setup)

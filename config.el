;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)

(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-markup-indent-offset 2)))

;; Load noctilux as default theme
(load-theme 'noctilux t)

(defun set-font (font)
  "Set fonts to Source Code Pro"
  (interactive "p")
  (set-face-attribute 'default nil :font "Inconsolata" :height 120))

(set-font t)

(setq prelude-guru nil)

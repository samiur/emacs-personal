(prelude-require-packages '(ein flymake-python-pyflakes))

(require 'pymacs)

(setq ein:use-auto-complete t)
(setq ein:use-smartrep t)

;; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")

;; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args
      '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)

;; switch to the interpreter after executing code-conversion-map-vector
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
;; don't split windows
(setq py-split-windows-on-execute-p nil)
;; try to automagically figure out indentation
(setq py-smart-indentation nil)

;; ;; ropemacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)

;; (setq ropemacs-global-prefix "C-x /")

;; (pymacs-load "ropemacs" "rope-")

;; (ac-ropemacs-initialize)
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (add-to-list 'ac-sources 'ac-source-ropemacs)))

;; ;; jedi
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:setup-keys t)                      ; optional
;; (setq jedi:complete-on-dot t)                 ; optional
;; (add-hook 'ein:connect-mode-hook 'ein:jedi-setup)

'(prelude-require-packages '(org-trello org-pomodoro))

(require 'org)
(require 'org-indent)
(require 'org-macs)
(require 'org-compat)
(require 'org-trello)
(require 'org-agenda)

;; to trigger org-trello for each org file
(add-hook 'org-mode-hook 'org-trello-mode)

(setq *ORGTRELLO-USERS-ENTRY* "orgtrellousers")

(add-to-list 'auto-mode-alist '("\.org$"  . org-mode))
(add-to-list 'auto-mode-alist '("\.todo$" . org-mode))
(add-to-list 'auto-mode-alist '("\.note$" . org-mode))

(column-number-mode)

(setq org-directory "~/org")

(setq org-agenda-files (list "~/org/tasks.org"
                             "~/org/current_sprint.org"))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-startup-indented t)

(setq org-log-done 'time)
(setq org-log-repeat 'time)

(setq org-default-notes-file (concat org-directory "/notes.org"))

;; export options
(setq org-export-with-toc t)
(setq org-export-headline-levels 4)

;; metadata tags for the task at end
(setq org-tag-alist '(("life"       . ?l)
                      ("learn"      . ?k)
                      ("mattermark" . ?m)
                      ("fitness"    . ?f)
                      ("jobsuitors" . ?j)))

;; keywords sequence for org-mode
(setq org-todo-keywords
   '((sequence "TODO-YEAR(y)" "TODO-MONTH(m)" "TODO-WEEK(w)" "TODO-TODAY(t)"
               "IN-PROGRESS(i)" "|"  "DONE(d)"  "CANCELLED(c)")))

;; modifying the colonr for the different keywords
(setq org-todo-keyword-faces
      '(("TODO-YEAR"            . (:foreground "firebrick2" :weight bold))
        ("TODO-MONTH"           . (:foreground "olivedrab" :weight bold))
        ("TODO-WEEK"            . (:foreground "sienna" :weight bold))
        ("Sprint-Pending-Tasks" . (:foreground "sienna" :weight bold))
        ("TODO-TODAY"           . (:foreground "forestgreen" :weight bold))
        ("In-Progress"          . (:foreground "dimgrey" :weight bold))
        ("IN-PROGRESS"          . (:foreground "dimgrey" :weight bold))
        ("DONE"                 . (:foreground "steelblue" :weight bold))
        ("CANCELLED"            . shadow)))

;; babel

(org-babel-do-load-languages
 'org-babel-load-languages
 '((haskell    . t)
   (emacs-lisp . t)
   (sh         . t)
   (clojure    . t)
   (java       . t)
   (ruby       . t)
   (perl       . t)
   (python     . t)
   (R          . t)
   (ditaa      . t)
   (lilypond   . t)))

(setq org-fontify-done-headline t)
(custom-set-faces
 '(org-done ((t (:foreground "PaleGreen"
                 :weight normal
                 :strike-through t))))
 '(org-headline-done
            ((((class color) (min-colors 16) (background dark))
              (:foreground "LightSalmon" :strike-through t)))))

;; Be able to reactivate the touchpad for an export html (as my touchpad is deactivated when in emacs)

(defun run-shl (&rest cmd)
  "A simpler command to run-shell-command with multiple params"
  (shell-command-to-string (apply #'concatenate 'string cmd)))

(defun toggle-touchpad-manual (status)
  "Activate/Deactivate the touchpad depending on the status parameter (0/1)."
  (run-shl "toggle-touchpad-manual.sh " status))

(add-hook 'org-export-html-final-hook
          (lambda () (toggle-touchpad-manual "1")))

(defun myorg-update-parent-cookie ()
  (when (equal major-mode 'org-mode)
    (save-excursion
      (ignore-errors
        (org-back-to-heading)
        (org-update-parent-todo-statistics)))))

(defadvice org-kill-line (after fix-cookies activate)
  (myorg-update-parent-cookie))

(defadvice kill-whole-line (after fix-cookies activate)
  (myorg-update-parent-cookie))

;; org-pomodoro
(require 'org-pomodoro)

(global-unset-key (kbd "C-c C-x C-i"))
(global-unset-key (kbd "C-c C-x C-o"))
(global-set-key (kbd "C-c C-x C-i") 'org-pomodoro)
(global-set-key (kbd "C-c C-x C-o") 'org-pomodoro)

(eval-after-load 'Org
  (lambda ()
    '(define-key org-mode-map (kbd "C-c C-x C-i") 'org-pomodoro)
    '(define-key org-mode-map (kbd "C-c C-x C-o") 'org-pomodoro)))

(setq org-agenda-custom-commands
      '(("W" "Weekly Review"
         ((agenda "" ((org-agenda-ndays 7))) ;; review upcoming deadlines and appointments
          ;; type "l" in the agenda to review logged items
          (todo "TODO-TODAY") ;; review all projects (assuming you use todo keywords to designate projects)
          (todo "TODO-WEEK") ;; review someday/maybe items
          (tags "orgtrellousers=\"samiurrahman\"")
          (todo "TODO-MONTH|TODO-YEAR"))) ;; review waiting items
         ;; ...other commands here
        ))

(setq org-agenda-archives-mode nil)
(setq org-agenda-skip-comment-trees nil)
(setq org-agenda-skip-function nil)

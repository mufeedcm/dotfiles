;;; BASIC SETTINGS ------------------------------------------------------------
(setq inhibit-startup-message t)       ; Disable startup screen
;; (setq visible-bell t)                  ; Visual feedback instead of beeping
(setq use-dialog-box nil)              ; Disable GUI dialogs
(setq confirm-kill-emacs #'y-or-n-p)   ; Confirm before exiting
(setq default-directory "~/notes/org/") ; Default working directory
(setq confirm-nonexistent-file-or-buffer nil)

;;; UI CONFIGURATION ----------------------------------------------------------
(set-fringe-mode 0)                    ; Remove fringe areas
(set-face-attribute 'default nil :height 110) ; Base font size
(add-to-list 'default-frame-alist '(internal-border-width . 20)) ; Window border

;; Window scrolling behavior
(setq scroll-conservatively 101
      scroll-margin 9
      scroll-step 1
      scroll-preserve-screen-position 1)

;; Disable UI elements
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;;for pdf
(setq org-file-apps
      '(("\\.pdf\\'" . "zathura %s")))



;;; LINE NUMBERS --------------------------------------------------------------
(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(setq display-line-numbers-width-start t
      display-line-numbers-width 3)

;; Disable line numbers for specific modes
(dolist (mode '(term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;;; PACKAGE MANAGEMENT --------------------------------------------------------
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;; THEME ---------------------------------------------------------------------
(use-package doom-themes
  :config
  ;; (load-theme 'doom-tokyo-night t))
  (load-theme 'doom-gruvbox t))
  (set-face-background 'default "#000000")
  (set-face-background 'fringe "#000000")
  (set-face-background 'mode-line "#000000")
  (set-face-background 'mode-line-inactive "#000000")
  (set-face-background 'line-number "#000000")
  (set-face-background 'line-number-current-line "#000000")

;;; COMPLETION & SEARCH -------------------------------------------------------
(use-package vertico
  :init (vertico-mode)
  :config (setq enable-recursive-minibuffers t))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil))

(use-package marginalia
  :init (marginalia-mode))

(use-package consult
  :init
  (setq consult-project-root-function #'vc-root-dir))

(use-package embark
  :bind (("C-." . embark-act))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 1))

;;; VIM-STYLE EDITING ---------------------------------------------------------
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll nil)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  (define-key evil-normal-state-map (kbd "gc") 'comment-line)
  (evil-define-key 'visual 'global "p" "\"_dP"))

;;; KEYBINDINGS ---------------------------------------------------------------
(use-package general
  :config
  ;; Leader key setup
  (general-create-definer my/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  ;; Global keybindings
  (my/leader-keys
    "b"  '(:ignore t :which-key "Buffers")
    "bb" '(switch-to-buffer :which-key "Switch Buffer")
    "w"  '(:ignore t :which-key "Windows")
    "wv" '(split-window-right :which-key "Split Window right")
    "ws" '(split-window-below :which-key "Split Window below")
    "wc" '(delete-window :which-key "Close window")
    "ww" '(other-window :which-key "Change window")
    "wh" '(windmove-left :which-key "")
    "wl" '(windmove-right :which-key "")
    "wj" '(windmove-down :which-key "")
    "wk" '(windmove-up :which-key "")

    
    ;; Org-specific
    "o"  '(:ignore t :which-key "Org mode")
    "oo" '(find-file :which-key "Find file")
    "oa" '(org-agenda :which-key "Org Agenda")
    "oc" '(org-capture :which-key "Org Capture")
    "ol" '(org-store-link :which-key "Org Store Link")
    ;; "on" '(consult-notes :which-key "Find file")
    "ot" `(,(lambda () (interactive) (find-file "~/notes/org/tasks.org")) :which-key "Tasks")
    "os" `(,(lambda () (interactive) (find-file "~/notes/org/diploma/sem5.org")) :which-key "Semester 5")
    "oe" `(,(lambda () (interactive) (find-file "~/.config/emacs/init.el")) :which-key "Emacs config")
    "of" '(org-open-at-point :which-key "Open Link/File")

    "/"  '(consult-line :whichkey "search in file")

  ;; Task management keybindings
    "s"  '(:ignore t :which-key "Set")
    "ss" '(org-schedule :which-key "Schedule")
    "sd" '(org-deadline :which-key "Deadline")
    )



  ;; Org-mode navigation
  (general-define-key
   :keymaps 'org-mode-map
   :states '(normal visual)
   "C-j"  'org-metadown
   "C-k"  'org-metaup
   "C-S-j" 'org-move-subtree-down
   "C-S-k" 'org-move-subtree-up
   "C-h"  'org-do-promote
   "C-l"  'org-do-demote
   "C-S-h" 'org-promote-subtree
   "C-S-l" 'org-demote-subtree))

;;; ORG MODE CONFIGURATION ----------------------------------------------------
(defun my/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . my/org-mode-setup)
  :config
  ;; Visual settings
  (setq org-ellipsis " ▾"
        org-hide-leading-stars t
        org-hide-emphasis-markers nil
        org-link-descriptive nil)

  ;; Task management
  (setq org-todo-keywords '((sequence "TODO" "|" "DONE"))
        org-log-done 'time
        org-agenda-files '("~/notes/org/tasks.org"
                           "~/notes/org/diploma/sem4.org")
        org-archive-location "~/notes/org/archive.org::")

  ;; Capture templates
  (setq org-capture-templates
        '(("t" "General Task" entry (file+headline "~/notes/org/tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %i\n  %a")
          ("d" "Diploma Task" entry (file+headline "~/notes/org/diploma/sem4.org" "Inbox")
           "* TODO %?\n  %U\n  %i\n  %a")))

  ;; Auto-saving
  (add-hook 'org-mode-hook
            (lambda ()
              (add-hook 'focus-out-hook 'org-save-all-org-buffers nil 'local))))


(defun my/org-smart-return ()
  "Continue checkbox or list, but exit on empty checkbox."
  (interactive)
  (if (org-at-item-checkbox-p)
      (let ((current-line (thing-at-point 'line t)))
        (if (string-match "^[[:space:]]*- \\[ \\]\\s-*$" current-line)
            (delete-region (line-beginning-position) (line-end-position)) ;; Remove empty checkbox
          (org-insert-todo-heading nil))) ;; Otherwise, create a new checkbox
    (org-return)))

(with-eval-after-load 'org
  (setq org-list-allow-alphabetical t
        org-adapt-indentation nil)
  (define-key org-mode-map (kbd "RET") 'my/org-smart-return))




;; Inline images
(setq org-startup-with-inline-images t)
(add-hook 'org-mode-hook 'org-display-inline-images)

;;; NOTIFICATIONS ------------------------------------------------------------
;; (use-package alert
;;   :config (setq alert-default-style 'libnotify))

;; (use-package org-alert
;;   :config
;;   (setq org-alert-interval 1200
;;         org-alert-notification-title "Org Reminder"
;;         org-alert-advance-notice-time nil)
;;   (org-alert-enable))

;;; DASHBOARD -----------------------------------------------------------------
(use-package dashboard
  :init
  (setq dashboard-startup-banner ""
        dashboard-center-content t
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-items '((agenda . 7)
                          (recents . 5)
                          (bookmarks . 5))
        dashboard-footer-messages '(""))
  :config (dashboard-setup-startup-hook))

;;; CUSTOM FUNCTIONS ----------------------------------------------------------
(defun consult-notes ()
  "Open notes directory"
  (interactive)
  (find-file "~/notes/org/tasks.org"))

;;; AUTO-GENERATED CUSTOM VARIABLES -------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 '(package-selected-packages
   '(undo-tree which-key visual-fill-column vertico orderless marginalia general evil-collection embark-consult doom-themes doom-modeline dashboard)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 )

(provide 'init)
;;; init.el ends here

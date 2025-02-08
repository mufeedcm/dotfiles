;;; =======================================================================
;;; 1. Core Emacs Settings
;;; =======================================================================

;;; -----------------------------------------------------------------------
;;; 1.1 UI Configuration
;;; -----------------------------------------------------------------------
(setq inhibit-startup-message t)          ; Disable startup screen
(scroll-bar-mode -1)                      ; Remove scroll bars
(tool-bar-mode -1)                        ; Remove toolbar
(menu-bar-mode -1)                        ; Remove menu bar
(set-fringe-mode 0)                       ; Minimal fringe spacing
(setq-default cursor-type 'bar)           ; Modern cursor style

;; Window management
(add-to-list 'default-frame-alist '(internal-border-width . 15)) ; Add padding around windows

;; Scrolling behavior
(setq scroll-conservatively 101           ; Smooth vertical scrolling
      scroll-margin 9                     ; Keep cursor away from edges
      scroll-step 1
      scroll-preserve-screen-position 1)

;; General behavior
(setq confirm-kill-emacs #'y-or-n-p       ; Confirm before quitting
      use-dialog-box nil                  ; Disable GUI dialogs
      confirm-nonexistent-file-or-buffer nil
      default-directory "~/notes/")       ; Default working directory

;; Font configuration
(set-face-attribute 'default nil :height 110) ; Base font size

;;; -----------------------------------------------------------------------
;;; 1.2 Line Number Configuration
;;; -----------------------------------------------------------------------
(column-number-mode)                      ; Show column numbers
(global-display-line-numbers-mode t)      ; Enable line numbers
(setq display-line-numbers-type 'relative ; Relative line numbers
      display-line-numbers-width-start t  ; Dynamic width
      display-line-numbers-width 3)

;; Disable line numbers in specific modes
(dolist (mode '(term-mode-hook shell-mode-hook eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;;; =======================================================================
;;; 2. Package Management
;;; =======================================================================
(require 'package)
(setq package-archives                    ; Package repositories
      '(("melpa" . "https://melpa.org/packages/")
        ("org"   . "https://orgmode.org/elpa/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)        ; Auto-install packages

;;; =======================================================================
;;; 3. Visual Theme & Modeline
;;; =======================================================================
(use-package doom-themes                  ; Modern color theme
  :config
  (load-theme 'doom-tokyo-night t))

(use-package doom-modeline                ; Modern modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))

;;; =======================================================================
;;; 4. Editor Enhancements
;;; =======================================================================

;;; -----------------------------------------------------------------------
;;; 4.1 Vim-style Editing (Evil Mode)
;;; -----------------------------------------------------------------------
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll nil)
  :config
  (evil-mode 1))

(use-package evil-collection               ; Evil integration for modes
  :after evil
  :config (evil-collection-init))

;;; -----------------------------------------------------------------------
;;; 4.2 Completion & Search
;;; -----------------------------------------------------------------------
(use-package vertico                       ; Vertical completion
  :init (vertico-mode)
  (setq enable-recursive-minibuffers t))

(use-package orderless                     ; Flexible matching
  :custom
  (completion-styles '(orderless basic)))

(use-package marginalia                    ; Richer annotations
  :init (marginalia-mode))

(use-package consult                       ; Enhanced search
  :init (setq consult-project-root-function #'vc-root-dir))

(use-package embark                        ; Context actions
  :bind (("C-." . embark-act))
  :init (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult                ; Consult integration
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;;; -----------------------------------------------------------------------
;;; 4.3 Help & Discovery
;;; -----------------------------------------------------------------------
(use-package which-key                     ; Keybinding help
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 1))

;;; =======================================================================
;;; 5. Keybindings & Workflow
;;; =======================================================================

;;; -----------------------------------------------------------------------
;;; 5.1 Leader Key Configuration
;;; -----------------------------------------------------------------------
(use-package general
  :config
  (general-create-definer my/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  ;; Basic navigation
  (my/leader-keys
    "oo"  '(find-file :which-key "Find file")
    "/"   '(consult-line :which-key "Search in file"))

  ;; Buffer management
  (my/leader-keys
    "b"   '(:ignore t :which-key "Buffers")
    "bb"  '(switch-to-buffer :which-key "Switch buffer"))

  ;; Window management
  (my/leader-keys
    "w"   '(:ignore t :which-key "Windows")
    "wv"  '(split-window-right :which-key "Vertical split")
    "ws"  '(split-window-below :which-key "Horizontal split")
    "wc"  '(delete-window :which-key "Close window")
    "ww"  '(other-window :which-key "Switch window"))

  ;; Org-mode specific
  (my/leader-keys
    "oa"  '(org-agenda :which-key "Agenda")
    "oc"  '(org-capture :which-key "Capture")
    "ol"  '(org-store-link :which-key "Store Link")
    "on"  '(consult-notes :which-key "Open Notes")))

;;; -----------------------------------------------------------------------
;;; 5.2 Org-mode Keybindings
;;; -----------------------------------------------------------------------
(general-define-key
 :keymaps 'org-mode-map
 :states '(normal visual)
 "C-j"   'org-metadown
 "C-k"   'org-metaup
 "C-S-j" 'org-move-subtree-down
 "C-S-k" 'org-move-subtree-up
 "C-h"   'org-do-promote
 "C-l"   'org-do-demote)

;;; =======================================================================
;;; 6. Org-mode Configuration
;;; =======================================================================
(defun my/org-mode-setup ()
  "Custom setup for Org mode."
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :hook ((org-mode . my/org-mode-setup))
  :config
  ;; Visual preferences
  (setq org-ellipsis " ▾"
        org-hide-leading-stars t
        org-hide-emphasis-markers nil
        org-link-descriptive nil)

  ;; Task management
  (setq org-todo-keywords '((sequence "TODO" "NEXT" "|" "DONE"))
        org-log-done 'time)

  ;; Agenda setup
  (setq org-agenda-files '("~/notes/org/tasks.org"
                           "~/notes/org/diploma/sem4.org")
        org-archive-location "~/notes/org/archive.org::")

  ;; Capture templates
  (setq org-capture-templates
        '(("t" "General Task" entry
           (file+headline "~/notes/org/tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %i\n  %a")
          ("d" "Diploma Task" entry
           (file+headline "~/notes/org/diploma/sem4.org" "Inbox")
           "* TODO %?\n  %U\n  %i\n  %a")))

  ;; Auto-refresh agenda on file save
  (add-hook 'after-save-hook
            (lambda ()
              (when (member (buffer-file-name)
                            (mapcar #'expand-file-name org-agenda-files))
                (org-agenda-redo)))
            nil 'local))

;;; -----------------------------------------------------------------------
;;; 6.1 Org Alert Configuration
;;; -----------------------------------------------------------------------
(setq alert-default-style 'libnotify)

(use-package org-alert
  :ensure t
  :config
  (setq org-alert-interval 300          ; Check every 5 minutes
        org-alert-notification-title "Org Reminder"
        org-alert-advance-notice-time nil)
  (org-alert-enable))

;;; -----------------------------------------------------------------------
;;; 6.2 Org Auto-Save Configuration
;;; -----------------------------------------------------------------------
(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'focus-out-hook 'org-save-all-org-buffers nil 'local)))

;;; =======================================================================
;;; 7. System Integration
;;; =======================================================================

;;; -----------------------------------------------------------------------
;;; 7.1 Dashboard Configuration
;;; -----------------------------------------------------------------------
(use-package dashboard
  :init
  (setq dashboard-startup-banner ""       ; Disable banner
        dashboard-center-content t        ; Centered layout
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-items '((agenda . 7)    ; Show 7 agenda items
                          (recents . 5)   ; Recent files
                          (bookmarks . 5)))
  :config (dashboard-setup-startup-hook))

;;; -----------------------------------------------------------------------
;;; 7.2 File Management
;;; -----------------------------------------------------------------------
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :config
  (setq dired-kill-when-opening-new-dired-buffer t))

;;; =======================================================================
;;; 8. Customizations (Auto-generated - Do not edit manually)
;;; =======================================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 '(org-agenda-files '("/home/mufeedcm/notes/org/tasks.org"
                      "/home/mufeedcm/notes/org/diploma/sem4.org"))
 '(package-selected-packages
   '(undo-tree which-key vertico orderless marginalia general evil-collection embark-consult doom-themes doom-modeline dashboard)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 )

(provide 'init)
;;; init.el ends here

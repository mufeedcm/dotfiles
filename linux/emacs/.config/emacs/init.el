;;; init.el --- Modern Org-Notes Setup -*- lexical-binding: t; -*-

;;; UI SETTINGS -------------------------------------------------------------
(setq inhibit-startup-message t)         ; Disable the startup screen
(scroll-bar-mode -1)                      ; Disable the visible scroll bar
(tool-bar-mode -1)                        ; Disable the toolbar
(menu-bar-mode -1)                        ; Disable the menu bar
(set-fringe-mode 2)                       ; Adjust fringe (if desired)
;; (setq visible-bell t)                   ; Uncomment for a visible bell
(setq scroll-conservatively 101)  ;; Scroll by lines, not full pages
(setq scroll-margin 9)            ;; Keep cursor away from top/bottom
(setq scroll-step 1)              ;; Scroll one line at a time
(setq scroll-preserve-screen-position 1)  ;; Keep cursor position while scrolling

(setq confirm-kill-emacs #'y-or-n-p)
(setq use-dialog-box nil)
(setq confirm-nonexistent-file-or-buffer nil)


(setq default-directory "~/notes/")

;; Increase default font size (adjust as needed)
(set-face-attribute 'default nil :height 110)

;;; Line numbers setup --------------------------------------------------------
(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(
		;; org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq display-line-numbers-width-start t) ;; Auto-adjust width on startup
(setq display-line-numbers-width 3) ;; Adjust to fit your needs



;;; PACKAGE MANAGEMENT ------------------------------------------------------
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org"   . "https://orgmode.org/elpa/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Bootstrap use-package if needed.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;; THEME -------------------------------------------------------------------
;; Load Doom Tokyo-Night theme (your preferred look)
(use-package doom-themes
  :config
  (load-theme 'doom-tokyo-night t))

;;; MODERN COMPLETION & SEARCH ---------------------------------------------
;; We replace Ivy/Swiper with a leaner stack.
(use-package vertico
  :init
  (vertico-mode)
  (setq enable-recursive-minibuffers t))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :init (marginalia-mode))

(use-package consult
  :bind (
	 ;; ("C-s"     . consult-line)
         ;; ("C-x b"   . consult-buffer)
         ;; ("C-x C-r" . consult-recent-file)
         ;; ("C-c r"   . consult-ripgrep) ;; Ripgrep search across files.
	 )  
  :init
  (setq consult-project-root-function #'vc-root-dir))

(use-package embark
  :bind (("C-." . embark-act))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook (embark-collect-mode . consult-preview-at-point-mode))


;;which key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))


;;; VIM-STYLE EDITING ---------------------------------------------
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (define-key evil-normal-state-map (kbd "gc") 'comment-line)
  (evil-collection-init))


;;undo
(use-package undo-tree
  :init
  (global-undo-tree-mode)
  :config
  (setq undo-tree-auto-save-history nil)) ;; Don't save undo history to files

;; Evil integration
(evil-set-undo-system 'undo-tree)


;;; Keybindings

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(setq x-super-keysym 'meta)

(use-package general
  :config
  (general-create-definer my/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (my/leader-keys
    "oo"  '(find-file :which-key "Find file")
    "b"   '(:ignore t :which-key "Buffers")
    "bb"  '(switch-to-buffer :which-key "Switch buffer")
    "w"   '(:ignore t :which-key "Windows")
    "wv"  '(split-window-right :which-key "Vertical split")
    "ws"  '(split-window-below :which-key "Horizontal split")
    "wc"  '(delete-window :which-key "Close window")
    "ww" '(other-window :which-key "Switch window")
    "wh" '(windmove-left :which-key "Move left")
    "wl" '(windmove-right :which-key "Move right")
    "wj" '(windmove-down :which-key "Move down")
    "wk" '(windmove-up :which-key "Move up")
    ;; Custom keys for Org management:
    "oa"  '(org-agenda :which-key "Org Agenda")
    "oc"  '(org-capture :which-key "Org Capture")
    "ol" '(org-store-link :which-key "Org Store Link")
    "on"  '(consult-notes :which-key "Open Notes")

    "/" '(consult-line :which-key "find in file")
    ;; "cs" (consult-line :which-key "find in file")
    ;; "cxb" (consult-buffer :which-key "search buffer")
    ;; "cxr" (consult-recent- :which-key "search recent-file")
    ;; "ccr" (consult-ripgrep :which-key "search ripgrep")
    )
  ;; Org mode keybindings
  (general-define-key
   :keymaps 'org-mode-map
   :states '(normal visual)
   "C-j" 'org-metadown
   "C-k" 'org-metaup
   "C-S-j" 'org-move-subtree-down
   "C-S-k" 'org-move-subtree-up
   "C-h" 'org-do-promote
   "C-l" 'org-do-demote
   "C-S-h" 'org-promote-subtree
   "C-S-l" 'org-demote-subtree
   ))

;;; DOOM MODELINE ----------------------------------------------------------
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))

;;; ORG MODE CONFIGURATION --------------------------------------------------
(defun my/org-mode-setup ()
  "Custom setup for Org mode."
  (org-indent-mode)
  (visual-line-mode 1))
(use-package org
  :hook ((org-mode . my/org-mode-setup))
  :config
  ;; Visual tweaks.
  (setq org-ellipsis " ▾"
        org-hide-leading-stars t
	org-hide-emphasis-markers nil
	org-link-descriptive nil
	)

(setq org-todo-keywords '((sequence "TODO" "NEXT" "|" "DONE")))
  ;; Agenda files include your personal tasks and diploma/semester notes.
  (setq org-agenda-files '("~/notes/org/tasks.org"
                           "~/notes/org/diploma/sem4/sem4.org"))
  ;; Archive completed tasks to a dedicated archive file.
  (setq org-archive-location "~/notes/org/archive.org::")
  ;; Org Capture templates.
  (setq org-capture-templates
        '(("t" "General Task" entry
           (file+headline "~/notes/org/tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %i\n  %a")
          ("d" "Diploma Task" entry
           (file+headline "~/notes/org/diploma/sem4/sem4.org" "Inbox")
           "* TODO %?\n  %U\n  %i\n  %a")))
  (setq org-log-done 'time))  ; Record timestamp when a task is marked done.



;;; DASHBOARD: WELCOME SCREEN FOR NOTES MANAGEMENT --------------------------
(use-package dashboard
  :init
  (setq dashboard-startup-banner "") ;; No banner at all
  (setq dashboard-center-content t)  ;; Doom-like centered content
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-items '((agenda . 7)   ;; Show next 7 agenda items
                          (recents  . 5) ;; Recent files
                          (bookmarks . 5))) ;; Bookmarks for quick access
  (setq dashboard-footer-messages '("")) ;; No GNU propaganda
  :config
  (dashboard-setup-startup-hook))

;;; CUSTOM FUNCTIONS FOR NOTES MANAGEMENT -------------------------------
(defun consult-notes ()
  "Open your main Org tasks file."
  (interactive)
  (find-file "~/notes/org/tasks.org"))

;;; ADDITIONAL CUSTOMIZATIONS -----------------------------------------------
;; (Add further keybindings or configurations here as desired)

(provide 'init)
;;; init.el ends here


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(undo-tree which-key visual-fill-column vertico orderless marginalia general evil-collection embark-consult doom-themes doom-modeline dashboard)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

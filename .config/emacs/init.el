;; -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(global-display-line-numbers-mode 1)
(global-auto-revert-mode 1)
(electric-pair-mode 1)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq custom-file "/dev/null")
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message "johanmi")
(setq native-comp-async-report-warnings-errors nil)

(setq scroll-margin 1000)
(setq scroll-conservatively 1000)
(setq display-line-numbers-grow-only t)

(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

(setopt use-short-answers t)

(setq calc-display-trail nil
      calc-full-mode t)

(setq message-log-max nil)
(kill-buffer "*Messages*")

(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
   (add-hook
    'before-save-hook
    (lambda ()
      (interactive)
      (indent-region (point-min) (point-max)))
    nil
    'local)))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(eval-and-compile
  (setq use-package-always-ensure t))

(use-package evil
  :custom
  (evil-want-keybinding nil)
  (evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :after evil
  :config
  (general-def 'normal 'override
    "SPC f" 'find-file
    "SPC d" 'dired
    "SPC s" 'save-buffer
    "SPC ," 'evil-delete-buffer
    "SPC m" 'magit-status
    "SPC x" (general-key "C-x")
    "SPC h" (general-key "C-h")
    "SPC w" (general-key "C-w"))
  (general-def 'insert 'global
    "C-SPC" 'company-complete))

(use-package which-key
  :config
  (which-key-mode 1))

(use-package vertico
  :config
  (vertico-mode 1))

(use-package company
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  :config
  (global-company-mode 1)
  (company-tng-mode 1))

(use-package markdown-mode
  :mode "\\.\\(?:md\\|markdown\\|mkd\\|mdown\\|mkdn\\|mdwn\\)\\'"
  :custom
  (markdown-enable-math t))

(use-package rust-mode
  :mode "\\.rs\\'"
  :custom
  (rust-format-on-save t))

(use-package doom-themes
  :config
  (load-theme 'doom-one t))

(use-package magit
  :config
  (magit-auto-revert-mode -1))

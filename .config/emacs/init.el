;; -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(global-display-line-numbers-mode 1)
(global-auto-revert-mode 1)
(electric-pair-mode 1)

(setopt make-backup-files nil)
(setopt auto-save-default nil)
(setopt custom-file "/dev/null")
(setopt inhibit-startup-screen t)
(setopt inhibit-startup-echo-area-message "johanmi")
(setopt native-comp-async-report-warnings-errors nil)
(setopt transient-save-history nil)

(setopt scroll-margin 1000)
(setopt scroll-conservatively 1000)
(setopt display-line-numbers-grow-only t)

(setopt read-file-name-completion-ignore-case t
	read-buffer-completion-ignore-case t
	completion-ignore-case t)

(setopt use-short-answers t)

(setopt calc-display-trail nil
	calc-full-mode t)

(setopt dired-kill-when-opening-new-dired-buffer t)

(setopt message-log-max nil)
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

(defun open-config ()
  (interactive)
  (find-file user-init-file))

(use-package general
  :after evil
  :config
  (general-def 'normal 'override
    "SPC c" 'open-config
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
  :commands (magit magit-status)
  :config
  (magit-auto-revert-mode -1))

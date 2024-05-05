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

(setq scroll-step 1)
(setq scroll-margin 1000)
(setq display-line-numbers-grow-only t)

(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

(setopt use-short-answers t)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :ensure t
  :after evil
  :config
  (general-def 'normal 'override
    "SPC f" 'find-file
    "SPC d" 'dired
    "SPC s" 'save-buffer
    "SPC ," 'evil-delete-buffer
    "SPC m" 'magit-status)
  (general-def 'insert 'global
    "C-SPC" 'company-complete))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (global-company-mode 1)
  (company-tng-mode 1))

(use-package markdown-mode
  :ensure t)

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

(use-package magit
  :ensure t
  :config
  (magit-auto-revert-mode -1))

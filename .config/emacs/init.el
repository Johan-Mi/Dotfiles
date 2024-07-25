;; -*- lexical-binding: t; -*-

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(use-package emacs
  :hook
  ((emacs-lisp-mode
    . (lambda ()
        (add-hook
         'before-save-hook
         (lambda ()
           (interactive)
           (indent-region (point-min) (point-max)))
         nil
         'local))))
  :custom
  (custom-file (expand-file-name "~/.config/emacs/custom.el"))
  (make-backup-files nil)
  (auto-save-default nil)
  (inhibit-startup-screen t)
  (native-comp-async-report-warnings-errors nil)
  (transient-save-history nil)
  (scroll-margin 1000)
  (scroll-conservatively 1000)
  (display-line-numbers-grow-only t)
  (frame-resize-pixelwise t)
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (completion-ignore-case t)
  (use-short-answers t)
  (eglot-ignored-server-capabilities '(:inlayHintProvider))
  (dired-kill-when-opening-new-dired-buffer t)
  (message-log-max nil)
  :config
  (load custom-file nil t)
  (setq inhibit-startup-echo-area-message "johanmi")
  (kill-buffer "*Messages*")
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (blink-cursor-mode -1)
  (line-number-mode -1)
  (global-display-line-numbers-mode 1)
  (global-auto-revert-mode 1)
  (electric-pair-mode 1)
  (setopt calc-display-trail nil
          calc-full-mode t))

(use-package evil
  :ensure t
  :custom
  (evil-want-keybinding nil)
  (evil-undo-system 'undo-redo)
  (evil-mode-line-format nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(defun open-config ()
  (interactive)
  (find-file user-init-file))

(use-package general
  :ensure t
  :after evil
  :config
  (general-def 'normal 'override
    "SPC c" 'open-config
    "SPC f" 'find-file
    "SPC d" 'dired
    "SPC s" 'save-buffer
    "SPC ," 'kill-buffer-and-window
    "SPC m" 'magit-status
    "SPC i" 'light-theme
    "SPC o" 'dark-theme
    "SPC x" (general-key "C-x")
    "SPC h" (general-key "C-h")
    "SPC w" (general-key "C-w")
    "g h" 'beginning-of-line
    "g l" 'end-of-line
    "g e" 'end-of-buffer
    "g n" 'next-buffer
    "g p" 'previous-buffer)
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
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  :config
  (global-company-mode 1)
  (company-tng-mode 1))

(use-package markdown-mode
  :ensure t
  :custom
  (markdown-enable-math t)
  (markdown-fontify-code-blocks-natively t)
  (markdown-hide-markup t)
  (markdown-list-indent-width 2))

(use-package rust-mode
  :ensure t
  :custom
  (rust-mode-treesitter-derive t)
  (rust-format-on-save t))

(defun set-theme (theme)
  (dolist (theme custom-enabled-themes)
    (disable-theme theme))
  (if (memq theme custom-known-themes)
      (enable-theme theme)
    (load-theme theme t)))

(defun light-theme ()
  (interactive)
  (set-theme 'doom-one-light))

(defun dark-theme ()
  (interactive)
  (set-theme 'doom-one)
  (set-face-attribute 'default nil :background "#020202"))

(use-package doom-themes
  :ensure t
  :config
  (let ((hour (nth 2 (decode-time))))
    (if (<= 7 hour 16)
        (light-theme)
      (dark-theme))))

(use-package magit
  :ensure t
  :commands (magit magit-status)
  :config
  (magit-auto-revert-mode -1))

(use-package parinfer-rust-mode
  :ensure t
  :hook ((emacs-lisp-mode
          . (lambda ()
              (indent-tabs-mode -1)
              (electric-pair-local-mode -1)
              (parinfer-rust-mode 1)))))

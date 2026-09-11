(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
; (line-number-mode t) ; ?
; (column-number-mode t) ; ?
(global-display-line-numbers-mode 1)
; (global-linum-mode t)
(global-visual-line-mode t) ; ?
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-frame-font "Hack Nerd Font-13")
(setq-default line-spacing 0.2)

(setq user-full-name "Andrii Gladkyi" user-mail-address "arg@arg.zone")
(setq load-prefer-newer t)
(setq gc-cons-threshold 50000000)
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
(setq ring-bell-function 'ignore)
(setq require-final-newline t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq inhibit-startup-echo-area-message t)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))
(setq linum-format "%4d ")
; after copy Ctrl+c in Linux X11, you can paste by `yank' in emacs
; (setq x-select-enable-clipboard t)

; after mouse selection in X11, you can paste by `yank' in emacs
; (setq x-select-enable-primary t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-medium t))

(use-package git-gutter
  :config
  (global-git-gutter-mode t))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  ; (setq evil-vsplit-window-right t)
  ; (setq evil-split-window-below t)
  :config
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :init
  ; (setq evil-collection-mode-list '(dashboard dired ibuffer))
  :config
  (evil-collection-init))

(use-package general
  :after evil
  :config
  (general-evil-setup t))

(use-package all-the-icons)

(use-package tree-sitter
  :config
  (global-tree-sitter-mode))

(use-package tree-sitter-langs
  :after tree-sitter
  :config
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package centaur-tabs
  :demand
  :init
  (setq centaur-tabs-style "box")
  (setq centaur-tabs-height 48)
  (setq centaur-tabs-set-close-button nil)
  (setq centaur-tabs-cycle-scope 'tabs)
  (setq centaur-tabs-label-fixed-length 20)
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

(use-package powerline
  :config
  (powerline-default-theme))

(add-hook 'evil-insert-state-exit-hook (lambda () (call-interactively #'save-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(general use-package gruvbox-theme evil-collection)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

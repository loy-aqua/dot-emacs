(setq mac-option-modifier 'nil
      mac-command-modifier 'meta)

(setq url-gateway-method 'socks)
(setq socks-server '("Default server" "127.0.0.1" 7890 5))
(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
     ("http" . "127.0.0.1:7890")
     ("https" . "127.0.0.1:7890")))

;; minimal UI
(setq inhibit-splash-screen t ;; no thanks
      use-file-dialog nil ;; don't use system file dialog
      tab-bar-new-button-show nil ;; don't show new tab button
      tab-bar-close-button-show nil ;; don't show tab close button
      tab-line-close-button-show nil) ;; don't show tab close button

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(if (display-graphic-p)
    (progn
      (setq default-frame-alist
            '((top . 120) (left . 700)
              (width . 110) (height . 45)))
      (set-face-attribute 'default nil :height 145 :family "Iosevka")
      (set-fontset-font "fontset-default" 'han (font-spec :family "Hiragino Sans GB W3"))
      (setq frame-title-format
            '(:eval (if (buffer-file-name)
                        (abbreviate-file-name (buffer-file-name)) "%b")))))

;; Get rid of Big yellow exclamation mark.
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

(setq-default
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 indent-tabs-mode nil
 visible-bell t
 vc-handled-backends nil)

(global-auto-revert-mode t)
(save-place-mode 1)
;; (desktop-save-mode 1)

(global-hl-line-mode 1)
(which-function-mode t)
(display-time-mode 1)
;; (display-battery-mode 1)

;; native line numbers
(line-number-mode -1)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(setq-default display-line-numbers-current-absolute t
              display-line-numbers-width 1
              display-line-numbers-widen t)
;; (set-face-attribute 'line-number-current-line nil
;;                     :foreground "orange")

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key [f5] 'toggle-frame-fullscreen)
(global-set-key [f10] 'toggle-frame-maximized)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-r" 'replace-string)
(global-set-key "\M-o" 'other-window)

;; Auto C-k kill
(defun kill-line-or-region ()
  "Kill region if active only or kill line normally."
  (interactive)
  (if (use-region-p)
      (call-interactively 'kill-region)
    (call-interactively 'kill-line)))
(global-set-key "\C-k" 'kill-line-or-region)

;; (global-set-key "\C-xe" 'eshell)
(global-set-key "\C-x\C-m" 'execute-extended-command)

(global-unset-key [S])
(global-unset-key [M-left])
(global-unset-key [M-right])
(global-unset-key "\C-cm")

;; Makes insert newlines if the point is at the end of the buffer.
(setq next-line-add-newlines t)

;; Stop backup & creating those #auto-save# files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Prevent undo tree files from polluting your git repo
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))


(add-to-list 'load-path "~/.emacs.d/config")


;; Bootstrap use-package
(require 'package)
(require 'use-package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ))

(setq use-package-always-ensure t)


(require 'main)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(marginalia vertico company-tabnine company lua-mode markdown-mode git-timemachine magit avy rainbow-delimiters expand-region hungry-delete exec-path-from-shell which-key auto-package-update smart-mode-line almost-mono-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

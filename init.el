;; (require 'server)
;; (unless (server-running-p)
;;   (server-start))

(setq inhibit-startup-message t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (display-graphic-p)
    (progn
      (setq default-frame-alist
            '((font . "Iosevka Term-14")
              ;; (font . "JetBrains Mono-13")
              ))
      (set-fontset-font "fontset-default" 'han (font-spec :family "FZQingKeBenYueSongS-R-GB" :size 14))
      (setq frame-title-format
            '(:eval (if (buffer-file-name)
                        (abbreviate-file-name (buffer-file-name)) "%b")))
      (set-frame-size (selected-frame) 100 50)))

(setq-default
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 indent-tabs-mode nil
 make-backup-files nil
 visible-bell t
 vc-handled-backends nil)

;; (global-font-lock-mode -1 )
(global-auto-revert-mode t)
(save-place-mode 1)
;; (desktop-save-mode 1)
(which-function-mode t)
;; (display-time-mode 1)
;; (display-battery-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)

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
;; (global-set-key "\C-x\C-m" 'execute-extended-command)

(global-unset-key [S])
(global-unset-key [M-left])
(global-unset-key [M-right])
(global-unset-key "\C-cm")

;; Makes insert newlines if the point is at the end of the buffer.
(setq next-line-add-newlines t)


;; Stop backup & creating those #auto-save# files
(setq make-backup-files nil)
(setq auto-save-default nil)

(add-to-list 'load-path "~/.emacs.d/config")

;; Auto-save from
;; https://github.com/manateelazycat/auto-save/blob/master/auto-save.el
(require 'auto-save)
(auto-save-enable)
(setq auto-save-silent t)   ; quietly save
(setq auto-save-delete-trailing-whitespace t)  ; automatically delete spaces at the end of the line when saving

;;; custom predicates if you don't want auto save.
;;; disable auto save mode when current filetype is an gpg file.
(setq auto-save-disable-predicates
      '((lambda ()
          (string-suffix-p
           "gpg"
           (file-name-extension (buffer-name)) t))))

;; (setq auto-save-visited-file-name t)


;; Auto-login for sql-postgres
;; Change to your own params
(setq sql-postgres-login-params
      '((user :default "loyaqua")
        (database :default "postgres")
        (server :default "localhost")
        (port :default 5432)))



;; Bootstrap use-package
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(
                         ("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ;; ("org" . "https://orgmode.org/elpa/")
                         ))
(setq use-package-always-ensure t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(require 'main)


;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (counsel-projectile projectile yasnippet-snippets yari yaml-mode which-key web-mode use-package undo-propose smartparens smart-mode-line rjsx-mode rainbow-delimiters minimal-theme magit lsp-mode iedit hungry-delete google-this expand-region exec-path-from-shell emmet-mode counsel company chruby avy aggressive-indent))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-selector ((t (:inherit default :foreground "#66CCFF"))))
 '(font-lock-comment-face ((t (:foreground "#828282")))))

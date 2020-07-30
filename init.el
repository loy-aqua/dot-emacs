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

;; Save all tempfiles in $TMPDIR/emacs$UID/                                                        
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)


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
                         ("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ))
(setq use-package-always-ensure t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(add-to-list 'load-path "~/.emacs.d/config")
(require 'main)
;; (require 'org-config)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet-classic-snippets yasnippet yaml-mode company-lsp lsp-mode chruby rjsx-mode emmet-mode web-mode markdown-mode counsel swiper ivy magit rainbow-delimiters aggressive-indent smartparens expand-region google-this iedit hungry-delete undo-propose exec-path-from-shell which-key smart-mode-line minimal-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-selector ((t (:inherit default :foreground "#66CCFF"))))
 '(font-lock-comment-face ((t (:foreground "#828282")))))

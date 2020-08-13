;; (use-package eziam-dark-theme
;;   :ensure eziam-theme
;;   :defer t
;;   :init (load-theme 'eziam-dark t))
(use-package minimal-theme
  :defer t
  :init (load-theme 'minimal t))

(use-package smart-mode-line
  :config
  (setq sml/theme 'dark)
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

;;
;; Auto-saves your buffers
;; (use-package real-auto-save
;;   :hook (prog-mode-hook . real-auto-save-mode)
;;   :config
;;   (setq real-auto-save-interval 1)) ;; in seconds

;; A feature that displays the key bindings following the incomplete command.
(use-package which-key
  :defer 5
  :diminish
  :commands which-key-mode
  :config
  (which-key-mode))

;; Load shell variables.
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  (setq exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-initialize))


(use-package undo-propose
  :commands undo-propose)


;; Deleting all whitespace until the next non-whitespace character
(use-package hungry-delete
  :config
  (global-hungry-delete-mode))


;; Edit multiple regions in the same way simultaneously
(use-package iedit
  :defer t)


;; Google-this
(use-package google-this
  :config
  (google-this-mode 1))


(use-package expand-region
  :bind ("C-=" . er/expand-region))


(use-package smartparens
  :hook
  ((emacs-lisp-mode ruby-mode js-mode) . smartparens-mode)
  ;; (after-init . smartparens-global-mode)
  :custom
  (sp-highlight-pair-overlay nil)
  (sp-highlight-wrap-overlay nil)
  (sp-highlight-wrap-tag-overlay nil)
  :config
  (show-paren-mode 0)
  (remove-hook 'web-mode-hook #'smartparens-mode)
  (require 'smartparens-config)
  :diminish smartparens-mode)


(use-package aggressive-indent
  :diminish
  :config (global-aggressive-indent-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x G" . magit-status-with-prefix)))

(use-package projectile
  :defer 5
  :diminish
  ;; :bind* (("C-c TAB" . projectile-find-other-file)
  ;;         ("C-c P" . (lambda () (interactive)
  ;;                      (projectile-cleanup-known-projects)
  ;;                      (projectile-discover-projects-in-search-path))))
  :bind-keymap ("M-p" . projectile-command-map)
  :config
  (projectile-global-mode))


;; Ivy, a generic completion mechanism.
(use-package ivy
  :diminish
  :init
  (ivy-mode 1)
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-x B" . ivy-switch-buffer-other-window)
         ("C-c C-r"   . ivy-resume)) ; Resume last Ivy-based completion
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-height 10)
  (ivy-wrap t))

(use-package swiper
  :defer t
  :after ivy
  :bind
  ("C-s" . swiper)
  :custom
  (swiper-goto-start-of-match t))

(use-package counsel
  :diminish
  :after ivy
  :bind
  (("C-x C-m" . counsel-M-x)
   ("C-x C-o" . counsel-recentf)
   ("C-x C-a" . counsel-ag)
   :map ivy-minibuffer-map
   ("C-m" . ivy-alt-done))
  :config (counsel-mode 1))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode 1))

(use-package counsel-etags
  :ensure t
  :bind (("C-]" . counsel-etags-find-tag-at-point))
  :init
  (add-hook 'prog-mode-hook
            (lambda ()
              (add-hook 'after-save-hook
                        'counsel-etags-virtual-update-tags 'append 'local)))
  :config
  (setq counsel-etags-update-interval 60)
  (push "build" counsel-etags-ignore-directories))


(use-package avy
  :bind (("C-;" . avy-goto-char)
         ("C-'" . avy-goto-char-2)))


;; (use-package flycheck)


(use-package markdown-mode
  :mode ("\\.markdown\\'" "\\.md\\'"))


;; MMM mode lets you edit multiple languages within one buffer.
;; (use-package mmm-mode
;;   :commands mmm-mode
;;   :config
;;   (use-package mmm-auto
;;     :after mmm-mode
;;     :ensure nil))

;; A major mode for editing web templates.
(use-package web-mode
  :commands web-mode
  :custom-face
  (css-selector ((t (:inherit default :foreground "#66CCFF"))))
  (font-lock-comment-face ((t (:foreground "#828282"))))
  :mode
  ("\\.phtml\\'" "\\.tpl\\.php\\'" "\\.[agj]sp\\'" "\\.as[cp]x\\'"
   "\\.erb\\'" "\\.mustache\\'" "\\.djhtml\\'" "\\.[t]?html?\\'")
  :config
  (setq web-mode-engines-alist
        '(("php"    . "\\.phtml\\'")
          ("ruby"  . "\\.erb\\."))))



;; feature that allows writing HTML using CSS selectors along with C-j
(use-package emmet-mode
  :hook ((web-mode css-mode html-mode sgml-mode) . emmet-mode))



;; Ruby on Rails
;; -------------
(use-package chruby
  :config (chruby "ruby-2.6.6"))

;; (use-package smart-newline
;;   :diminish
;;   :commands smart-newline-mode
;;   :config
;;   (smart-newline-mode 1))

;; (use-package projectile-rails
;;   :bind-keymap ("C-c r" . projectile-rails-command-map)
;;   :config
;;   (projectile-rails-global-mode))


;; gem install solargraph
(use-package eglot
  :commands eglot
  :config
  (setq eglot-ignored-server-capabilites '(:documentHighlightProvider)
        eglot--mode-line-format "LSP")
  (advice-add 'eglot-eldoc-function :around
              (lambda (oldfun)
                (let ((help (help-at-pt-kbd-string)))
                  (if help (message "%s" help) (funcall oldfun)))))
  ;; Automatically recognizes xxx-language-server
  :hook ((ruby-mode . eglot-ensure))
  ;; (ruby-mode . (lambda () (flycheck-mode -1))))
  :bind (:map eglot-mode-map
              ("C-c h" . eglot-help-at-point)))



(use-package yari
  :init
  (add-hook 'ruby-mode-hook
            (lambda ()
              (local-set-key [f1] 'yari))))


(use-package yaml-mode
  :mode ("\\.yml\\'")
  :bind ("C-m" . 'newline-and-indent))


(use-package company
  :custom
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  (company-begin-commands '(self-insert-command))
  (company-require-match 'never)
  ;; Don't use company in the following modes
  (company-global-modes '(not shell-mode eaf-mode))
  ;; Trigger completion immediately.
  (company-idle-delay 0)
  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (company-show-numbers t)
  :config
  (global-company-mode 1))


(use-package yasnippet
  :demand t
  :diminish yas-minor-mode
  :init
  (use-package yasnippet-snippets :after yasnippet )
  :bind (("C-c y d" . yas-load-directory)
         ("C-c y i" . yas-insert-snippet)
         ("C-c y f" . yas-visit-snippet-file)
         ("C-c y n" . yas-new-snippet)
         ("C-c y t" . yas-tryout-snippet)
         ("C-c y l" . yas-describe-tables)
         ("C-c y g" . yas/global-mode)
         ("C-c y m" . yas/minor-mode)
         ("C-c y r" . yas-reload-all)
         ("C-c y x" . yas-expand))
  :bind (:map yas-keymap
              ("C-i" . yas-next-field-or-maybe-expand))
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  :config
  (yas-global-mode 1))



(provide 'main)

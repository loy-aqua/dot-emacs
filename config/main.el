;; (use-package almost-mono-themes
;;   :config
;;   ;; (load-theme 'almost-mono-black t)
;;   ;; (load-theme 'almost-mono-gray t)
;;   ;; (load-theme 'almost-mono-cream t)
;;   (load-theme 'almost-mono-white t)
;;   )
(load-theme 'leuven)


(use-package smart-mode-line
  :config
  (setq sml/theme 'respectful)
  (setq sml/no-confirm-load-theme t)
  (sml/setup))


;; Automatically update Emacs packages.
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-interval 4)
  (auto-package-update-maybe))


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


;; Deleting all whitespace until the next non-whitespace character
(use-package hungry-delete
  :config
  (global-hungry-delete-mode))


(use-package expand-region
  :bind ("C-=" . er/expand-region))


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;; Nice way to move around text.
(use-package avy
  :defer t
  :bind
  (("C-;" . avy-goto-char-timer)
   ("C-'" . avy-goto-line))
  :custom
  (avy-timeout-seconds 0.3)
  (avy-style 'pre)
  :custom-face
  (avy-lead-face ((t (:background "#51afef" :foreground "#870000" :weight bold)))));


(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x G" . magit-status-with-prefix)))

(use-package git-timemachine
  :bind (("C-c g" . git-timemachine)))


(use-package markdown-mode
  :mode ("\\.markdown\\'" "\\.md\\'"))


(use-package lua-mode
  :mode ("\\.lua\\'" "\\.script\\'"))


(use-package company
  :custom
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  (company-begin-commands '(self-insert-command))
  (company-require-match 'never)
  ;; Don't use company in the following modes
  (company-global-modes '(not shell-mode eaf-mode text-mode))
  ;; Trigger completion immediately.
  (company-idle-delay 0)
  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (company-show-numbers t)
  :config
  (global-company-mode 1))


;; LSP
;; (use-package lsp-mode
;;   :ensure t
;;   :defer t
;;   :commands lsp
;;   :custom
;;   (lsp-clients-lua-language-server-bin "/usr/local/bin/lua-language-server")
;;   (lsp-clients-lua-language-server-command "lua-language-server")
;;   (lsp-clients-lua-language-server-install-dir "/usr/local/Cellar/lua-language-server/3.6.7/libexec/bin")
;;   (lsp-clients-lua-language-server-main-location "/usr/local/Cellar/lua-language-server/3.6.7/libexec/bin/main.lua")
    ;; (lsp-keymap-prefix "C-x l")
  ;; (lsp-auto-guess-root nil)
  ;; (lsp-prefer-flymake nil) ; Use flycheck instead of flymake
  ;; (lsp-enable-file-watchers nil)
  ;; (lsp-enable-folding nil)
  ;; (read-process-output-max (* 1024 1024))
  ;; (lsp-keep-workspace-alive nil)
  ;; (lsp-eldoc-hook nil)
  ;; :bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
  ;; :hook ((lua-mode java-mode python-mode go-mode rust-mode
  ;;         js-mode js2-mode typescript-mode web-mode
  ;;         c-mode c++-mode objc-mode) . lsp-deferred)
  ;; :config
  ;; (defun lsp-update-server ()
  ;;   "Update LSP server."
  ;;   (interactive)
  ;;   ;; Equals to `C-u M-x lsp-install-server'
  ;;   (lsp-install-server t)))

;; LSP UI, lsp-ui-doc is too annoying, so it will not be triggered upon hovering. You have to toggle it using M-i.
;; (use-package lsp-ui
;;   :after lsp-mode
;;   :diminish
;;   :commands lsp-ui-mode
;;   :custom-face
;;   (lsp-ui-doc-background ((t (:background nil))))
;;   (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
;;   :bind
;;   (:map lsp-ui-mode-map
;;         ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
;;         ([remap xref-find-references] . lsp-ui-peek-find-references)
;;         ("C-c u" . lsp-ui-imenu)
;;         ("M-i" . lsp-ui-doc-focus-frame))
;;   (:map lsp-mode-map
;;         ("M-n" . forward-paragraph)
;;         ("M-p" . backward-paragraph))
;;   :custom
;;   (lsp-ui-doc-header t)
;;   (lsp-ui-doc-include-signature t)
;;   (lsp-ui-doc-border (face-foreground 'default))
;;   (lsp-ui-sideline-enable nil)
;;   (lsp-ui-sideline-ignore-duplicate t)
;;   (lsp-ui-sideline-show-code-actions nil)
;;   :config
;;   ;; Use lsp-ui-doc-webkit only in GUI
;;   (when (display-graphic-p)
;;     (setq lsp-ui-doc-use-webkit t))
;;   ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
;;   ;; https://github.com/emacs-lsp/lsp-ui/issues/243
;;   (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
;;     (setq mode-line-format nil))
;;   ;; `C-g'to close doc
;;   (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide))



;; Run M-x company-tabnine-install-binary to install the binary.
(use-package company-tabnine
  :defer
  :custom
  (company-tabnine-max-num-results 9)
  ;; :init
  ;; (defun company//sort-by-tabnine (candidates)
  ;;   "Integrate company-tabnine with lsp-mode"
  ;;   (if (or (functionp company-backend)
  ;;           (not (and (listp company-backend) (memq 'company-tabnine company-backends))))
  ;;       candidates
  ;;     (let ((candidates-table (make-hash-table :test #'equal))
  ;;           candidates-lsp
  ;;           candidates-tabnine)
  ;;       (dolist (candidate candidates)
  ;;         (if (eq (get-text-property 0 'company-backend candidate)
  ;;                 'company-tabnine)
  ;;             (unless (gethash candidate candidates-table)
  ;;               (push candidate candidates-tabnine))
  ;;           (push candidate candidates-lsp)
  ;;           (puthash candidate t candidates-table)))
  ;;       (setq candidates-lsp (nreverse candidates-lsp))
  ;;       (setq candidates-tabnine (nreverse candidates-tabnine))
  ;;       (nconc (seq-take candidates-tabnine 3)
  ;;              (seq-take candidates-lsp 6)))))
  ;; (defun lsp-after-open-tabnine ()
  ;;   "Hook to attach to `lsp-after-open'."
  ;;   (setq-local company-tabnine-max-num-results 3)
  ;;   (add-to-list 'company-transformers 'company//sort-by-tabnine t)
  ;;   (add-to-list 'company-backends '(company-capf :with company-tabnine :separate)))
  ;; (defun company-tabnine-toggle (&optional enable)
  ;;   "Enable/Disable TabNine. If ENABLE is non-nil, definitely enable it."
  ;;   (interactive)
  ;;   (if (or enable (not (memq 'company-tabnine company-backends)))
  ;;       (progn
  ;;         (add-hook 'lsp-after-open-hook #'lsp-after-open-tabnine)
  ;;         (add-to-list 'company-backends #'company-tabnine)
  ;;         (when (bound-and-true-p lsp-mode) (lsp-after-open-tabnine))
  ;;         (message "TabNine enabled."))
  ;;     (setq company-backends (delete 'company-tabnine company-backends))
  ;;     (setq company-backends (delete '(company-capf :with company-tabnine :separate) company-backends))
  ;;     (remove-hook 'lsp-after-open-hook #'lsp-after-open-tabnine)
  ;;     (company-tabnine-kill-process)
  ;;     (message "TabNine disabled."))))
  )
(add-to-list 'company-backends #'company-tabnine)
(setq company-idle-delay 0) ;; Trigger completion immediately.



;; Minibuffer completions.
(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Enable minibuffer completion rich annotations.
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init ;; The :init section gets enabled right away. Forces loading the package. 
  (marginalia-mode))




(provide 'main)

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


(require 'auto-complete)
(global-auto-complete-mode t)
(setq ac-dwim t)

(require 'undo-tree)
(setq undo-limit 10000)
(setq undo-strong-limit 20000)
(global-undo-tree-mode)
(global-set-key (kbd "C-]") 'undo-tree-redo)

(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-^") 'er/contract-region)
(transient-mark-mode t)

(require 'smartparens-config)
(smartparens-global-mode t)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)


(load-theme 'tango-dark)


;;スタートアップ時のメッセージを隠す設定
(setq inhibit-startup-message t)

;;対応するかっこにハイライト
(show-paren-mode)

;;モードラインに時刻を表示する
(display-time)

;;行番号・桁番号を表示する
(line-number-mode 1)
(column-number-mode 1)

; バックアップファイルの無効化
(setq make-backup-files nil)
(setq auto-save-default nil)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck expand-region rainbow-delimiters smartparens undo-tree auto-complete yasnippet helm magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(require 'helm)


(require 'linum)
(global-linum-mode 1)

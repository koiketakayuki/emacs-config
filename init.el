;;(package-initialize)

(require 'cask)
(cask-initialize)

;; ================ ;;
;;  package config  ;;
;; ================ ;;

;; helm config
(helm-mode 1)

;; auto-complete config
(global-auto-complete-mode t)
(setq ac-dwim t)

;; undo-tree config
(setq undo-limit 10000)
(setq undo-strong-limit 20000)
(global-undo-tree-mode)
(global-set-key (kbd "C-]") 'undo-tree-redo)
(custom-set-variables '(undo-tree-mode-lighter ""))

;; expand-region config
(global-set-key (kbd "M-n") 'er/expand-region)
(global-set-key (kbd "M-p") 'er/contract-region)
(transient-mark-mode t)

;; rainbow-delimiters config
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; flycheck config
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; magit config
(global-set-key (kbd "C-x g") 'magit-status)
(global-linum-mode 1)

;; anzu config
(global-anzu-mode +1)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000))

;; volatile-highlights config
(volatile-highlights-mode t)

;; sequential-command config
(require 'sequential-command)
(define-sequential-command seq-home
  beginning-of-line beginning-of-buffer seq-return)
(define-sequential-command seq-end
  end-of-line end-of-buffer seq-return)

(global-set-key "\C-a" 'seq-home)
(global-set-key "\C-e" 'seq-end)

;; multiple-cursors config
(require 'multiple-cursors)
(require 'smartrep)

(declare-function smartrep-define-key "smartrep")
(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C-M-r") 'mc/mark-all-in-region)
(global-unset-key "\C-t")

(smartrep-define-key global-map "C-t"
  '(("C-t"      . 'mc/mark-next-like-this)
    ("n"        . 'mc/mark-next-like-this)
    ("p"        . 'mc/mark-previous-like-this)
    ("m"        . 'mc/mark-more-like-this-extended)
    ("u"        . 'mc/unmark-next-like-this)
    ("U"        . 'mc/unmark-previous-like-this)
    ("s"        . 'mc/skip-to-next-like-this)
    ("S"        . 'mc/skip-to-previous-like-this)
    ("*"        . 'mc/mark-all-like-this)
    ("d"        . 'mc/mark-all-like-this-dwim)
    ("i"        . 'mc/insert-numbers)
    ("o"        . 'mc/sort-regions)
    ("O"        . 'mc/reverse-regions)))

;; powerline config
(require 'powerline)

(defun powerline-my-theme ()
  "Setup the my mode-line."
  (interactive)
  (set-face-attribute 'mode-line nil
                      :box nil)
  (set-face-attribute 'powerline-active1 nil
                      :foreground "#ffffff"
                      :background "#0178bc"
                      :inherit 'mode-line
                      :weight 'bold)
  (set-face-attribute 'powerline-active2 nil
                      :foreground "#ffffff"
                      :background "#009dc6"
                      :inherit 'mode-line)
  (setq ns-use-srgb-colorspace nil)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator (intern (format "powerline-%s-%s"
                                                     (powerline-current-separator)
                                                     (car powerline-default-separator-dir))))
                          (vc-info (list (powerline-vc face1 'r)
                                         (funcall separator face1 face2)))
                          (file-info (list (powerline-buffer-id face2 'l)
                         (powerline-raw "(%l:" face2 'l)
                         (powerline-raw "%c)" face2 'r)
                         (powerline-raw "%6p" face2 'r)
                         (funcall separator face2 mode-line)))
                          (mode-info (list (powerline-raw " MajorMode:" nil 'r)
                                           (powerline-major-mode nil 'r)
                                           (powerline-raw " MinorMode:" nil 'r)
                                           (powerline-minor-modes nil 'r)
                                           (powerline-narrow nil 'r))))
                     (concat (powerline-render vc-info)
                             (powerline-render file-info)
                             (powerline-render mode-info)))))))

(powerline-my-theme)

;; ================ ;;
;;  general config  ;;
;; ================ ;;

;; theme
(load-theme 'tango-dark)

(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-default nil)

(show-paren-mode)
(line-number-mode 1)
(column-number-mode 1)
;;(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-x C-t") 'goto-line)

;; tab to whitespace
(setq-default tab-width 2 indent-tabs-mode nil)

;; whitespace
(require 'whitespace)
(setq whitespace-style
      '(face
        trailing
        tabs
        spaces
        empty
        space-mark
        tab-mark))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; display only full-width whitespaces
(setq whitespace-space-regexp "\\(\u3000+\\)")

(global-whitespace-mode 1)

(defvar my/bg-color "#232323")
(set-face-attribute 'whitespace-trailing nil
                    :background my/bg-color
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :background my/bg-color
                    :foreground "LightSkyBlue"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :background my/bg-color
                    :foreground "GreenYellow"
                    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
                    :background my/bg-color)

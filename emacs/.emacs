;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;; Evil-mode
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen
;;;
;;; Org Mode
;;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;; set org directory
(custom-set-variables
 '(org-directory "~/org")
 '(org-agenda-files (list org-directory)))
(setq
 ;; hide stars in headlines
 org-hide-leading-stars t
 ;; indent
 org-startup-indented t
 )
;; start agenda from current day
(setq org-agenda-start-on-weekday nil)
;; insert coing timestamp
(setq org-log-done 'time)

;; Line numbers
(global-display-line-numbers-mode)

;; do not save to clipboard on exit --> it lags
(setq x-select-enable-clipboard-manager nil)


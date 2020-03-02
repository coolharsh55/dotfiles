;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)
;; Enable transient mark mode
(transient-mark-mode 1)
;; Evil-mode
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
;; Line numbers
; (global-display-line-numbers-mode)
(setq-default display-line-numbers-type 'visual
              display-line-numbers-current-absolute t
              ; display-line-numbers-width 4
              display-line-numbers-widen t)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
;; relative line numbers
(setq display-line-numbers 'relative)
;; do not save to clipboard on exit --> it lags
(setq x-select-enable-clipboard-manager nil)
;; line characters 80
(add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
(add-hook 'org-mode-hook 'turn-on-auto-fill)

;; package-installed
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)

;; solarized theme
(load-theme 'solarized-light t)

;;;;;;;;;;;;; Org mode configuration ;;;;;;;;;;;;;;;;;;;;;

;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;; set org directory
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (list org-directory))
 '(org-directory "~/org")
 '(package-selected-packages (quote (org-super-agenda solarized-theme))))
(setq
    ;; hide stars in headlines
    org-hide-leading-stars t
    ;; indent
    org-startup-indented t
    )
;; org super agenda
; (require 'org-super-agenda)
;; start agenda from current day
(setq org-agenda-start-on-weekday nil)
;; insert coing timestamp
(setq org-log-done 'time)
;; disable deadline reminders when tasks are scheduled
(setq org-agenda-skip-deadline-prewarning-if-scheduled t)
;; block TODO parent tasks until children are done
(setq org-enforce-todo-dependencies t)
;; disable timestamp in headlines from appearing in agenda view
(setq org-agenda-search-headline-for-time nil)
;; TODO states
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s!)" "|" "DONE(d!)" )
        (sequence "WAITING(w@/!)" "DEFERRED(f@/!)") 
        (sequence "|" "CANCELED(c@/!)")))
;; store notes in reverse order
(setq org-reverse-note-order t)
;; show effort for the day in agenda
(setq org-agenda-columns-add-appointments-to-effort-sum t)
(setq org-columns-default-format "%40ITEM(Task) %TODO %6Effort(Estim){:}  %6CLOCKSUM(Clock) %TAGS")
;; persist clock history across sessions
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)
;; Enable transient mark mode
(transient-mark-mode 1)
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
;; move between windows/frames
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
;; org-bullets
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; allow letters in bullets and lists
(setq org-list-allow-alphabetical t)

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

;;;;;;;;; packages ;;;;;;;;;;;;;;

;; Evil-mode
(require 'evil)
(evil-mode 1)

;; solarized theme
; (load-theme 'solarized-light t)
; (load-theme 'solarized-zenburn t)
(load-theme 'poet t)
(add-hook 'text-mode-hook
    (lambda ()
        (variable-pitch-mode 1)))

;; theming
(olivetti-mode 1)        ;; Centers text in the buffer
(flyspell-mode 1)        ;; Catch Spelling mistakes
(blink-cursor-mode 0)    ;; Reduce visual noise
(linum-mode 0)           ;; No line numbers for prose
(set-face-attribute 'default nil :family "Hack" :height 100)
(set-face-attribute 'fixed-pitch nil :family "Hack" :height 100)
(set-face-attribute 'variable-pitch nil :family "ETBembo" :height 125)


;; yasnippets
;; org-mode compatibility
(defun yas/org-very-safe-expand ()
    (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
(add-hook 'org-mode-hook
    (lambda ()
        (yas-minor-mode)
        (make-variable-buffer-local 'yas/trigger-key)
        (setq yas/trigger-key [tab])
        (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
        (define-key yas/keymap [tab] 'yas/next-field)))
(yas-global-mode 1)

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
 '(custom-safe-themes
   (quote
    ("51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "2d835b43e2614762893dc40cbf220482d617d3d4e2c35f7100ca697f1a388a0e" default)))
 '(org-agenda-files (list org-directory))
 '(org-directory "~/org")
 '(org-modules
   (quote
    (org-docview org-gnus org-habit org-info org-w3m org-checklist)))
 '(org-stuck-projects
   (quote
    ("+LEVEL=1/-DONE"
     ("TODO" "NEXT" "NEXTACTION" "STARTED" "WAITING" "PAUSED" "APPT")
     nil "")))
 '(package-selected-packages
   (quote
    (poet-theme helm-org helm-org-rifle yasnippet org-caldav org-ql org-bullets org-ql org-super-agenda cyberpunk-theme solarized-theme))))
(setq
    ;; hide stars in headlines
    org-hide-leading-stars t
    ;; indent
    org-startup-indented t
    )
;; start agenda from current day
(setq org-agenda-start-on-weekday nil)
;; disable deadline reminders when tasks are scheduled
(setq org-agenda-skip-deadline-prewarning-if-scheduled t)
;; block TODO parent tasks until children are done
(setq org-enforce-todo-dependencies t)
;; do not show deadlines and scheduled items in agenda if done
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
;; disable timestamp in headlines from appearing in agenda view
(setq org-agenda-search-headline-for-time nil)
;; TODO states
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s!)" "|" "DONE(d!)" )
        (sequence "PAUSED(p@/!)" "WAITING(w@/!)" "DEFERRED(f@/!)" "|") 
        (sequence "APPT(m)" "|")
        (sequence "|" "CANCELED(c@/!)")
        ))
(setq org-todo-keyword-faces
      '(("TODO" . "red") ("STARTED" . "tomato") ("DONE" . "dark green")
        ("PAUSED" . "chocolate") ("WAITING" . "magenta") ("DEFERRED" . "dark orange")
        ("APPT" . "brown") ("CANCELED" . "olive")
        ))
;; store notes in reverse order
(setq org-reverse-note-order t)
;; show effort for the day in agenda
(setq org-agenda-columns-add-appointments-to-effort-sum t)
;; agenda column view
(setq org-columns-default-format "%1PRIORITY(IMP) %TODO(Status) %6CATEGORY(CAT.) %40ITEM(Task) %6Effort(Effort){:}  %5CLOCKSUM(Clock) %5CLOCKSUM_T(Clock_T) %TAGS")
;; persist clock history across sessions
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
;; set drawer for logs
(setq org-log-into-drawer "LOGBOOK")
;; show repeated tasks in log mode
(setq org-agenda-log-mode-items '(closed clock state))
;; Set default effort estimates
(setq org-global-properties '(("EFFORT_ALL". "0:05 0:15 0:30 1:00 1:30 2:00")))
;; show habits in agenda
; (setq org-habit-show-all-today t
;       org-habit-show-all-today t)
;; org structured templates
(define-key org-mode-map (kbd "C-<f1>") 'org-insert-structure-template)
;; org-rifle
(define-key org-mode-map (kbd "C-c C-f") 'helm-org-agenda-files-headings)
;; prevent editing collapsed trees
(setq org-catch-invisible-edits 'show-and-error)
;; show only headlines in subtree
;; org-kill-note-or-show-branches C-c C-k
;; do not show empty lines between sections
(setq org-cycle-separator-lines 0)
;; sequence for list bullets
(setq org-list-demote-modify-bullet '(("-" . "+") ("+" . "-") ("*" . "-")))
;; refiling
(setq org-refile-targets '((nil :maxlevel . 5)
                                (org-agenda-files :maxlevel . 5)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling
;; hide formatting markers symbols
(setq org-hide-emphasis-markers t)


;; Thunderlink. Open an email in Thunderbird with ThunderLink.
(defun org-thunderlink-open (path)
  (start-process "thunderlink" nil "thunderbird" "-thunderlink" (concat "thunderlink:" path)))
(org-link-set-parameters
    "thunderlink"
    :follow 'org-thunderlink-open
    :face '(:foreground "darkmagenta" :underline t))
;; TAG list
(setq org-tag-alist '(
    (:startgrouptag)("People")
        (:grouptags)
            ("@ADAPT")("@AdvCIS")("@Academia")("@DPVCG")("@Supervision")
        	(:endgrouptag)
        (:startgrouptag)
            ("@ADAPT")(:grouptags)("@DL")("@DOS")("@ChristopheD")
        	(:endgrouptag)
        (:startgrouptag)
            ("@AdvCIS")(:grouptags)("@MarkL")("@VitorJ")("@JanL")("@PaulK")
        	(:endgrouptag)
        (:startgrouptag)
            ("@Academia")(:grouptags)("@SabrinaK")
        	(:endgrouptag)
        (:startgrouptag)
            ("@DPVCG")(:grouptags)("@BertB")("@AxelP")("@MarkL")
        	(:endgrouptag)
        (:startgrouptag)
            ("@Supervision")(:grouptags)("@DerrickAmponsa")("@EoinLeahy")("@DhruvSachdev")("@DarraghMasterson")("@AnkitaKalra")
        	(:endgrouptag)
    	(:endgrouptag)
    (:startgrouptag)("Organisation")
    	(:grouptags)("#adapt")("#signatu")("#tcd")("#dcu")
    	(:endgrouptag)
    (:startgrouptag)("Academia")
    	(:grouptags)
    		("#conference")("#journal")("#publication")("#meeting")
    		(:endgrouptag)
    	(:startgrouptag)
    		("#conference")(:grouptags)("SEMANTiCS")("ISWC")("ESWC")
    		(:endgrouptag)
    	(:startgrouptag)
    		("#journal")(:grouptags)("KAIS")
    		(:endgrouptag)
    	(:endgrouptag)
    (:startgrouptag)("Context")
		(:grouptags)("#email")("#call")("#online")
    	(:endgrouptag)
    (:startgrouptag)("_Action")
    	(:grouptags)("_read")("_write")("_review")("_plan")("_think")("_analyse")
    	(:endgrouptag)
    (:startgrouptag)("__Schedule")
    	(:grouptags)("__NOW")("__URGENT")("__NEXT")("__SOON")("__SOMEDAY")
    	(:endgrouptag)
    ))

;;;;;;;;;;; Custom Agenda Views ;;;;;;;;;;;;;
;; TODOS that don't have a schedule or deadline
(setq org-agenda-custom-commands
	;; match those tagged with :inbox:, are not scheduled, are not DONE.
	'(("L" "TODO items in Limbo" ((alltodo ""
		((org-agenda-skip-function
			(lambda nil
				(org-agenda-skip-entry-if 'scheduled 'deadline)))
	     (org-agenda-overriding-header "TODO items in Limbo")))))
    ("A" "Super Agenda - Daily" ((agenda "" ((org-agenda-span 'day)
     (org-super-agenda-groups
       '(
         (:name "Logbook"
                :log t)
         (:name "Meetings"
                ; :time-grid t  ; Items that appear on the time grid
                :todo "APPT")
         (:name "Important"
                :deadline past
                :deadline today
                :priority "A"
                :face (:foreground "firebrick"))
         (:name "Scheduled for Today"
                :scheduled today)
         (:name "Waiting"
                :todo "WAITING")
         (:name "Overdue"
                :scheduled past)
         (:name "Upcoming"
                :deadline future)
         ))))))
    ("Vg" "Super Agenda - Grouped" ((agenda "" ((org-agenda-span 'day)
        (org-super-agenda-groups
          '((:auto-category t))
          )))))
    ))

;;; Super Agenda
; (org-agenda nil "a")
(org-super-agenda-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;; HOOKS ;;;;;;;;;;;;;;;;;;;;;;

;; TODO STATE CHANGE
(add-hook 'org-trigger-hook 
    (lambda (arg)
        ;; APPT -> STARTED: timer-stop
        (when (and (string= (plist-get arg :from) 'APPT)
                   (string= (plist-get arg :to) 'STARTED))
            (save-excursion
                (org-timer-start)
                ))
        ;; STARTED -> DONE: timer-start
        (when (and (string= (plist-get arg :from) 'STARTED)
                   (string= (plist-get arg :to) 'DONE))
            (save-excursion
                (org-timer-stop)
                ))
        ;; anything -> STARTED: clock-in
        (when (and (not (string= (plist-get arg :from) 'APPT))
                   (string= (plist-get arg :to) 'STARTED))
            (save-excursion
                (org-clock-in)
                ))
        ;; STARTED -> anything: clock-out
        (when (and (string= (plist-get arg :from) 'STARTED))
            (save-excursion
                (org-clock-out)
                ))
  ))

;;;;;;;;;; capture templates ;;;;;;;;;;
(setq org-default-notes-file "~/temp.org")
(define-key global-map (kbd "C-c x") 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/temp.org" "Captured Tasks")
         "* TODO %?\n %U %i\n %f %a")
        ("n" "Note" entry (file+datetree "~/org/temp.org" "Notes")
         "* %?\n %U %i\n %f %a")
        ))

;;;;;;; logging tempalte ;;;;;;;;
(setq 
    org-log-into-drawer t
    org-log-done 'time
    org-log-reschedule 'note
    org-log-redeadline 'note
    org-log-delschedule 'note
    org-log-deldeadline 'note
    org-log-note-headings '((done        . "CLOSING NOTE %t")
                           (state       . "State %-12s from %-12S %t")
                           (note        . "Note taken on %t")
                           (reschedule  . "Schedule changed on %t: %S -> %s")
                           (delschedule . "Not scheduled, was %S on %t")
                           (redeadline  . "Deadline changed on %t: %S -> %s")
                           (deldeadline . "Removed deadline, was %S on %t")
                           (refile      . "Refiled on %t")
                           (clock-out   . ""))
    )

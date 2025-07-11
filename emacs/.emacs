;; -*- mode: elisp -*-

;; ------------
;; my functions

;; clock in to work timer
(defun my/org-clock-in-work()
  "Clock in for Work"
  (interactive)
  (org-id-goto "E99899B2-1A3C-4B6E-9EEC-AD6B1017534D")
  (org-todo "BEGN")
  (org-clock-in))
;; clock out of work timer
(defun my/org-clock-out-work()
  "Clock out of Work"
  (interactive)
  (org-id-goto "E99899B2-1A3C-4B6E-9EEC-AD6B1017534D")
  (org-todo "DONE")
  (org-clock-out))
;; clock in to home work timer
(defun my/org-clock-in-work-home()
  "Clock in for Work"
  (interactive)
  (org-id-goto "7300A56D-4FBE-4438-95A5-4406F477050D")
  (org-todo "BEGN")
  (org-clock-in))
;; clock out of home work timer
(defun my/org-clock-out-work-home()
  "Clock out of Work"
  (interactive)
  (org-id-goto "7300A56D-4FBE-4438-95A5-4406F477050D")
  (org-todo "DONE")
  (org-clock-out))
;; clock in to break timer
(defun my/org-clock-in-break()
  "Clock in for Break"
  (interactive)
  (org-id-goto "08E0E792-F125-41EB-81B6-157EA6A32247")
  (org-todo "BEGN")
  (org-clock-in))
;; clock out of break timer
(defun my/org-clock-out-break()
  "Clock out of Break"
  (interactive)
  (org-id-goto "08E0E792-F125-41EB-81B6-157EA6A32247")
  (org-todo "DONE")
  (org-clock-out))


;; Define a custom keymap for the workday clocking
(defvar my/org-clock-keymap-work (let ((map (make-sparse-keymap)))
                              (define-key map (kbd "w i") 'my/org-clock-in-work)
                              (define-key map (kbd "w o") 'my/org-clock-out-work)
                              (define-key map (kbd "h i") 'my/org-clock-in-work-home)
                              (define-key map (kbd "h o") 'my/org-clock-out-work-home)
                              (define-key map (kbd "b i") 'my/org-clock-in-break)
                              (define-key map (kbd "b o") 'my/org-clock-out-break)
                              map)
  "Keymap for work clocks")

;; provide feedback when the keymap is activated
(defun my/show-org-clock-keymap-help-work ()
  "Show help for org clocking keymap."
  (interactive)
  (message "(w)ork ; (h)ome work ; (b) break ; clock (i)n / (o)ut"))

;; Show help when <f8> is pressed
(global-set-key (kbd "<f8>") (lambda ()
                               (interactive)
                               (my/show-org-clock-keymap-help-work)
                               (set-transient-map my/org-clock-keymap-work)))

(defun my/clocktable-formatter-group-by-prop (ipos tables params)
  "Custom formatter for clocktables to show work done for each category."
  (let ((total-time 0))
    (org-clocktable-write-default ipos tables params)
    (save-excursion
      (goto-char ipos)
      (while (re-search-forward "^[ \t]*|[^-]" nil t)
        (let ((time (org-clock-get-table-cell-value)))
          (setq total-time (+ total-time time)))))
    (insert (format "\n| Total | %s |\n"
                    (org-duration-from-minutes total-time)))))
;; ------------

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

;; org files location
(setq org-directory "~/org/")
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)
;; Enable transient mark mode
(transient-mark-mode 1)
;; Line numbers
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
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; move between windows/frames
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(require 'org-superstar)
;; Every non-TODO headline now have no bullet
; (setq org-superstar-headline-bullets-list '("　"))
; (setq org-superstar-leading-bullet ?　)
;; Enable custom bullets for TODO items
; (setq org-superstar-special-todo-items 'hide)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
;; allow letters in bullets and lists
(setq org-list-allow-alphabetical t)
;; set folding to give outline on start
(setq org-startup-folded 'content)


;;;;;;;;; packages ;;;;;;;;;;;;;;

;; Evil-mode
(require 'evil)
(evil-mode 1)
;; get evil to work in emacs -nw
(add-hook 'org-mode-hook
          (lambda ()
        (define-key evil-normal-state-map (kbd "TAB") 'org-cycle)))

;; theme
(load-theme 'leuven t)
; (setq modus-themes-italic-constructs t
;       modus-themes-bold-constructs nil)
; (load-theme 'modus-operandi t)

;; theming
(flyspell-mode 1)        ;; Catch Spelling mistakes
(blink-cursor-mode 0)    ;; Reduce visual noise

;; Easy Motion
(define-key evil-normal-state-map (kbd "SPC w") 'avy-goto-word-0)


;; yasnippets
;; org-mode compatibility
(defun yas/org-very-safe-expand ()
    (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
; (add-hook 'org-mode-hook
;     (lambda ()
;         (yas-minor-mode)
;         (make-variable-buffer-local 'yas/trigger-key)
;         (setq yas/trigger-key [tab])
;         (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
;         (define-key yas/keymap [tab] 'yas/next-field)))
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "C-c &") nil)

;; load changed files from disk
(global-auto-revert-mode t)

;; selectrum
(selectrum-mode +1)

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

;; F Shortcuts
;; Agenda views bound to function keys
(global-set-key (kbd "<f1>") '(lambda (&optional arg) (interactive "P")(org-agenda arg "a")))
(global-set-key (kbd "<f2>") '(lambda (&optional arg) (interactive "P")(org-agenda arg "A")))
(global-set-key (kbd "<f3>") '(lambda (&optional arg) (interactive "P")(org-agenda arg "N")))
; (global-set-key (kbd "<f4>") '(lambda (&optional arg) (interactive "P")(org-agenda arg "Q")))
(global-set-key (kbd "<f4>") 'my/copy-idlink-to-clipboard)
(global-set-key (kbd "<M-f4>") 'my/copy-idlink-filetags-to-clipboard)
;; roam shortcuts
(global-set-key (kbd "<f5>") '(lambda (&optional arg) (interactive "P")(org-roam-node-insert)))
(global-set-key (kbd "<f6>") '(lambda (&optional arg) (interactive "P")(org-roam-node-find)))
;; TODO: figure out what the code does and assign to another key
; (global-set-key (kbd "<f6>") '(lambda ()
;   (interactive)
;   (org-ql-search (org-agenda-files)
;     '(or (and (not (done))
;               (or (habit)
;                   (deadline auto)
;                   (scheduled :to today)
;                   (ts-active :on today)))
;          (closed :on today))
;     :sort '(date priority todo))))
(global-set-key (kbd "<f7>") 'org-roam-buffer-toggle)
(global-set-key (kbd "<f9>") '(lambda ()
    "open the daily agenda file"
    (interactive)
    (org-switch-to-buffer-other-window "Daily Agenda")
    (find-file "~/org/org-daily.org")
    (my/jump-to-today)
    ))
;; clocking commands bound to function keys
(global-set-key (kbd "<f10>") '(lambda (&optional arg) (interactive "P")(org-clock-goto t)))
(global-set-key (kbd "<f11>") '(lambda (&optional arg) (interactive "P")(org-todo "BEGN")))
(global-set-key (kbd "<f12>") '(lambda (&optional arg) (interactive "P")(org-todo "HALT")))

;; navigate to today's date as a headline
;; based on https://emacs.stackexchange.com/a/50412
(defun my/jump-to-today ()
  (let ((point (point)))
    (catch 'found
      (goto-char (point-min))
      (while (outline-next-heading)
        (let* ((hl (org-element-at-point))
               (title (org-element-property :raw-value hl)))
          (when (string-prefix-p (format-time-string "%Y-%m-%d %A") title)
            (org-show-context)
            (setq point (point))
            (throw 'found t)))))
    (goto-char point)))

;; set org directory
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(create-lockfiles nil)
 '(custom-safe-themes
   '("fbf73690320aa26f8daffdd1210ef234ed1b0c59f3d001f342b9c0bbf49f531c" default))
 '(org-export-backends '(ascii html icalendar latex md odt org))
 '(org-modules
   '(org-docview org-gnus org-habit org-info org-w3m org-checklist))
 '(org-stuck-projects
   '("+LEVEL=1/-DONE"
     ("TODO" "NEXT" "NEXTACTION" "BEGN" "WAIT" "HALT" "MEET")
     nil ""))
 '(package-selected-packages
   '(org-contrib modus-themes simpleclip org-roam org-superstar selectrum gnu-elpa-keyring-update writeroom-mode undo-tree evil-avy evil-easymotion helm-org helm-org-rifle yasnippet org-ql org-super-agenda solarized-theme))
 '(writeroom-width 120))
(setq
    ;; hide stars in headlines
    org-hide-leading-stars t
    ;; indent
    org-startup-indented t
    )
;; undo tree
(global-undo-tree-mode)
(setq undo-tree-auto-save-history nil)
;; start agenda from current day
(setq org-agenda-start-on-weekday nil)
;; inline tasks
(require 'org-inlinetask)
;; disable deadline reminders when tasks are scheduled
(setq org-agenda-skip-deadline-prewarning-if-scheduled t)
;; block TODO parent tasks until children are done
(setq org-enforce-todo-dependencies t)
;; do not show deadlines and scheduled items in agenda if done
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
;; disable timestamp in headlines from appearing in agenda view
(setq org-agenda-search-headline-for-time nil)
;; inactive timestamp in agenda
(defun org-agenda-inactive ()
  (interactive)
  (let ((org-agenda-include-inactive-timestamps t))
    (org-agenda)))
;; TODO states
(setq org-todo-keywords
      '((sequence "TODO(t)" "MEET(m)" "BEGN(s!)" "HALT(p@/!)" "WAIT(w@/!)" "DELY(f@/!)" "|" "ABRT(c@/!)" "DONE(d!)" )
        ))
(setq org-todo-keyword-faces
      '(("TODO" . (:background "firebrick" :foreground "yellow" :weight bold)) ("BEGN" . (:background "skyblue" :foreground "navy" :weight bold)) ("DONE" . (:background "darkseagreen" :foreground "dark green" :weight light))
        ("HALT" . (:background "tomato" :foreground "brown" :weight bold)) ("WAIT" . (:background "navy" :foreground "skyblue" :weight semibold)) ("DELY" . (:background "plum" :foreground "orchid" :weight light))
        ("MEET" . (:background "gold" :foreground "chocolate" :weight light)) ("ABRT" . (:background "wheat" :foreground "darkolivegreen" :weight light))
        ))
;; store notes in reverse order
(setq org-reverse-note-order nil)
;; show effort for the day in agenda
(setq org-agenda-columns-add-appointments-to-effort-sum t)
;; agenda column view
(setq org-columns-default-format "%1PRIORITY(IMP) %TODO(Status) %6CATEGORY(CAT.) %40ITEM(Task) %6Effort(Effort){:}  %5CLOCKSUM(Clock) %5CLOCKSUM_T(Today) %TAGS")
;; tags column
(setq org-tags-column 40)
(setq org-agenda-tags-column 0)
;; show only today's clocked time in status bar
(setq org-clock-mode-line-total 'today)
(org-clock-persistence-insinuate)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; persist clock history across sessions
(setq org-clock-persist 'history)
;; Show lot of clocking history so it's easy to pick items off the `C-c I` list
(setq org-clock-history-length 23)
;; set drawer for logs
(setq org-log-into-drawer "LOGBOOK")
;; show repeated tasks in log mode
(setq org-agenda-log-mode-items '(closed clock state))
;; Set default effort estimates
(setq org-global-properties '(("EFFORT_ALL". "0:05 0:15 0:30 1:00 1:30 2:00 3:00 4:00 5:00 6:00 8:00 12:00")))
;; show habits in agenda
; (setq org-habit-show-all-today t
;       org-habit-show-all-today t)
;; org structured templates
(define-key org-mode-map (kbd "C-<f1>") 'org-insert-structure-template)
;; org-rifle
(define-key org-mode-map (kbd "C-c C-h") 'helm-org-agenda-files-headings)
(define-key org-mode-map (kbd "C-c M-h") 'helm-org-rifle-agenda-files)
(setq helm-org-ignore-autosaves t)
;; prevent editing collapsed trees
(setq org-catch-invisible-edits 'show-and-error)
;; show only headlines in subtree
;; org-kill-note-or-show-branches C-c C-k
;; do not show empty lines between sections
(setq org-cycle-separator-lines 0)
;; sequence for list bullets
(setq org-list-demote-modify-bullet '(
    ("-" . "*") ("+" . "-") ("*" . "+")("1." . "a)")("a)" . "1)")("1)" . "a.") ))
;; refiling
(setq org-refile-targets '((nil :maxlevel . 5)
                                (org-agenda-files :maxlevel . 5)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling
;; hide formatting markers symbols
(setq org-hide-emphasis-markers t)


;; Thunderlink. Open an email in Thunderbird with ThunderLink.
(defun org-cbthunderlink-open (path)
  (if (eq system-type 'darwin)
      (simpleclip-set-contents (concat "cbthunderlink:" path)))
  (if (eq system-type 'gnu/linux)
              (start-process "cbthunderlink" nil "~/apps/cb_thunderlink/cb_thunderlink" (concat "cbthunderlink:" path)))
  )
(org-link-set-parameters
    "cbthunderlink"
    :follow 'org-cbthunderlink-open
    :face '(:foreground "darkmagenta" :underline t))
(org-link-set-parameters
    "zotero"
    :follow (lambda (zpath)
                (browse-url
                    ;; we get the "zotero:"-less url, so we put it back.
                    (format "zotero:%s" zpath))))


;; default list of tags for task annotation
(setq org-tag-alist '(
    (:startgroup) ("__NOW" . ?1) ("__NEXT" . ?2) ("__SOON" . ?3) ("__SOMEDAY" . ?4) ("__URGENT" . ?0) (:endgroup)
    ("_repeat" . ?r) ("_focus" . ?f) ("_review" . ?v) ("_plan" . ?p) ("_creative-thinking" . ?c) ("_analyse" . ?z) ("_quick" . ?q)
    ("#meeting" . ?m) ("#email" . ?e) ("#online" . ?o) ("#paper" . ?a) ("#idea" . ?i) ("#admin" . ?a)
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
    ("D" "Super Agenda - Grouped" ((agenda "" ((org-agenda-span 'day)
     (org-super-agenda-groups
       '((:auto-category t)))))))
    ("A" "Super Agenda - Daily" ((agenda "" ((org-agenda-span 'day)
     (org-super-agenda-groups
       '(
         (:name "Logbook"
        :order 0
                :log t)
         (:name "Ongoing"
                ; :time-grid t  ; Items that appear on the time grid
        :order 1
                :todo "BEGN")
         (:name "Meetings"
        :order 2
                ; :time-grid t  ; Items that appear on the time grid
                :todo "MEET")
         (:name "Important"
        :order 3
        :deadline past
        :deadline today
        :priority "A")
     (:name "DPVCG"
        :order 4
        :category "DPVCG")
         (:name "Quick-Tasks"
        :order 4
        :and (:scheduled t :tag "_quick"))
         (:name "Waiting"
        :order 5
        :and (:scheduled t :todo "WAIT"))
         (:name "Unimportant"
        :order 8
                :priority "C")
         (:name "Scheduled for Today"
        :order 6
                :scheduled today)
         (:name "Overdue"
        :order 7
                :scheduled past)
         (:name "Upcoming"
        :order 10
                :deadline future)
         )
       )))))
    ("Vc" "Super Agenda - Category" ((agenda "" ((org-agenda-span 'day)
        (org-super-agenda-groups
          '((:auto-category t))
          )))))
    ("Vt" "Super Agenda - Tag" ((agenda "" ((org-agenda-span 'day)
        (org-super-agenda-groups
          '((:auto-tags t))
          )))))
    ("Vd" "Super Agenda - Todo State" ((agenda "" ((org-agenda-span 'day)
        (org-super-agenda-groups
          '((:auto-todo t))
          )))))
    ("Vs" "Super Agenda - Timestamp" ((agenda "" ((org-agenda-span 'day)
        (org-super-agenda-groups
          '((:auto-ts t))
          )))))
    ("N" "Tasks tagged" tags-todo "+__NOW")
    ("Q" "Tasks tagged" tags-todo "+_quick")
    ("X" "Tasks tagged" tags-todo "+__NEXT")
    ))

;;; Super Agenda
; (org-agenda nil "a")
(org-super-agenda-mode)

(cond
 ((string-equal system-type "darwin") ;  macOS
  (progn
    (message "Mac OS X")))
 ((string-equal system-type "gnu/linux")
))

;;;;;;;;;;;;;;;;; HOOKS ;;;;;;;;;;;;;;;;;;;;;;

;; Function to enable column mode in org-agenda
(defun my/org-agenda-column-view ()
  "Enable column view in org-agenda."
  (org-agenda-columns))

;; Add the function to org-agenda-finalize-hook
; (add-hook 'org-agenda-finalize-hook 'my/org-agenda-column-view)

;; global clock ID
(defvar my/global-clock-id "a6127eab-8729-47bf-91e7-be873ed6ba83")
(defun my/global-clock-in ()
  (interactive)
  (org-with-point-at (org-id-find my/global-clock-id 'marker)
                     (org-clock-in)))
(defun my/global-clock-out ()
  (outteractive)
  (org-with-point-at (org-id-find my/global-clock-id 'marker)
                     (org-clock-out)))

;; todo state change
(setq org-clock-in-resume t)
(setq org-clock-in-switch-to-state "BEGN")
(setq org-clock-into-drawer t)
(setq org-clock-out-when-done t)
(setq org-pretty-entities t)
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))

(add-hook 'org-trigger-hook
    (lambda (arg)
        ;; ANY -> BEGN: start clock and timer
        (when (string= (plist-get arg :to) 'BEGN)
            (save-excursion
                (org-timer-start)
                (org-clock-in)
                ))
        ;; ANY --> END-STATE: stop clock and timer
        (when (or
                (or
                    (string= (plist-get arg :to) 'HALT)
                    (string= (plist-get arg :to) 'WAIT))
                  (string= (plist-get arg :to) 'DONE))
            (save-excursion
                (org-clock-out)
                (org-timer-stop)
                ))
        ;; if state is NIL, do not assign todo state, just clock in
        ;; if state is NIL, do not assign todo state, just clock out
        ;; Q: how to determine state is NIL???
  ))

;; agenda visual customisation
(setq org-agenda-breadcrumbs-separator " ❱ ")

;;;;;;;;;; capture templates ;;;;;;;;;;
(setq org-default-notes-file "~/org/org-temp.org")
; (define-key global-map (kbd "C-c x") 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/org-temp.org" "Captured Tasks")
         "* TODO %?\n %U %i\n %f %a")
        ("n" "Note" entry (file+datetree "~/org/org-temp.org" "Notes")
         "* %?\n %U %i\n %f %a")
        ("D" "Daily Plan" plain (file+olp+datetree "~/org/org-daily.org") (file "~/org/snippets/template_daily.txt") :immediate-finish t)
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

;;;
(defun my/copy-idlink-to-clipboard() "Copy an ID link with the
  headline to killring, if no ID is there then create a new unique
  ID.  This function works only in org-mode or org-agenda buffers.

  The purpose of this function is to easily construct id:-links to
  org-mode items. If its assigned to a key it saves you marking the
  text and copying to the killring."
  (interactive)
  (when (eq major-mode 'org-agenda-mode) ;switch to orgmode
    (org-agenda-show)
    (org-agenda-goto))
  (when (eq major-mode 'org-mode) ; do this only in org-mode buffers
    (setq mytmphead (nth 4 (org-heading-components)))
    (setq mytmpid (funcall 'org-id-get-create))
    (setq mytmplink (format "[[id:%s][%s]]" mytmpid mytmphead))
    (kill-new mytmplink)
    (message "Copied %s to killring (clipboard)" mytmplink)))

(defun my/copy-idlink-filetags-to-clipboard()
  "Copy an ID link with the headline and filetags to killring.
  If no ID is present, a new unique ID is created.
  Works only in org-mode or org-agenda buffers.

  The purpose of this function is to easily construct id:-links to
  org-mode items with filetags. If assigned to a key, it saves you marking the
  text and copying to the killring."
  (interactive)
  (when (eq major-mode 'org-agenda-mode) ; Switch to Org mode if in Agenda
    (org-agenda-show)
    (org-agenda-goto))
  (when (eq major-mode 'org-mode)  ; Only proceed in org-mode buffers
    (setq mytmphead (nth 4 (org-heading-components)))
    (setq mytmpid (funcall 'org-id-get-create))
    (setq mytmptags (org-entry-get (point) "ALLTAGS"))
    (setq mytmplink (format "[[id:%s][%s (%s)]]" mytmpid mytmphead mytmptags))
    (kill-new mytmplink)
    (message "Copied %s to killring (clipboard)" mytmplink)))



;; zotero citations zotxt
;; Activate org-zotxt-mode in org-mode buffers
; (add-hook 'org-mode-hook (lambda () (org-zotxt-mode 1)))
;; Bind something to replace the awkward C-u C-c " i
; (define-key org-mode-map
;   (kbd "C-c \" \"") (lambda () (interactive)
;                       (org-zotxt-insert-reference-link '(4))))
;; Change citation format to be less cumbersome in files.
;; You'll need to install mkbehr-short into your style manager first.
; (eval-after-load "zotxt"
; '(setq zotxt-default-bibliography-style "mkbehr-short"))

;; org-roam setup
(setq org-roam-v2-ack t)
(setq org-roam-directory "~/org")
(require 'org-roam)
(org-roam-db-autosync-mode)
;; roam templates
(setq org-roam-capture-templates
   '(("d" "default" plain "%?" :target
      (file+head "${slug}.org" "#+title: ${title}
                 ")
      :unnarrowed t)))
(setq org-roam-mode-sections
    (list #'org-roam-backlinks-section
        #'org-roam-reflinks-section
        ;; #'org-roam-unlinked-references-section
    ))

;; projects for exporting
(require 'ox-publish)
(setq org-export-with-broken-links t)
(setq org-publish-project-alist '(
    ("public-org"
     :base-directory "~/org/public"
     :base-extension "org"
     :exclude ".*~"
     :recursive t
     :publishing-directory "~/code/hp-org/"
     :publishing-function org-html-publish-to-html
     :auto-sitemap t
     :sitemap-title "Public Notes"
     :sitemap-filename "index.org"
     :sitemap-file-entry-format "%t - %d"
     :sitemap-style tree
     :author "Harshvardhan J. Pandit"
     :with-creator t
     )
    ("dpv"
     :base-directory "~/org"
     :base-extension "org"
     :exclude "^(dpv.*.org)"
     :recursive t
     :publishing-directory "~/code/hp-org/dpv/"
     :publishing-function org-html-publish-to-html
     :auto-sitemap t
     :sitemap-title "DPV Notes"
     :sitemap-filename "index.org"
     :sitemap-file-entry-format "%t - %d"
     :sitemap-style tree
     :author "Harshvardhan J. Pandit"
     :with-creator t
     )
)) ;; end project-alist

;; code blocks
(setq org-confirm-babel-evaluate nil)
;; graphviz / dot
(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t))) ; this line activates dot
(defun my/fix-inline-images ()
  (when org-inline-image-overlays
    (org-redisplay-inline-images)))
(add-hook 'org-babel-after-execute-hook 'my/fix-inline-images)

;; calculate due dates and pending days to deadline
(defun my/calculate-available-days ()
  "Calculate the number of days left from today for the DUE_DATE property
   in the current Org node and its children, and store the result in the DAYS_LEFT property."
  (interactive)
  (org-map-entries
   (lambda ()
     (let* ((due-date (org-entry-get (point) "DUE_DATE"))
            (days-left (when due-date
                         (let* ((due-time (org-time-string-to-time due-date))
                                (today-time (current-time))
                                (diff-days (/ (float-time (time-subtract due-time today-time)) 86400.0)))
                           (1+ (floor diff-days))))))
       (when days-left
         (org-entry-put (point) "DAYS_LEFT" (number-to-string days-left)))))
   nil 'tree))

(defun my/update-link-state ()
  "Update the description of an Org mode link to reflect the title and state of the linked node.
  Assumes the link is of the format [[id:<ID>][description]], and updates only the description
  to '<title> (<state>)' without modifying the node title."
  (interactive)
  (when (org-in-regexp org-link-bracket-re 1)
    (let* ((link (match-string 1))  ;; Extract link part ([[id:<ID>][description]])
           (desc-start (match-beginning 2)) ;; Start position of the description
           (desc-end (match-end 2))   ;; End position of the description
           (id (when (string-match "^id:\\(.+\\)" link) (match-string 1 link))) ;; Extract the ID
           (marker (and id (org-id-find id 'marker))) ;; Find the node by ID
           (title nil)
           (state nil))
      (when marker
        (with-current-buffer (marker-buffer marker)
                             (save-excursion
                               (goto-char marker)
                               (setq title (org-get-heading t t t t))  ;; Get the heading text
                               (setq state (or (org-get-todo-state) "")) ;; Get the TODO state
                               (setq scheduled (org-entry-get nil "SCHEDULED")))))  ;; Get the SCHEDULED date
      (when (and title id desc-start desc-end)
        ;; Replace only the description part of the link
        (goto-char desc-start)
        (delete-region desc-start desc-end)
        (insert (format "%s (%s%s)"
                        title
                        state
                        (if (and (string= state "WAIT") scheduled)
                          (format " - %s" (org-format-time-string "%Y-%m-%d" (org-time-string-to-time scheduled)))
                          "")))))))


;; reassert in case something above changes this
(setq org-directory "~/org/")
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))

;; show agenda at startup
(add-hook 'after-init-hook 'org-agenda-list)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

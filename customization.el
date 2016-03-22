;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Settings we want to do after we load JMAX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; use our own org-mode
;; load local org-mode
(add-to-list 'load-path (expand-file-name "org-mode/lisp" zx-emacs-dir))
(add-to-list 'load-path (expand-file-name "org-mode/contrib/lisp" zx-emacs-dir))

(set-keyboard-coding-system nil)

(when (string= system-name "gilgamesh.cheme.cmu.edu")
  (setq-default ispell-program-name "aspell"
		ispell-personal-dictionary (concat zx-emacs-dir "user/.ispell")))

(when (or (string= system-name "ZURFACE-PC")
	  (string= system-name "ZX-HOME-PC"))
  ;;(add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
  (setq-default ispell-program-name "C:/Program Files (x86)/Aspell/bin/aspell.exe"
		ispell-personal-dictionary (concat zx-emacs-dir "user/.ispell")))

(add-to-list 'load-path zx-user-dir)
(when (file-exists-p zx-user-dir)
  (mapc 'load (directory-files zx-user-dir 't "^[^#].*el$")))

;; Make images the same size
(setq org-image-actual-width nil)

;; Deactivate pycheck, because I don't need it
(setq jmax-run-pycheck nil)
(ad-deactivate 'org-babel-execute:python)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Automatic Capitalization for references
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar jmax-lower-case-words
  '("a" "an" "on" "and" "for"
    "the" "of" "in")
  "List of words to keep lowercase")

(defun jmax-title-case-article (&optional key start end)
  "Convert a bibtex entry article title to title-case. The
arguments are optional, and are only there so you can use this
function with `bibtex-map-entries' to change all the title
entries in articles."
  (interactive)
  (bibtex-beginning-of-entry)

  (let* ((title (bibtex-autokey-get-field "title"))
         (words (split-string title))
         (lower-case-words '("a" "an" "on" "and" "for"
                             "the" "of" "in")))
    (when
        (string= "article" (downcase (cdr (assoc "=type=" (bibtex-parse-entry)))))
      (setq words (mapcar
                   (lambda (word)
                     (if (or
                          ;; match words containing {} or \ which are probably
                          ;; LaTeX or protected words
                          (string-match "\\$\\|{\\|}\\|\\\\" word)
                          ;; these words should not be capitalized, unless they
                          ;; are the first word
                          (-contains? lower-case-words (s-downcase word)))
                         word
                       (s-capitalize word)))
                   words))

      ;; Check if first word should be capitalized
      (when (-contains? jmax-lower-case-words (car words))
        (setf (car words) (s-capitalize (car words))))
            
      ;; this is defined in doi-utils
      (bibtex-set-field
       "title"
       (mapconcat 'identity words " "))
      (bibtex-fill-entry))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Personal Preferences
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set the username and email
(setq user-full-name "Zhongnan Xu")
(setq user-mail-address "zhongnanxu@cmu.edu")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Basic Preferences
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; load the solarized color theme
;; (add-to-list 'custom-theme-load-path (expand-file-name "emacs-color-theme-solarized" zx-emacs-dir))
;; (load-theme 'solarized-light t)

;; ;; make code blocks stand out a little from my gray80 background
;; (if (display-graphic-p)
;;   (set-face-attribute 'org-block-background nil :background "lemon chiffon")
;;   (set-face-attribute 'org-block-background nil :background nil))

(setq frame-title-format "%b - Emacs") ;; Set the title to the current buffer
(tool-bar-mode 0) ;; remove the icons)
(menu-bar-mode 1) ;; keep the menus
(global-visual-line-mode 1) ;; how long lines are handled.
                            ;; This appears to wrap long lines

(global-font-lock-mode t)   ;; turn on font-lock mode everywhere

(show-paren-mode 1)         ;; highlight parentheses
(setq show-paren-style 'parenthesis) ;; alternative is 'parenthesis

(line-number-mode 1)  ;; turn linumbers on in mode-line
;(global-linum-mode t) ;; put line numbers on left side of the screen

(setq column-number-mode t) ;; Display what column you are on

(setq backup-inhibited t)  ;; disable backup file creation

(setq inhibit-startup-screen t) ;; stop showing startup screen

(fset 'yes-or-no-p 'y-or-n-p) ; answer with y/n instead of yes/no

(global-set-key [f9] (lambda () (interactive) (save-buffer) (load-file (concat zx-emacs-dir "/init.el"))))

(setq org-image-actual-width '(600))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Org-mode preferences
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialize my notebook
(load-file "~/research/init.el")
(org-babel-load-file "~/research/notebook.org")

;; recursively find .org files in provided directory
;; modified from an Emacs Lisp Intro example. Taken from https://github.com/suvayu/.emacs.d.git
(defun sa-find-org-file-recursively (directory &optional filext)
  "Return .org and .org_archive files recursively from DIRECTORY.
If FILEXT is provided, return files with extension FILEXT instead."
  ;; FIXME: interactively prompting for directory and file extension
  (let* (org-file-list
	 (case-fold-search t)		; filesystems are case sensitive
	 (file-name-regex "^[^.#].*")	; exclude .*
	 (filext (if filext filext "org$\\\|org_archive"))
	 (fileregex (format "%s\\.\\(%s$\\)" file-name-regex filext))
	 (cur-dir-list (directory-files directory t file-name-regex)))
    ;; loop over directory listing
    (dolist (file-or-dir cur-dir-list org-file-list) ; returns org-file-list
      (cond
       ((file-regular-p file-or-dir) ; regular files
	(if (string-match fileregex file-or-dir) ; org files
	    (add-to-list 'org-file-list file-or-dir)))
       ((file-directory-p file-or-dir)
	(dolist (org-file (sa-find-org-file-recursively file-or-dir filext)
			  org-file-list) ; add files found to result
	  (add-to-list 'org-file-list org-file)))))))

(provide 'customization)

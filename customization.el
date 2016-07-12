;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Settings we want to do after we load SCIMAX                    ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-keyboard-coding-system nil)

(when (string= system-name "gilgamesh.cheme.cmu.edu")
  (setq-default ispell-program-name "aspell"
		ispell-personal-dictionary (concat zx-emacs-dir "user/.ispell")))

(add-to-list 'load-path zx-user-dir)
(when (file-exists-p zx-user-dir)
  (mapc 'load (directory-files zx-user-dir 't "^[^#].*el$")))

;; Make images the same size
(setq org-image-actual-width nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Personal Preferences                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set the username and email
(setq user-full-name "Zhongnan Xu")
(setq user-mail-address "zhongnan.xu@gmail.com")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Basic Preferences                                              ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;; Initialize my notebook
(load-file "~/research/init.el")
(org-babel-load-file "~/research/notebook.org")

;; Don't insert tabs (Jason told me to add this)
(setq-default indent-tabs-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Custom emacs functions (that I usually do not use)             ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

(global-set-key (kbd "C-c D")  'delete-file-and-buffer)

(provide 'customization)

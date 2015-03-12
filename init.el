;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

;; remember this directory
(defconst zx-emacs-dir (file-name-directory (or load-file-name (buffer-file-name)))
    "directory where the starterkit is installed")

(defvar zx-user-dir (expand-file-name "user/" zx-emacs-dir)
  "user directory for personal code")

(add-to-list 'load-path zx-emacs-dir)
(add-to-list 'load-path zx-user-dir)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Load JMAX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This code loads up the part of jmax that I want -- mainly things to
;; help with org-mode options
(defvar starter-kit-dir (expand-file-name "jmax" zx-emacs-dir)
  "jmax directory that contains elisp files that I might want to use")

(defvar user-dir (expand-file-name "user" zx-emacs-dir)
  "user directory for personal code")

(add-to-list 'load-path starter-kit-dir)
(add-to-list 'load-path user-dir)

;; (load-file (expand-file-name "jorg-bib.el" jmax-dir))
;; (load-file (expand-file-name "jmax.el" starter-kit-dir))
(require 'init)

;; These are customizations that we can add to jmax
(setq reftex-default-bibliography '("~/Dropbox/bibliography/references.bib"))

;; see org-ref.el for use of these variables
(setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
      org-ref-default-bibliography '("~/Dropbox/bibliography/library.bib")
      org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Load my own code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'customization)
(require 'zx-agenda)
;;; end init

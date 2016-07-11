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

;; set i(a)spell options on different machines
(setq ispell-personal-dictionary (concat zx-user-dir ".ispell"))

(add-to-list 'load-path zx-emacs-dir)
(add-to-list 'load-path zx-user-dir)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Load SCIMAX or JMAX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This code loads up the part of jmax that I want -- mainly things to
;; help with org-mode options
;; (defvar starter-kit-dir (expand-file-name "jmax" zx-emacs-dir)
;;   "jmax directory that contains elisp files that I might want to use")

(defvar starter-kit-dir (expand-file-name "scimax" zx-emacs-dir)
  "scimax directory that contains elisp files that I might want to use")

(defvar user-dir (expand-file-name "user" zx-emacs-dir)
  "user directory for personal code")

(add-to-list 'load-path starter-kit-dir)
(add-to-list 'load-path user-dir)

(require 'init)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Load my own code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'customization)
;; end init

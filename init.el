;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

;; remember this directory
(defconst zx-emacs-dir (file-name-directory (or load-file-name (buffer-file-name)))
    "directory where the starterkit is installed")

(defvar zx-user-dir (expand-file-name "user" zx-emacs-dir)
  "user directory for personal code")

(add-to-list 'load-path zx-emacs-dir)
(add-to-list 'load-path zx-user-dir)

(require 'packages)
(require 'customization)
(require 'zx-agenda)
;;; end init

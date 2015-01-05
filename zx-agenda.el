(defvar rdir (concat zx-emacs-dir "../research/"))

;; Add misc agenda files to the agenda
(defvar misc-agenda (list (concat zx-user-dir "general.org")
			  (concat zx-user-dir "papers.org")
			  (concat zx-user-dir "exxon-mobil.org")
			  (concat zx-user-dir "notebook.org")
			  ))

;; ;; Add active projects to the agenda
;; (defvar act-proj (list (concat rdir "rutile-OER/rutile-OER.org")
;; 		       (concat rdir "spinels-dftuv/spinels-dftuv.org")
;; 		       (concat rdir "nickel-hydroxides/nickel-hydroxides.org")
;; 		       (concat rdir "DFT+U-V/archive/DFT+U-V-gbrv/DFT+U-V-gbrv.org")
;; 		       (concat rdir "O2-U/O2-U.org")
;; 		       (concat rdir "espresso-dos-tests/espresso-dos-tests.org")
;; 		       (concat rdir "doped-rutiles/doped-rutiles.org")
;; 		       ))

;; Add active projects to the agenda

(defvar act-proj (append ; (sa-find-org-file-recursively (concat rdir "spinels-dftuv"))
			 ; (sa-find-org-file-recursively (concat rdir "nickel-hydroxides"))
			 (sa-find-org-file-recursively (concat rdir "DFT+U-V-bulk"))
			 (sa-find-org-file-recursively (concat rdir "NiO-adsorption"))
			 (sa-find-org-file-recursively (concat rdir "oxide-polymorphs-OER"))
			 ))

;; (setq org-agenda-files (list (concat rdir "zhongnax/zhongnax.org")
;; 			     (concat rdir "rutile-OER/rutile-OER.org")))

;; (setq org-agenda-files
;;       (append (sa-find-org-file-recursively rdir)))

(if (string= system-name "gilgamesh.cheme.cmu.edu")
    (setq org-agenda-files (append misc-agenda act-proj))
  (setq org-agenda-files (append misc-agenda)))

(provide 'zx-agenda)

(defvar rdir (concat zx-emacs-dir "../research/"))

;; Add misc agenda files to the agenda
(defvar misc-agenda (list (concat zx-user-dir "general.org")
			  (concat zx-user-dir "papers.org")
			  (concat zx-user-dir "notebook.org")
			  (concat zx-user-dir "lit-review.org")
			  ))

;; Add active projects to the agenda
(defvar act-proj (list (concat rdir "ABO3-TiO2-interface/BaTiO3-TiO2-interface.org")
		       (concat rdir "PtMo-nanoparticles/PtMo-nanoparticles.org")
		       ))

;; (setq org-agenda-files (list (concat rdir "zhongnax/zhongnax.org")
;; 			     (concat rdir "rutile-OER/rutile-OER.org")))

;; (setq org-agenda-files
;;       (append (sa-find-org-file-recursively rdir)))

;; (if (string= system-name "gilgamesh.cheme.cmu.edu")
;;    (setq org-agenda-files (append misc-agenda act-proj))
;;  (setq org-agenda-files (append misc-agenda)))

(setq org-agenda-files (append misc-agenda act-proj))

(provide 'zx-agenda)

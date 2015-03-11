(defvar rdir (concat zx-emacs-dir "../research/"))

;; Add misc agenda files to the agenda
(defvar misc-agenda (list (concat zx-user-dir "general.org")
			  (concat zx-user-dir "papers.org")
			  (concat zx-user-dir "exxon-mobil.org")
			  (concat zx-user-dir "notebook.org")
			  ))

;; Add active projects to the agenda
(defvar act-proj (list (concat rdir "oxide-polymorphs-OER/oxide-polymorphs-OER.org")
		       (concat rdir "NiO-adsorption/NiO-adsorption.org")
		       (concat rdir "exxon-surfaces/exxon-surfaces.org")
		       (concat rdir "oxide-interfaces/oxide-interfaces.org")
		       (concat rdir "BaTiO3-TiO2-interface/BaTiO3-TiO2-interface.org")
		       ))

;; (setq org-agenda-files (list (concat rdir "zhongnax/zhongnax.org")
;; 			     (concat rdir "rutile-OER/rutile-OER.org")))

;; (setq org-agenda-files
;;       (append (sa-find-org-file-recursively rdir)))

(if (string= system-name "gilgamesh.cheme.cmu.edu")
    (setq org-agenda-files (append misc-agenda act-proj))
  (setq org-agenda-files (append misc-agenda)))

(provide 'zx-agenda)

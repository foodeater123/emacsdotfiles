(setq lexical-binding t)

(require 'all-the-icons)
(defun custom-modeline-time ()
  (let* ((hour (string-to-number (format-time-string "%I")))
         (icon (all-the-icons-wicon (format "time-%s" hour) :height 1.3 :v-adjust 0.0)))
    (concat
     (propertize (format " %s " icon) 'face `(:height 1.0 :family ,(all-the-icons-wicon-family) :background "#00384d" :foreground "darkcyan" ) 'display '(raise -0.0)))))




(defvar cogent-line-selected-window (frame-selected-window))
(defun cogent-line-set-selected-window (&rest _args)
  (when (not (minibuffer-window-active-p (frame-selected-window)))
    (setq cogent-line-selected-window (frame-selected-window))
    (force-mode-line-update)))
(defun cogent-line-unset-selected-window ()
  (setq cogent-line-selected-window nil)
  (force-mode-line-update))
(add-hook 'window-configuration-change-hook #'cogent-line-set-selected-window)
(add-hook 'focus-in-hook #'cogent-line-set-selected-window)
(add-hook 'focus-out-hook #'cogent-line-unset-selected-window)
(advice-add 'handle-switch-frame :after #'cogent-line-set-selected-window)
(advice-add 'select-window :after #'cogent-line-set-selected-window)
(defun cogent-line-selected-window-active-p ()
  (eq cogent-line-selected-window (selected-window)))



;;(x-display-pixel-width)


(setq  width-mess nil)

(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT
 aligned respectively."

  (let* ((available-width (- (window-width) (length left) -7)))

    (format (format "%%s%%%ds" available-width) left right)))



(setq-default mode-line-format
      '((:eval (simple-mode-line-render
                ;; left
               (format-mode-line (list


	          '(:eval  (if (cogent-line-selected-window-active-p)
			  (propertize " " 'face '(:background "#6ae4b9") )
			  (propertize "" )))


	     '(:eval  (if (cogent-line-selected-window-active-p)
			  (propertize " ♜     " 'face '(:foreground "#6ae4b9" :background "#000000") )
			(propertize " ♟     " 'face '(:foreground "#00bcff" :background "#000000"))))

	     '(:eval (when-let (vc vc-mode)
                         (list " "
                               (propertize (substring vc 5)
                                           'face '(:foreground "#00bcff" :background "#000000"))
                               " ")))

	   '(:eval (list
                        ;; the buffer name; the file name as a tool tip
                        (propertize " %b      " 'face '(:weight medium :foreground "#f78fe7" :background "#000000")
                                    'help-echo (buffer-file-name))
                        (when (buffer-modified-p)
                          (propertize
                           " ✎ "
                           'face (if (cogent-line-selected-window-active-p)
                                     '(:foreground "cyan" :background "#000000")
                                   '(:foreground "darkcyan" :background "#000000"))))
                        (when buffer-read-only
                          (propertize
                           "  "
                           'face (if (cogent-line-selected-window-active-p)
                                     '(:foreground "cyan" :background "#000000")
                                   '(:foreground "darkcyan" :background "#000000")))
)





	   (propertize  "                 %p             " 'face '(:background "#392a48" :foreground "#6ae4b9"))



		    '(:eval(list(custom-modeline-time)))




				   ))))
                ;; right
           (format-mode-line (list




	   (propertize  "     %l:%c     " 'face '(:background "#00384d" :foreground "darkcyan" :slant italic))
	   ;; (propertize (format "     %s     " (if (stringp mode-name)
	   ;; 					  (if (string= mode-name "Dired by name") "browse" mode-name) " " )  )
	   ;; 	       'face '(:background "#392a48" :foreground "#6ae4b9"))
	   (propertize  "     %m        "	      'face '(:background "#392a48" :foreground "#6ae4b9")
)

))
)
)
)
)

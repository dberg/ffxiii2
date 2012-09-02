;; Public interface
(defun ff13-search (clock)
  (setq ff13-path nil)
  (let* ((clock-count (length clock))
	 (adj-lst (ff13-build-adjacency-list clock clock-count))
	 (visited (make-vector clock-count nil)))
    (catch 'exit
      (mapc (lambda (vertice)
	      (if (ff13-searchr vertice (1- clock-count) adj-lst visited)
		  (throw 'exit t)))
	    (number-sequence 0 (1- clock-count))))
    (reverse ff13-path)))

;; Helper functions
(setq ff13-path nil)

(defun ff13-searchr (v d adj-list visited)
  (aset visited v t)
  (setq ff13-path (cons v ff13-path))
  (if (= d 0) (throw 'exit t))
  (catch 'return
    (mapc (lambda (w)
	    (if (not (elt visited w))
		(if (ff13-searchr w (1- d) adj-lst visited)
		    (throw 'return t))))
	  (aref adj-lst v))
    (aset visited v nil)
    (setq ff13-path (cdr ff13-path))
    nil))

(defun ff13-build-adjacency-list (clock clock-count)
  (let ((adj-lst (make-vector clock-count nil)))
    (mapc (lambda (pair)
	    (let ((vertex (car pair))
		  (clock-number (cdr pair)))
	      (aset adj-lst
		    vertex
		    (ff13-transform-clock-number-into-vertices
		     vertex clock-number clock-count))))
	  clock)
  adj-lst))

(defun ff13-transform-clock-number-into-vertices (vertex clock-number clock-count)
  (let (link1 link2)
    (setq link1 (% (+ vertex clock-number) clock-count))
    (setq link2 (- vertex clock-number))
    (if (< link2 0)
	(setq link2 (+ clock-count link2)))
    (if (= link1 link2)
	(list link1)
      (list link1 link2))))

;; -----------------------------------------------------------------------------
;; Scratch pad
;; -----------------------------------------------------------------------------
(setq ff13-clock '((0 . 4)
		   (1 . 4)
		   (2 . 4)
		   (3 . 2)
		   (4 . 1)
		   (5 . 4)
		   (6 . 1)
		   (7 . 1)
		   (8 . 1)
		   (9 . 3)))

(ff13-search ff13-clock)

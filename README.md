;; -----------------------------------------------------------------------------
;; Final Fantasy XIII-2 Clock puzzle
;; -----------------------------------------------------------------------------
;;
;; The clock puzzle in the game is a Hamiltonian path problem. The global
;; variable ff13-clock represents the clock and the function ff13-search will
;; return the first path found.
;;
;; ----------------------------------------------------------------------------
;; Representation of the clock puzzle
;; ----------------------------------------------------------------------------
;;
;; We represent the clock as an association list where keys indicate the
;; position in the clock and the values are numbers given by the game for each
;; vertice. The initial position of a key is arbitrary but we start counting
;; from zero.
;;
;; Below is an example of a clock with 4 vertices:
;;
;;     2
;;   1   2
;;     1
;;
;; If we decide that our initial vertex is at the top part of the clock and
;; that we'll follow a clockwise path we set the alist as follows:
;;
;; (setq ff13-clock '((0 . 2)(1 . 2)(2 . 1)(3 . 1)))
;;
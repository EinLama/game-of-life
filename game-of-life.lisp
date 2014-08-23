
(defparameter *width* 32)
(defparameter *height* 10)

; Remember alive cells in a hash-table.
; The key of a hash entry is a cons with x and y position.
; The value is truthy if a living cell resides at that position.
(defparameter *cells* (make-hash-table :test #'equal))

(defun spawn-random-cell ()
  (let ((pos (cons (random *width*) (random *height*))))
    (spawn-cell-at (car pos) (cdr pos))
    pos))

(defun spawn-cell-at (left top)
  (if (and (and (<= left *width*) (>= left 0))
           (and (<= top *height*) (>= top 0)))
    (setf (gethash (cons left top) *cells*) t)
    '(OUTSIDE OF WORLD)))

(defun cell-alive-at (left top)
  (if (and (and (<= left *width*) (>= left 0))
           (and (<= top *height*) (>= top 0)))
    (gethash (cons left top) *cells*)
    nil))


(defun print-world ()
     (loop for y below *height*
           do (progn (fresh-line)
                      (princ "|")
                      (loop for x below *width*
                            do (princ (cond ((cell-alive-at x y) "X")
                                            (t "."))))
                      (princ "|"))))

(defun cells-for-next-generation ()
  (let ((new-gen (make-hash-table :test #'equal)))
    (loop for y from 0 to *height*
          collect (loop for x from 0 to *width*
                            if (or (and (cell-alive-at x y)
                                        (or (= 2 (living-neighbours-for-cell-at x y))
                                            (= 3 (living-neighbours-for-cell-at x y))))
                                   (and (not (cell-alive-at x y))
                                        (= 3 (living-neighbours-for-cell-at x y))))
                            do (setf (gethash (cons x y) new-gen) t)
                        ))
    new-gen))

(defun living-neighbours-for-cell-at (left top)
  (let ((neighbours
          (list
            ; up and down
            (cell-alive-at left (1- top))
            (cell-alive-at left (1+ top))
            ; left and right
            (cell-alive-at (1- left) top)
            (cell-alive-at (1+ left) top)
            ; diagonal
            (cell-alive-at (1- left) (1- top))
            (cell-alive-at (1- left) (1+ top))
            (cell-alive-at (1+ left) (1+ top))
            (cell-alive-at (1+ left) (1- top))
            )
          ))
    (length (remove nil neighbours))))

(defun next-generation ()
  (setf *cells* (cells-for-next-generation))
  (print-world))


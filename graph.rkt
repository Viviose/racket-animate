#lang racket
;Required libraries allow for access to Racket animation library and test engine library.
(require picturing-programs)
(require test-engine/racket-tests)

;Provides access to all specified functions and variables in this file to other files.
(provide (except-out (all-defined-out) h k))

;between?: number(query) number(min) number(max) -> boolean
;Checks to see if a number is within a specified bound.
(define (between? query min max)
  (and (< query max)
       (> query min)
       )
  )

;distance: number(x1) number(y1) number(x2) number(y2) -> number(distance between coordinates)
;Takes in four numbers, which represent the x and y coordinates of two different coordinate pairs, and finds distance
;  between them. Works with circles.
(define (distance x1 y1 x2 y2)
  (sqrt (+ (sqr (- x2 x1))
           (sqr (- y2 y1))
           )
        )
  )

;degrees-asin: number(ratio) -> number(angle in degrees)
;Converts a result of asin into degrees.
(define (degrees-atan ratio)
  (radians->degrees (atan ratio))
  )

;slope: Number(x1) Number(y1) Number(x2) Number(y2) -> Number (slope)
;Determines the slope between two points.
(define (slope x1 y1 x2 y2)
  (/ (- y2 y1)
     (- x2 x1)
     )
  )

;calc-angle: number(x1) number(y1) number(x2) number(y2) -> number(angle in degrees)
;Determines the angle of the given line to the horizontal.
(define (calc-angle x1 y1 x2 y2)
  (real->int (atan
              (slope x1 y1 x2 y2))
             )
  )

;Private Helper Functions
;************************
(define (h x1 x2)
  (/ (+ x1 x2)
     2)
  )

(define (k y1 y2)
  (/ (+ y1 y2)
     2)
  )
;************************

;in-ellipse?: number(x1) number(y1) number(x2) number(y2) number(x3) number(y3) number(mouse-x) number(mouse-y) -> boolean
;Determines whether a given point is inside of a defined ellipse.
(define (in-ellipse?
          ;rightmost coord pair
          x1 y1 
          ;leftmost coord pair
          x2 y2 
          ;center top coord pair
          x3 y3 
          ;point to check
          x y) 
  (local [(define hvar (h x1 x2))
          (define kvar (k y1 y2))
          (define xmh (- x hvar))
          (define ymk (- y kvar))
          (define mainangle (calc-angle x1 y1 x2 y2))
          (define cosangle (cos mainangle))
          (define sinangle (sin mainangle))]
    (<= (+ ;First piece for x
          (/ (sqr (+ (* xmh cosangle)
                     (* ymk sinangle)))
             ;a
             (sqr (/ (distance x1 y1 x2 y2) 2)))
          ;Second piece for y
          (/ (sqr (- (* ymk cosangle)
                     (* xmh sinangle)))
             ;b
             (sqr (distance hvar kvar x3 y3)))) 
        ;1 is value of comparison of the point compared to the ellipse.
        ;;If the point is not within a distance less than or equal to 1 of the ellipse, the function will return false.
        1)))

;find-sup-inf: function(comparison operator) number(comparison value) [Listof Numbers] -> Number
;Returns the greatest/least value in a given list of numbers or the given value, whichever is greater/lesser.
(define (find-sup-inf operator value lon)
  (cond [(empty? lon) value]
        [(operator (first lon) value) (find-sup-inf operator (first lon) (rest lon))]
        [else (find-sup-inf operator value (rest lon))]
        )
  )

;remove-max-or-min: function(comparison operator) [Listof Numbers] -> [Listof Numbers]
;Returns the given list without the first instance of its greatest or least character included.
(define (remove-max-or-min operator lon)
  (cond [(empty? lon) '()]
        [(equal? (first lon)
                 (find-sup-inf operator 0 lon)
                 )
         (rest lon)]
        [else (cons (first lon)
                    (remove-max-or-min operator (rest lon))
                    )]
        )
  )

#lang racket
(require picturing-programs)
(require test-engine/racket-tests)
(require "../graph.rkt")

;Testing Suite for calc-angle
(check-expect (calc-angle 0 0 -7 0)
              0)
;End Testing Suite

;Testing Suite for remove-max-or-min
(check-expect (remove-max-or-min > (list 2 3 4))
              (list 2 3)
              )
(check-expect (remove-max-or-min > (list 6 2 1))
              (list 2 1)
              )
(check-expect (remove-max-or-min > (list 2 3 5 5))
              (list 2 3 5)
              )
;End Testing Suite

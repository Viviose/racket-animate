#lang racket
(require picturing-programs)
(require "graph.rkt")
(require "ellipse.rkt")


(check-expect (calc-angle 0 0 -7 0)
              0)

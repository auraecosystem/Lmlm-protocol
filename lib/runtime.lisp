(test "APLCE Mathematics v2"

  ("Arithmetic"
    (and (= (+ 10 20) 30)
         (= (- 8 5) 3)
         (= (* 7 9) 63)
         (= (/ 9 2) 4)))

  ("Indices"
    (and (= (pow 2 10) 1024)
         (= (sqrt 81) 9)
         (= (log10 1000) 3)))

  ("Probability"
    (= (probability 1 6) (/ 1 6)))

  ("Matrix Algebra"
    (= (matmul '((1 2)(3 4))
               '((5 6)(7 8)))
       '((19 22)(43 50))))

  ("Lambda"
    (= (((fn (a b c) (+ a b c)) 1) 2 3)
       6))

  ("Continuations"
    (= 99
       (call/cc
         (fn (exit)
           (exit 99)
           0)))))

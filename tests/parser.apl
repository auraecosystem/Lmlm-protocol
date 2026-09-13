(test "parser mathematics"

 ("dfa acceptance"
   (accepts? binary-dfa "10110"))

 ("cfg parsing"
   (parse arithmetic-cfg "1+2*3"))

 ("ast equality"
   (= (ast "(+ 1 (* 2 3))")
      (parse arithmetic-cfg "1+2*3"))))

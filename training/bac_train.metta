;; Define cast functions between Nat and Number
(: fromNumber (-> Number Atom))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))

;; Knowledge base
!(bind! &kb (new-space))
!(add-atom &kb (Evaluation croaks Fritz))
!(add-atom &kb (Evaluation chirps Tweety))
!(add-atom &kb (Inheritance Tweety yellow))
!(add-atom &kb (Evaluation eats_flies Tweety))
!(add-atom &kb (Evaluation eats_flies Fritz))
!(add-atom &kb (True))



;; Rule base
!(bind! &rb (new-space))
(=(croaks-eats_flies-frog-rule) 
    (-> (Evaluation croaks $x) 
          (Evaluation eats_flies $x) 
              (Inheritance $x frog)))

(=(chirps-sings-canary-rule) 
    (-> (Evaluation chirps $x) 
            (Evaluation sings $x) 
               (Inheritance $x canary)))

(=(frog-green-rule)
    (-> (True)
          (Inheritance $x frog) 
             (Inheritance $x green)))

(=(canary-yellow-rule) 
    (-> (True)
          (Inheritance $x canary)
            (Inheritance $x yellow)))

!(add-reduct &rb (croaks-eats_flies-frog-rule))
!(add-reduct &rb (chirps-sings-canary-rule))
!(add-reduct &rb (frog-green-rule))
!(add-reduct &rb (canary-yellow-rule))




;; Backward chainer
(: bc_bem (-> Atom Nat Atom))
;; Base case
(= (bc_bem $conclusion $depth)
   (match &kb $conclusion $conclusion))

;; Recursive step
(= (bc_bem $conclusion (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)        ;(p1 p2 (Inheritance $what green))  ((True) (Inheritance fritz frog) (Inheritance fritz green))
          (let* (($premise1 (bc_bem $premise1 $k))     ;(bc (True) (s z))    (True)
                 ($premise2 (bc_bem $premise2 $k)))     ;(bc (Inheritance fritz frog) (s z)) ->  ( (Evaluation croaks Fritz) (Evaluation eats_flies fritz) (Inheritance $x frog))
            $conclusion)))                                      ;(Evaluation croaks $x) (Evaluation eats_flies $x) 



;; run the backward chainer to find out "What is green?" by defining a target

!(bc_bem (Inheritance $what green) (fromNumber 2))

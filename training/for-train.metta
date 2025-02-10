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

;; Forward chainer

;; Base case
(= (fc $premise $depth) $premise)
;; Recursive steps
(= (fc $premise1 (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)
          (match &kb $premise2 (fc $conclusion $k))))

(= (fc $premise2 (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)
          (match &kb $premise1 (fc $conclusion $k))))


 


!(fc (Evaluation croaks Fritz) (fromNumber 2))
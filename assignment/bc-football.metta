;; Define cast functions between Nat and Number
(: fromNumber (-> Number Atom))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))

;; Knowledge base (Football Facts)
!(bind! &kb (new-space))
!(add-atom &kb (Evaluation scores_many_goals Messi))
!(add-atom &kb (Evaluation scores_many_goals Ronaldo))
!(add-atom &kb (Evaluation wins_multiple_trophies Messi))
!(add-atom &kb (Evaluation wins_multiple_trophies Ronaldo))
!(add-atom &kb (Evaluation wins_multiple_trophies Haaland))
!(add-atom &kb (True))

;; Rule base (Football Logic)
!(bind! &rb (new-space))

(=(goat-rule) 
    (-> (Evaluation scores_many_goals $x) 
          (Evaluation wins_multiple_trophies $x) 
              (Inheritance $x GOAT)))

(=(goat-fans-rule)
    (-> (Inheritance $x GOAT) 
          (Inheritance $x millions_of_fans)))

(=(fans-legendary-rule)
    (-> (Inheritance $x millions_of_fans) 
            (Inheritance $x legendary)))

!(add-reduct &rb (goat-rule))
!(add-reduct &rb (goat-fans-rule))
!(add-reduct &rb (fans-legendary-rule))

;; Backward chainer with single and double premise support
(: bc_bem (-> Atom Nat Atom))

;; Base case: Check if the conclusion is already in the knowledge base
(= (bc_bem $conclusion $depth)
   (match &kb $conclusion $conclusion))

;; Recursive step: Handle rules with one premise
(= (bc_bem $conclusion (S $k))
   (match &rb (-> $premise1 $conclusion) 
          (let* (($premise1 (bc_bem $premise1 $k))) 
            $conclusion)))

;; Recursive step: Handle rules with two premises
(= (bc_bem $conclusion (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)        
          (let* (($premise1 (bc_bem $premise1 $k))     
                 ($premise2 (bc_bem $premise2 $k)))     
            $conclusion))) 

;; Run the backward chainer to find out "Who is legendary?"
!(bc_bem (Inheritance $who legendary) (fromNumber 3))

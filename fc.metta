;; Define cast functions between Nat and Number
(: fromNumber (-> Number Atom))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))

;; Knowledge Base (Internship Requirements)
!(bind! &kb (new-space))

;; Adding internship-related facts
!(add-atom &kb (Evaluation CompletedCourses John 5))
!(add-atom &kb (Evaluation TrainingSessions John 10))
!(add-atom &kb (Evaluation TopFourInterns John))
!(add-atom &kb (Evaluation Attendance John 40)) ;; 40 hours/month
!(add-atom &kb (Evaluation ResumeUpdated John Weekly))
!(add-atom &kb (True)) ;; Needed for general rules

;; Rule Base
!(bind! &rb (new-space))

;; Rule 1: Completing courses + attending training -> internship success
(= (courses-training-rule) 
   (-> (Evaluation CompletedCourses $x 5)
       (Evaluation TrainingSessions $x 10)
       (Evaluation InternshipSuccessful $x)))

;; Rule 2: Being a top intern -> staff qualification
(= (top-intern-rule)
   (-> (Evaluation TopFourInterns $x)
       (Evaluation qualifies-for-staff $x)))

;; Rule 3: If internship success + other conditions -> qualifies for staff
(= (full-qualification-rule)
   (-> (Evaluation InternshipSuccessful $x)
       (Evaluation Attendance $x 40)
       (Evaluation ResumeUpdated $x Weekly)
       (Evaluation qualifies-for-staff $x)))

;; Rule 4: If not qualified -> not qualified
(= (failure-rule)
   (-> (not (Evaluation qualifies-for-staff $x))
       (Evaluation not-qualified $x)))

!(add-reduct &rb (courses-training-rule))
!(add-reduct &rb (top-intern-rule))
!(add-reduct &rb (full-qualification-rule))
!(add-reduct &rb (failure-rule))

;; Forward Chaining Function
(= (fc $premise $depth) $premise)

(= (fc $premise1 (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)
          (match &kb $premise2 (fc $conclusion $k))))

(= (fc $premise2 (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)
          (match &kb $premise1 (fc $conclusion $k))))

;; Run Forward Chaining to determine John's qualification
!(fc (Evaluation CompletedCourses John 5) (fromNumber 2))
!(fc (Evaluation qualifies-for-staff John) (fromNumber 2))
!(fc (Evaluation not-qualified John) (fromNumber 2))
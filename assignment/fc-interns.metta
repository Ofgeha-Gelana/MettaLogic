;; Define cast functions between Nat and Number
(: fromNumber (-> Number Atom))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))


;; Knowledge base (Intern Performance Data)
!(bind! &kb (new-space))
!(add-atom &kb (Evaluation completed_courses 5))
!(add-atom &kb (Evaluation weekly_hours 10))
!(add-atom &kb (Evaluation monthly_hours 40))
!(add-atom &kb (Evaluation resume_updated weekly))
!(add-atom &kb (Evaluation attended_meeting Monday))
!(add-atom &kb (Evaluation attended_meeting Wednesday))
!(add-atom &kb (Evaluation worked_on_projects True))
!(add-atom &kb (True))


;; Rule base (Internship Evaluation Logic)
!(bind! &rb (new-space))

;; Rule: If intern completed all requirements, they qualify for evaluation
(=(qualify-for-evaluation-rule)
    (-> (Evaluation completed_courses 5)
        (Evaluation weekly_hours 10)
        (Evaluation monthly_hours 40)
        (Evaluation resume_updated weekly)
        (Evaluation attended_meeting Monday)
        (Evaluation attended_meeting Wednesday)
        (Evaluation worked_on_projects True)
        (Inheritance Intern qualified_for_evaluation)))

;; Rule: If intern qualifies for evaluation, they can become staff or member
(=(become-staff-or-member-rule)
    (-> (Inheritance Intern qualified_for_evaluation)
        (Inheritance Intern staff_or_member)))

;; Rule: If intern is missing any requirement, they get rejected
(=(intern-rejected-rule)
    (-> (not (Inheritance Intern qualified_for_evaluation))
        (Inheritance Intern rejected)))


!(add-reduct &rb (qualify-for-evaluation-rule))
!(add-reduct &rb (become-staff-or-member-rule))
!(add-reduct &rb (intern-rejected-rule))


;; Forward chainer

;; Base case: Return the given premise
(= (fc $premise $depth) $premise)

;; Recursive step: Apply rules using forward chaining
(= (fc $premise1 (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)
          (match &kb $premise2 (fc $conclusion $k))))

(= (fc $premise2 (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)
          (match &kb $premise1 (fc $conclusion $k))))


;; Run forward chainer to check if the intern qualifies
!(fc (Inheritance Intern staff_or_member) (fromNumber 3))

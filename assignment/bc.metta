;; Define the knowledge base
!(bind! &kb (new-space))

;; Add facts to the knowledge base
!(add-atom &kb (completed five-courses))       ;; You completed five courses
!(add-atom &kb (took ten-trainings))           ;; You took ten or more trainings
!(add-atom &kb (top-four-in-interns))          ;; You are in the top four interns
!(add-atom &kb (attended 40hrs-per-month))     ;; You attended 40 hours per month
!(add-atom &kb (updated-resume weekly))        ;; You updated your resume weekly

;; Define the rule base
!(bind! &rb (new-space))

;; Rule: Completing courses or experience parts means you've partially completed requirements
!(add-atom &rb (-> (completed five-courses) (completed courses-part)))
!(add-atom &rb (-> (took ten-trainings) (completed experience-part)))
!(add-atom &rb (-> (attended 40hrs-per-month) (completed experience-part)))
!(add-atom &rb (-> (updated-resume weekly) (completed experience-part)))
!(add-atom &rb (-> (top-four-in-interns) (completed experience-part)))

;; Rule: Completing both parts means you've completed all requirements
!(add-atom &rb (-> (completed courses-part) (completed all-requirements)))
!(add-atom &rb (-> (completed experience-part) (completed all-requirements)))

;; Rule: If all requirements are completed, you become a staff member
!(add-atom &rb (-> (completed all-requirements) (become-staff)))

;; Backward chainer function
(: bc (-> Atom (Maybe Atom)))

;; Base case: If the conclusion exists in KB, return it
(= (bc $conclusion)
   (match &kb $conclusion $conclusion))

;; Recursive rule: If a rule exists, apply it
(= (bc $conclusion)
   (match &rb (-> $premise $conclusion)
          (bc $premise)))

;; Recursive rule for multi-premise cases
(= (bc $conclusion)
   (match &rb (-> $premise1 $premise2 $conclusion)
          (if (and (bc $premise1) (bc $premise2))
              $conclusion
              nil)))

;; Final decision rule: If all requirements are met, become staff; otherwise, become a coffee taster
(= (bc (become-staff))
   (if (bc (completed all-requirements))
       (become-staff)
       (become-professional-coffee-taster)))

;; Debugging: Print step-by-step derivation
!("Checking if all requirements are met:")
!(bc (completed all-requirements))

!("Final Decision:")
!(bc (become-staff))
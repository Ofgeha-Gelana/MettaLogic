# Forward Chainer

A MeTTa-based project to evaluate iCog Labs interns and determine if they become staff members or Rejected.

## Overview
This project uses MeTTa (Meta Type Theory) to evaluate whether an intern at iCog Labs qualifies to become a staff member. The evaluation is based on the following rules:
- Complete five courses
- Take ten or more trainings
- Be in the top four interns
- Attend 10 hours/week or 40 hours/month
- Update your resume weekly

If all requirements are met, the intern becomes a staff member. Otherwise, they become a professional coffee taster (just kidding!).

## How It Works
The project uses backward chaining in MeTTa to determine if the intern qualifies. It checks the knowledge base (facts) and applies rules to derive the conclusion.

## Usage
1. Clone the repository.
2. Run the MeTTa code using a MeTTa interpreter.
3. Check the output to see if you become a staff member or a coffee taster.

## Example Output
- If you qualify: `(become-staff)`
- If you don't qualify: `(become-professional-coffee-taster)`

## License
This project is licensed under the MIT License.
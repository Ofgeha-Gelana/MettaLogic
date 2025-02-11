# MeTTa Logic-based Inference Systems

This repository demonstrates two educational projects built using **MeTTa Logic**, a framework for forward and backward chaining logic programming. These projects simulate real-world scenarios, employing logical inference to draw conclusions about football legends and the evaluation of interns at Icogs.

## Projects Overview

### 1. **Football GOAT Evaluation**

**Problem:**
In the world of football, there is often debate about who is the **Greatest of All Time (GOAT)**. This project simulates the evaluation of famous football players, such as **Messi**, **Ronaldo**, and others, based on their achievements. The goal is to determine if a player qualifies as a **GOAT** using logical rules.

**Approach:**
- **Knowledge Base (KB):** The knowledge base stores data about football players, such as goals scored, trophies won, and fan following.
- **Rule Base (RB):** The rule base contains rules that define the criteria for being considered a GOAT. For example:
  - A player who scores many goals and wins multiple trophies qualifies as a **GOAT**.
  - A player who qualifies as a GOAT is considered **legendary**.
- **Backward Chaining:** The system uses backward chaining to check whether a player meets the criteria for being **legendary** and thus qualifies as a **GOAT**.
- **Evaluation:** The system uses logical inference to determine if a player is **legendary** and qualifies as the **GOAT** based on their achievements.

### 2. **iCog Labs Internship Evaluation**

**Problem:**
This project models the **internship evaluation process** at **iCog Labs**. Interns need to meet certain requirements over three months to be considered for promotion to staff or membership. The challenge is to use logical inference to evaluate whether an intern qualifies based on their performance.

**Approach:**
- **Knowledge Base (KB):** The knowledge base stores performance data for an intern, including:
  - The number of courses completed.
  - Weekly and monthly hours worked.
  - Whether the intern attended weekly meetings.
  - Whether the intern updated their resume weekly.
  - Whether the intern worked on assigned projects.
- **Rule Base (RB):** The rule base contains rules that define whether an intern qualifies for evaluation. The rules specify conditions such as:
  - Completing five courses.
  - Attending at least 10 hours per week or 40 hours per month.
  - Attending meetings on Mondays and Wednesdays.
  - Updating the resume weekly.
  - Working on assigned projects.
- **Forward Chaining:** Forward chaining is used to propagate the rules, evaluating step by step to determine if the intern qualifies for promotion to staff or membership.
- **Evaluation:** Based on the intern’s performance, the system evaluates whether the intern qualifies to be promoted to **staff or member**. If not, the intern is marked as **rejected**.

## Approach to Solving the Problems

### Problem Understanding
- **Football GOAT Evaluation:** The goal is to assess whether a player qualifies as the **GOAT** based on their achievements. This involves representing facts such as goals scored and trophies won, and then applying rules to determine if the player meets the **GOAT** criteria.
- **Internship Evaluation:** The problem involves determining whether an intern qualifies for promotion based on their completed tasks and activities. This includes monitoring course completion, meeting attendance, hours worked, and more.

### Knowledge Representation
- Facts about players or interns are represented as atoms in the knowledge base (KB).
  - For example, in the **Football GOAT** project, facts might include "Messi scored many goals" or "Ronaldo won multiple trophies."
  - In the **Internship Evaluation** project, facts might include "Intern completed 5 courses" or "Intern attended 40 hours/month."

### Rule Definition
- Rules define how facts can be combined to infer new facts.
  - In the **Football GOAT** example, rules might state: "If a player scores many goals and wins multiple trophies, they qualify as a GOAT."
  - In the **Internship Evaluation** example, rules state: "If an intern completes 5 courses, attends 40 hours/month, and meets other requirements, they qualify for evaluation."

### Chaining Mechanism
- **Backward Chaining** (used in the **Football GOAT** problem): This technique starts with a goal (e.g., "Is Messi legendary?") and works backward through rules to find facts that support the goal.
- **Forward Chaining** (used in the **Internship Evaluation** problem): This technique starts with known facts and applies rules to infer new facts. It progressively checks if the intern qualifies for promotion based on their performance.

### Queries and Evaluation
- Once the facts and rules are set up, the system is queried to check if a player is a **GOAT** or if an intern qualifies for **staff or member** evaluation.
- The system then draws conclusions, such as "Messi is legendary" or "Intern is rejected."

### Setup Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Ofgeha-Gelana/MettaLogic.git

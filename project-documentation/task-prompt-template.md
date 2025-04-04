# SplitStream SaaS - Task Prompt

---

<<<<<<< HEAD
=======
## 0. Task Branch Setup (REQUIRED FIRST STEP)

**BEFORE MAKING ANY CHANGES, run the following command to create and checkout the task branch:**

```bash
./developer-admin/start-task.sh [Task Number]
```

This will create a branch specific to this task where you should make all your changes.

---

>>>>>>> 093dd3b (Initial commit for nextjs-splitstream-saas project)
## 1. Task Identification

-   **Phase:** `[Phase Number and Name, e.g., 2. Visual Selector & Element Targeting]`
-   **Subphase:** `[Subphase Number and Name, e.g., 2.1. iframe Loading & Interaction]`
-   **Task Number:** `[Full Task ID, e.g., 2.1.1]`
-   **Task Description:** `[Description from the implementation checklist, e.g., Implement UI in dashboard experiment setup to input target page URL]`

---

## 2. Context Files

_Before starting, review the relevant sections in the following documents ():_

-   `project-documentation/technical-design-document.md` (SaaS MVP+ Version)
-   `project-documentation/implementation-progress.md` (SaaS MVP+ Checklist Version)
-   `project-documentation/prompt-history-phase-X.Y-template.md` (Format for document task instruction and response histories)
-   `project-documentation/prompt-history-phase-X.Y.md` (Histories for preceding relevant tasks/phases)

---

## 3. Implementation Instructions

_Follow these steps precisely. Implement **ONLY** Task `[Task Number]`._

1.  **Context Analysis & Boundary Definition:**
    -   Briefly confirm your understanding of the specific scope and boundaries of **ONLY** this task (`[Task Number]`). Reference the TDD and checklist.
    -   Explicitly state 1-2 related tasks that are **OUT-OF-SCOPE** for this implementation (e.g., "Do not implement task `[Next Task Number]`, which involves...").
2.  **Step-by-Step Implementation:**
    -   `[Detailed Step 1 for implementing this specific task, e.g., "Create a new React component named 'TargetUrlInput' in the './src/components/experiment-setup' directory."]`
    -   `[Detailed Step 2, e.g., "Add an input field (type='url') and label within this component."]`
    -   `[Detailed Step 3, e.g., "Implement state management for the input field value using useState hook."]`
    -   `[Reference relevant TDD sections or specific technical requirements as needed]`
    -   `[...]`
3.  **Constraints & Considerations:**
    -   `[List any specific constraints from the TDD or previous discussions relevant ONLY to this task, e.g., "Ensure input validation checks for a valid URL format."]`
    -   `[Mention specific coding standards or libraries to use if applicable to this task]`
    -   **CRITICAL REMINDER:** Do NOT proceed to implement related tasks, even if they seem logically connected. Stop when this specific task is complete.

---

## 4. Required Outcomes & Acceptance Criteria

_Upon completion of **ONLY** Task `[Task Number]`, the following should be true:_

-   `[Specific Outcome 1, e.g., "A new input field for 'Target Page URL' is visible within the 'Create Experiment' form UI."]`
-   `[Specific Outcome 2, e.g., "User input in the URL field is captured in the component's state."]`
-   `[Specific Outcome 3, e.g., "The implementation strictly adheres to the boundaries defined in Step 1."]`
-   `[...]`

---

## 5. Testing Requirements (If Applicable)

_Perform the following tests to verify **ONLY** the functionality implemented in this task:_

-   **Unit Tests:**
    -   `[Specify any unit tests required for new functions/components, e.g., "Write a unit test for the URL validation logic."]`
-   **Manual Verification:**
    -   `[List specific manual steps, e.g., "1. Navigate to the 'Create Experiment' page. 2. Verify the 'Target Page URL' input field is present. 3. Enter text and confirm it appears in the field."]`

---

## 6. Quality Assurance Checks

_Before proceeding to Post-Task Actions, ensure:_

-   Code is properly formatted according to project standards (e.g., run linter/formatter).
-   Code includes necessary comments or documentation (e.g., JSDoc for functions).
-   Implementation aligns with the requirements and constraints specified above.
-   No code related to **OUT-OF-SCOPE** tasks has been included.

---

## 7. Post-Task Actions (Mandatory)

_After successful implementation and verification of **ONLY** Task `[Task Number]`, perform the following:_

1.  **Update Prompt History (`project-documentation/prompt-history-phase-X.Y.md`):**
    -   Create/Append the prompt given to you (this document) and your detailed response/summary for completing Task `[Task Number]`, following the established format.
2.  **Prepare Delivery Summary:**
    -   Draft a summary confirming completion of Task `[Task Number]` only. List files changed, summarize implementation, state what was _not_ implemented (boundaries), and reference testing performed. (This will often form part of your response when you complete the task).
<<<<<<< HEAD
=======
3.  **REQUIRED FINAL STEP - Complete Task:**
    -   Run the following command to mark the task as complete, commit changes, and merge the task branch back to main:
    ```bash
    ./developer-admin/complete-task.sh [Task Number]
    ```
    -   This script will:
        -   Update the implementation-progress.md file to mark the task as complete
        -   Commit any changes made during the task
        -   Push changes to the remote repository
        -   Merge the task branch back to the main branch
>>>>>>> 093dd3b (Initial commit for nextjs-splitstream-saas project)

---

_This prompt defines the work for **Task [Task Number] ONLY**. Adhere strictly to the boundaries and instructions._

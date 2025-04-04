# Task Plan: 1.2.1 - Create Clerk application and configure basic settings

**Goal:** Prepare the project to use Clerk for authentication by setting up the necessary Clerk application, configuring its basic settings, and adding the required environment variables to the Next.js application.

**Approved Actions:**

1.  **Manual User Action Required (Completed):**

    -   User created a new Clerk Application via the [Clerk Dashboard](https://dashboard.clerk.com/).
    -   User noted the **Publishable Key** and **Secret Key** from the **API Keys** section.
    -   User configured **Allowed Origins** in the **Domains** section (including local development and Vercel deployment URLs).
    -   User enabled desired **Social Connections** (e.g., Email/Password, Google).

2.  **Code Changes (Roo):**
    -   Update `app/.env.example` to include placeholders for the Clerk keys:
        ```
        NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_test_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        CLERK_SECRET_KEY=sk_test_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        ```
    -   Update `app/.env.local` (which is gitignored) to include commented-out lines for the user to add their actual keys:
        ```
        # Clerk Keys (Add your actual keys here)
        # NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=
        # CLERK_SECRET_KEY=
        ```

**Out-of-Scope for this task:**

-   Installing Clerk SDKs/libraries (Task 1.2.2).
-   Implementing Clerk frontend components (Task 1.2.2, 1.2.3).
-   Implementing backend authentication middleware (Task 1.2.6).
-   Adding the actual keys to `.env.local` (User action required after this task).

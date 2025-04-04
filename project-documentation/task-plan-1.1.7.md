# Task Plan: 1.1.7 - Configure initial deployment pipeline (e.g., Vercel, Heroku) with HTTPS

**Goal:** Prepare the project for deployment on Vercel, which is well-suited for Next.js and automatically handles HTTPS.

**Approved Actions:**

1.  **Vercel Project Setup (Manual User Action Required):**
    -   User needs to sign up or log in at [Vercel](https://vercel.com/).
    -   User needs to create a **New Project** and import the Git repository (`stevenfullman/nextjs-splitstream-saas`).
    -   User needs to configure the **Root Directory** setting in Vercel to be `app/`.
    -   User needs to configure the **Environment Variables** in the Vercel project settings, copying the values from `app/.env.local`:
        -   `NEXT_PUBLIC_SUPABASE_URL`
        -   `NEXT_PUBLIC_SUPABASE_ANON_KEY`
        -   `SUPABASE_SERVICE_ROLE_KEY` (Marked as Secret).
    -   User needs to deploy the project.
2.  **Vercel Configuration File:**
    -   Create a `vercel.json` file in the _project root_ to explicitly set the root directory for Vercel builds.

**Resulting Files/Changes:**

-   `vercel.json` (created in the project root).

**Out-of-Scope for this task:**

-   Actually performing the Vercel project creation, configuration, and deployment (requires manual user action).
-   Setting up custom domains.
-   Configuring deployment for other platforms (e.g., Heroku).

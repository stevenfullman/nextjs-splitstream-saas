# Task Plan: 1.1.6 - Setup Supabase project (database instance, API keys)

**Goal:** Configure the Next.js application (`app/`) to connect to a Supabase project using environment variables and install the necessary client library.

**Approved Actions:**

1.  **Supabase Project Setup (Manual User Action Required):**
    -   User needs to manually create a new project on [Supabase](https://supabase.com/).
    -   User needs to navigate to the project's **Settings > API**.
    -   User needs to note down the **Project URL**, the **`anon` public key**, and the **`service_role` secret key**. **The `service_role` key must be kept secure.**
2.  **Environment File Creation:**
    -   Create an `app/.env.example` file with placeholder variables (committed to repo).
    -   Create an `app/.env.local` file (ignored by git, needs manual population by user).
3.  **Install Supabase Client Library:**
    -   Run `npm install @supabase/supabase-js` within the `app/` directory.

**Resulting Files/Changes:**

-   `app/.env.example` (containing placeholder variables)
-   `app/.env.local` (created, needs manual population by the user)
-   `app/package.json` and `app/package-lock.json` updated with `@supabase/supabase-js` dependency.

**Out-of-Scope for this task:**

-   Actually creating the Supabase project (requires manual user action).
-   Defining database schemas or tables.
-   Implementing Supabase client initialization logic in the code.
-   Configuring production environment variables.

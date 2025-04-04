# Task Plan: 1.1.4 - Initialize backend project (e.g., using Next.js API routes)

**Goal:** Initialize a standard Next.js project within the `app/` directory using `create-next-app`. This project will initially host our backend API routes and later evolve into the full-stack application.

**Approved Actions:**

1.  **Initialize Next.js:** Run `npx create-next-app@latest . --ts --eslint --tailwind --src-dir --app --use-npm --import-alias "@/*"` inside the `app/` directory. This command sets up a Next.js project with:
    -   TypeScript (`--ts`)
    -   ESLint (`--eslint`)
    -   Tailwind CSS (`--tailwind`) - Included now for easier future frontend migration.
    -   `src/` directory structure (`--src-dir`)
    -   App Router (`--app`)
    -   npm as the package manager (`--use-npm`)
    -   `@/*` import alias (`--import-alias "@/*"`)
    -   Installation in the current directory (`.`) which will be `app/`.
2.  **Configure `package.json`:** Add the `engines` field to the newly created `app/package.json` to specify the required Node.js version, matching the `.nvmrc` file (Node 20.x). Example: `"engines": { "node": ">=20.0.0" }`.
3.  **Adjust `.gitignore`:** Review the `.gitignore` file created by `create-next-app` inside `app/` and ensure it complements the root `.gitignore` without unnecessary duplication (e.g., `node_modules` might be in both). Keep Next.js-specific ignores like `.next/`.

**Out-of-Scope for this task:**

-   Creating specific API routes.
-   Implementing any application logic.
-   Modifying the default Next.js page components significantly.

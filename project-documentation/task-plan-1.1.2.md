# Task Plan: 1.1.2 - Define project structure for SaaS application

**Goal:** Create the basic directory structure to house the backend API (Next.js), the initial MVP frontend dashboard (basic HTML/CSS/JS), and potential shared packages, aligning with the technical design document and future migration plans.

**Approved Actions:**

1.  **Create the following top-level directories:**
    -   `app/`: For the Next.js application (initially backend API, later full-stack).
    -   `dashboard-mvp/`: For the separate, basic HTML/CSS/JS frontend used during the MVP+ phase.
    -   `packages/`: For potential shared code/types (placeholder initially).
    -   `public/`: Standard Next.js directory for static assets (placeholder initially).
    -   `scripts/`: For additional utility scripts (placeholder initially).
2.  **Create basic placeholder files within the new directories** to indicate their purpose:
    -   `dashboard-mvp/index.html`
    -   `dashboard-mvp/styles.css`
    -   `dashboard-mvp/script.js`
    -   `packages/README.md`
    -   `scripts/README.md`

**Resulting Structure:**

```
/Users/stevenfullman/Documents/nextjs/nextjs-splitstream-saas/
├── app/
├── dashboard-mvp/
│   ├── index.html
│   ├── styles.css
│   └── script.js
├── packages/
│   └── README.md
├── public/
├── scripts/
│   └── README.md
├── developer-admin/ # Existing
├── project-documentation/ # Existing
├── .gitignore       # Existing
└── README.md        # Existing
```

**Out-of-Scope for this task:**

-   Initializing the actual Next.js application within `app/` (Task 1.1.4).
-   Implementing the content of the MVP dashboard files (Task 1.1.5).
-   Any other setup tasks (Node.js config, Supabase, deployment, etc.).

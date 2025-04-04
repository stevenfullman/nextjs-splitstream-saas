# Task Plan: 1.1.3 - Configure local development environment

**Goal:** Specify the Node.js version and preferred package manager (npm) for the project to ensure consistency across development environments.

**Approved Actions:**

1.  Create a `.nvmrc` file in the project root specifying a recent LTS Node.js version (`lts/iron`, which is Node 20.x). This helps developers using NVM (Node Version Manager) use the correct version.
2.  Create a `.npmrc` file in the project root with the content `engine-strict=true`. This setting ensures that npm checks the Node.js version compatibility defined in `package.json` (which will be added in a later task) before installing dependencies.

**Resulting Files:**

-   `.nvmrc` (containing `lts/iron`)
-   `.npmrc` (containing `engine-strict=true`)

**Out-of-Scope for this task:**

-   Installing Node.js or npm.
-   Initializing the Next.js project or adding a `package.json` file (Task 1.1.4).
-   Configuring specific project dependencies.

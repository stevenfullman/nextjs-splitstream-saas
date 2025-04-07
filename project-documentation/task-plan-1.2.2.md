# Task Plan: 1.2.2 - Integrate Clerk frontend components/SDK into the basic dashboard for Sign Up

**Goal:** Add the Clerk JavaScript SDK to the basic HTML/CSS/JS dashboard (`dashboard-mvp/`) and implement the initial Sign Up flow using Clerk's pre-built components.

**Approved Actions:**

1.  **Update `dashboard-mvp/index.html`:**

    -   Add the Clerk JS script tag (using the CDN link) to the `<head>`. This script handles loading the Clerk SDK.
    -   Add placeholder `div` elements to manage display based on authentication state:
        -   `<div id="auth-container"></div>`: This will hold the Clerk Sign Up/Sign In components.
        -   `<div id="logged-in-content" style="display: none;"><h1>Welcome! (Logged In Content Placeholder)</h1></div>`: Content shown when the user is logged in.
        -   `<div id="logged-out-content"><h1>Please Sign Up or Sign In</h1></div>`: Content shown when the user is logged out, prompting them to use the component in `#auth-container`.

2.  **Update `dashboard-mvp/script.js`:**
    -   **Add Publishable Key Constant:** Define a constant variable (e.g., `CLERK_PUBLISHABLE_KEY`) at the top of the script. **Crucially, the user must manually replace the placeholder value with their actual Clerk Publishable Key obtained in Task 1.2.1.** This is necessary because there's no build process or environment variable injection in this basic setup.
    -   **Initialize ClerkJS:** Create a new `Clerk` instance using the `CLERK_PUBLISHABLE_KEY`.
    -   **Load SDK:** Call `clerk.load()` to asynchronously load the necessary Clerk resources.
    -   **Add Auth Listener:** Use `clerk.addListener()` to register a callback function that fires whenever the authentication state changes (e.g., user logs in, logs out).
    -   **Handle Auth State:** Inside the listener callback:
        -   Check if `clerk.user` is truthy (user is logged in).
        -   If logged in: Hide `#logged-out-content`, show `#logged-in-content`, and ensure `#auth-container` is empty (or unmount any existing component).
        -   If logged out: Show `#logged-out-content`, hide `#logged-in-content`, and mount the Clerk `<SignUp>` component into the `#auth-container` div using `clerk.mountSignUp(document.getElementById('auth-container'))`.

**Out-of-Scope for this task:**

-   Integrating the Sign In component (Task 1.2.3).
-   Implementing session management beyond the basic listener (Task 1.2.4).
-   Implementing protected routing (Task 1.2.5).
-   Backend integration (Task 1.2.6).
-   Styling the components beyond Clerk's defaults.

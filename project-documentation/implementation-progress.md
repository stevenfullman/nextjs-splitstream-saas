# SPLITSTREAM -- SaaS MVP+ Implementation Checklist

## 1. Phase 1: Foundation & Setup (Weeks 1-2)

### 1.1. Project Initialization & Environment Setup

-   [x] **1.1.1.** Set up Git version control repository (e.g., GitHub, GitLab).
-   [x] **1.1.2.** Define project structure for SaaS application (e.g., backend API, frontend dashboard, shared packages).
-   [x] **1.1.3.** Configure local development environment (Node.js version, package manager - npm/yarn).
-   [x] **1.1.4.** Initialize backend project (e.g., using Next.js API routes).
-   [x] **1.1.5.** Initialize basic frontend dashboard project (HTML/CSS/JS structure).
-   [x] **1.1.6.** Setup Supabase project (database instance, API keys).
-   [x] **1.1.7.** Configure initial deployment pipeline (e.g., Vercel, Heroku) with HTTPS.

### 1.2. Authentication Setup (Clerk)

-   [ ] **1.2.1.** Create Clerk application and configure basic settings (allowed origins, providers).
-   [ ] **1.2.2.** Integrate Clerk frontend components/SDK into the basic dashboard for Sign Up.
-   [ ] **1.2.3.** Integrate Clerk frontend components/SDK into the basic dashboard for Sign In.
-   [ ] **1.2.4.** Implement session management/checking on the frontend dashboard.
-   [ ] **1.2.5.** Implement basic protected routing/access control in the frontend dashboard.
-   [ ] **1.2.6.** Implement backend API authentication/middleware using Clerk SDK to verify requests.

### 1.3. Payment Setup (Stripe)

-   [ ] **1.3.1.** Set up Stripe account and configure API keys.
-   [ ] **1.3.2.** Define subscription products and pricing tiers (Freemium, Premium) in Stripe dashboard.
-   [ ] **1.3.3.** Integrate Stripe Checkout or Payment Links for initial subscription selection (post-signup).
-   [ ] **1.3.4.** Set up Stripe Customer Portal for subscription management.
-   [ ] **1.3.5.** Implement backend webhook endpoint to listen for Stripe events (e.g., `checkout.session.completed`, `customer.subscription.updated`).
-   [ ] **1.3.6.** Implement logic to update user subscription status in Supabase based on Stripe webhooks.

### 1.4. Basic Dashboard & Snippet UI Shell

-   [ ] **1.4.1.** Create basic dashboard layout (HTML/CSS) with navigation (Dashboard, Experiments, Installation, Account).
-   [ ] **1.4.2.** Implement basic "Installation/Get Snippet" page UI structure (placeholder for snippet code).
-   [ ] **1.4.3.** Implement basic "Account" page UI linking to Stripe Customer Portal.
-   [ ] **1.4.4.** Implement basic "Experiments" list view UI (empty state).

## 2. Phase 2: Visual Selector & Element Targeting (Weeks 3-6)

### 2.1. iframe Loading & Interaction

-   [ ] **2.1.1.** Implement UI in dashboard experiment setup to input target page URL.
-   [ ] **2.1.2.** Implement iframe component to load the user-provided URL within the dashboard.
-   [ ] **2.1.3.** Implement mechanism to inject a script into the loaded iframe for communication/event capture (if needed, respecting cross-origin policies).
-   [ ] **2.1.4.** Implement event listeners (hover, click) in the dashboard parent window to detect interactions within the iframe.
-   [ ] **2.1.5.** Implement visual highlighting feedback for hovered elements within the iframe.
-   [ ] **2.1.6.** Implement persistent highlighting/selection state for clicked elements.

### 2.2. Selector Generation & Storage

-   [ ] **2.2.1.** Research and select/implement a robust CSS selector generation library/algorithm (prioritizing stability).
-   [ ] **2.2.2.** Integrate selector generation logic: trigger on element click within the iframe.
-   [ ] **2.2.3.** Define Supabase schema/tables for storing experiment configurations, including element selectors or identifiers.
-   [ ] **2.2.4.** Implement backend API endpoint(s) for saving experiment configuration (including selected element data).
-   [ ] **2.2.5.** Connect frontend selector generation to backend API for saving.

### 2.3. Fallback Implementation (Manual Selectors & Data Attributes)

-   [ ] **2.3.1.** Implement UI components (input fields) for manual CSS selector entry in the experiment setup flow.
-   [ ] **2.3.2.** Implement UI components for entering `data-splitstream-id` values.
-   [ ] **2.3.3.** Implement logic to detect iframe loading failures (e.g., `X-Frame-Options` errors).
-   [ ] **2.3.4.** Implement UI flow to gracefully guide users to fallback methods upon iframe failure.
-   [ ] **2.3.5.** Ensure fallback methods also save correctly to the experiment configuration via the backend API.

### 2.4. Basic Experiment Configuration UI (Element Mod Type)

-   [ ] **2.4.1.** Develop UI form for basic experiment details (Name, Target URL for visual selection).
-   [ ] **2.4.2.** Integrate the element selection component (visual selector + fallbacks) into this form.
-   [ ] **2.4.3.** Develop UI section for defining variants _for a selected element_.
-   [ ] **2.4.4.** Implement UI dropdown/selector for "Type of Change" (Text, Image Src, Link Href, Visibility, CSS Classes).
-   [ ] **2.4.5.** Implement conditional input fields based on the selected "Type of Change".
-   [ ] **2.4.6.** Implement UI to add multiple variants (e.g., Variant B, Variant C) for a single element.
-   [ ] **2.4.7.** Implement UI to configure multiple elements within the same experiment.

## 3. Phase 3: Core Snippet & Backend API (Element Modification) (Weeks 7-8)

### 3.1. Snippet Generation & Core Logic

-   [ ] **3.1.1.** Implement backend service/logic to generate unique JS snippet code embedding user/site ID.
-   [ ] **3.1.2.** Update "Installation/Get Snippet" page UI to display the dynamically generated snippet.
-   [ ] **3.1.3.** Implement snippet's initial handshake logic (`/init` call, sending identifiers).
-   [ ] **3.1.4.** Implement snippet's visitor identification and cookie management (setting/reading visitor ID).
-   [ ] **3.1.5.** Implement snippet logic to parse instructions received from the backend `/init` response.

### 3.2. Snippet DOM Manipulation Logic

-   [ ] **3.2.1.** Implement snippet function to find DOM elements using selectors received from backend.
-   [ ] **3.2.2.** Implement snippet logic to change `innerText` / `innerHTML`.
-   [ ] **3.2.3.** Implement snippet logic to change `src` attribute.
-   [ ] **3.2.4.** Implement snippet logic to change `href` attribute.
-   [ ] **3.2.5.** Implement snippet logic to change `style.display` (Show/Hide).
-   [ ] **3.2.6.** _(Stretch Goal)_ Implement snippet logic for `classList.add/remove`.
-   [ ] **3.2.7.** Implement basic error handling for DOM manipulation (e.g., selector not found).

### 3.3. Backend API (Core Init/Track)

-   [ ] **3.3.1.** Define core Supabase schemas (users, sites, experiments, events - refine based on config needs).
-   [ ] **3.3.2.** Implement `/init` API endpoint logic (receive handshake, placeholder MAB/assignment, return _hardcoded_ element modification instructions initially).
-   [ ] **3.3.3.** Implement `/track` API endpoint logic (receive event data: impression/conversion, visitor/experiment/variant IDs).
-   [ ] **3.3.4.** Implement secure data validation and storage logic for `/track` endpoint into Supabase events table.

### 3.4. Snippet Conversion Tracking Logic

-   [ ] **3.4.1.** Implement dashboard UI for defining conversion goals (initially: click on element).
-   [ ] **3.4.2.** Ensure conversion goal configuration (e.g., target selector) is sent to snippet via `/init` response.
-   [ ] **3.4.3.** Implement snippet logic to attach click listeners based on conversion goal selectors.
-   [ ] **3.4.4.** Implement snippet logic to send conversion event data to the `/track` API endpoint upon listener trigger.

### 3.5. Initial E2E Data Flow Test (Element Mod)

-   [ ] **3.5.1.** Manually configure a simple element modification experiment directly in Supabase.
-   [ ] **3.5.2.** Embed snippet on a test page.
-   [ ] **3.5.3.** Verify snippet calls `/init`, receives hardcoded instructions, modifies the correct element.
-   [ ] **3.5.4.** Trigger conversion click, verify snippet calls `/track`.
-   [ ] **3.5.5.** Verify event data appears correctly in Supabase tables.

## 4. Phase 4: Split URL Testing & AI Suggestions (Weeks 9-10)

### 4.1. Split URL Testing - Configuration UI

-   [ ] **4.1.1.** Add UI element (e.g., radio button/dropdown) in experiment creation to select "Split URL" type.
-   [ ] **4.1.2.** Implement UI section (conditional on type selection) to input Original URL and Variant URLs.
-   [ ] **4.1.3.** Update experiment configuration saving logic (backend/Supabase) to store variant URLs for this type.

### 4.2. Split URL Testing - Backend & Snippet Logic

-   [ ] **4.2.1.** Update backend `/init` endpoint logic: If experiment is Split URL type, return redirect instruction (target variant URL) based on MAB assignment (placeholder logic for now).
-   [ ] **4.2.2.** Implement snippet logic to check for redirect instruction in `/init` response.
-   [ ] **4.3.3.** Implement snippet client-side redirection (`window.location.href`).
-   [ ] **4.3.4.** Ensure conversion tracking logic functions correctly when snippet runs on variant pages (identifying the correct experiment/variant assignment via cookie).

### 4.3. AI Variant Suggestion Feature - Backend

-   [ ] **4.3.1.** Select 3rd party LLM provider and set up API key securely in backend environment.
-   [ ] **4.3.2.** Implement backend `/ai-suggest` API endpoint.
-   [ ] **4.3.3.** Implement logic within `/ai-suggest` to receive text, construct appropriate prompt for LLM API.
-   [ ] **4.3.4.** Implement logic to call LLM API, handle response/errors, extract suggestions.
-   [ ] **4.3.5.** Implement logic to return suggestions in a structured format to the frontend.

### 4.4. AI Variant Suggestion Feature - Frontend

-   [ ] **4.4.1.** Add "Get AI Suggestions" button to the element modification variant definition UI.
-   [ ] **4.4.2.** Implement frontend logic to call the `/ai-suggest` backend endpoint with original text.
-   [ ] **4.4.3.** Implement UI to display loading state while waiting for suggestions.
-   [ ] **4.4.4.** Implement UI to display returned suggestions clearly.
-   [ ] **4.4.5.** Implement UI mechanism for user to select a suggestion and add it as a variant (e.g., populate input field or add directly).

## 5. Phase 5: MAB Algorithm & Integration (Week 11)

### 5.1. MAB Algorithm Implementation

-   [ ] **5.1.1.** Implement core Epsilon-Greedy algorithm logic (server-side, e.g., in NextJS.js/TypeScript).
-   [ ] **5.1.2.** Define Supabase schema/tables for storing aggregated MAB stats (Impressions, Conversions per variant).
-   [ ] **5.1.3.** Implement backend logic/functions to read/write aggregated stats from/to Supabase.
-   [ ] **5.1.4.** Implement logic for handling minimum impression threshold before exploitation phase.
-   [ ] **5.1.5.** Define schema/logic for storing MAB state if needed (beyond aggregated stats).

### 5.2. Backend MAB Integration

-   [ ] **5.2.1.** Replace placeholder assignment logic in `/init` endpoint with actual MAB algorithm selection logic.
-   [ ] **5.2.2.** Ensure `/init` correctly fetches necessary stats for the MAB calculation for the requested experiment.
-   [ ] **5.2.3.** Ensure `/init` correctly triggers impression count updates (or relies on separate aggregation).
-   [ ] **5.2.4.** Implement aggregation logic: How/when are raw tracking events aggregated into stats for MAB? (e.g., Scheduled function, trigger on conversion, lazy calculation). Define and implement chosen strategy.
-   [ ] **5.2.5.** Ensure consistent visitor assignment logic is fully integrated (cookie ID checked before running MAB).

## 6. Phase 6: Statistical Significance & Results Display (Week 12)

### 6.1. Statistical Significance Calculation

-   [ ] **6.1.1.** Research and select appropriate statistical test (e.g., Chi-squared test for proportions).
-   [ ] **6.1.2.** Implement backend function to calculate significance based on aggregated stats (impressions/conversions per variant).
-   [ ] **6.1.3.** Determine output format (e.g., p-value, confidence level, simple boolean flag).
-   [ ] **6.1.4.** Integrate calculation into results data retrieval logic (calculate on demand or store results).

### 6.2. Results Dashboard UI Implementation

-   [ ] **6.2.1.** Develop UI for the Experiments list page (showing basic status of each experiment).
-   [ ] **6.2.2.** Develop UI for the individual Experiment Results page.
-   [ ] **6.2.3.** Implement frontend logic to fetch experiment results data (including stats) from backend API.
-   [ ] **6.2.4.** Display results table (Variants, Impressions, Conversions, Rate).
-   [ ] **6.2.5.** Clearly display Statistical Significance indicator(s) per variant.
-   [ ] **6.2.6.** Add UI element indicating the current "Winning" variant (based on MAB state/stats).
-   [ ] **6.2.7.** Add UI element showing MAB status (e.g., exploitation/exploration percentage).
-   [ ] **6.2.8.** Implement basic experiment controls (e.g., "Pause", "Archive" buttons) and corresponding backend API updates.

## 7. Phase 7: Utilities & Testing (Week 13)

### 7.1. Manual Override / Force Variant

-   [ ] **7.1.1.** Define mechanism (e.g., URL query parameter `?splitstream_force_variant=ID`).
-   [ ] **7.1.2.** Implement check for override parameter within the JS snippet logic.
-   [ ] **7.1.3.** If override detected, ensure snippet requests/applies the forced variant content or performs the forced redirect, bypassing MAB.
-   [ ] **7.1.4.** Ensure tracking still attributes correctly when a variant is forced (for debugging).

### 7.2. Integration Health Check

-   [ ] **7.2.1.** Implement backend logic to record timestamp of last successful `/init` call per user/site ID in Supabase.
-   [ ] **7.2.2.** Implement backend API endpoint for frontend dashboard to fetch this health check status.
-   [ ] **7.2.3.** Implement UI element on dashboard displaying the status clearly (e.g., "Snippet Detected", "No Data Received").

### 7.3. Integration & Debugging Focus

-   [ ] **7.3.1.** Conduct focused testing of interactions between Visual Selector, backend config, snippet execution (both Element Mod & Split URL).
-   [ ] **7.3.2.** Test AI suggestion feature integration.
-   [ ] **7.3.3.** Verify MAB logic selects variants and updates based on tracked conversions as expected.
-   [ ] **7.3.4.** Validate statistical significance calculations with known data sets.
-   [ ] **7.3.5.** Debug issues identified across the full stack.

## 8. Phase 8: Final Testing & Wrap-up (Week 14)

### 8.1. End-to-End Testing

-   [ ] **8.1.1.** Define E2E test scenarios covering full user journeys (Signup -> Install -> Create Element Mod Test -> View Sig. Results; Signup -> Install -> Create Split URL Test -> View Sig. Results).
-   [ ] **8.1.2.** Execute E2E test scenarios manually or with test framework.
-   [ ] **8.1.3.** Validate data consistency across dashboard, snippet behaviour, and Supabase storage.
-   [ ] **8.1.4.** Perform basic cross-browser/device checks on snippet and dashboard.

### 8.2. Performance & Security Review

-   [ ] **8.2.1.** Review snippet load impact (size, execution time).
-   [ ] **8.2.2.** Review API response times under simulated load.
-   [ ] **8.2.3.** Review database query performance.
-   [ ] **8.2.4.** Conduct security review (check auth enforcement, input sanitization, API security, dependency vulnerabilities).

### 8.3. Documentation Finalization

-   [ ] **8.3.1.** Write/Review basic user guide: Installation.
-   [ ] **8.3.2.** Write/Review basic user guide: Creating Element Modification Tests (using visual selector & fallbacks).
-   [ ] **8.3.3.** Write/Review basic user guide: Creating Split URL Tests (incl. snippet placement warning & SEO notes).
-   [ ] **8.3.4.** Write/Review basic user guide: Understanding Results (incl. significance).
-   [ ] **8.3.5.** Prepare internal developer notes (e.g., setup, architecture overview, future porting notes).

### 8.4. Deployment Preparation

-   [ ] **8.4.1.** Finalize environment configurations (API keys, database connections) for production/staging.
-   [ ] **8.4.2.** Perform final deployment checks on target platform (Vercel/Heroku).
-   [ ] **8.4.3.** Prepare communication/materials for internal testing or early adopter release.
-   [ ] **8.4.4.** Ensure monitoring/logging is in place for initial launch.

# SplitStream: Technical Design Document (SaaS MVP+)

**Project Codename:** SplitStream
**Version:** MVP+ 0.3
**Last Updated:** April 1, 2025

**Overview:**
SplitStream is a testing platform using a multi-armed bandit algorithm to automate and optimize landing page conversion rates. Unlike traditional A/B testing, SplitStream dynamically allocates traffic to landing page variants. This document details the technical design for the **MVP+ (Minimum Viable Product Plus)** phase, focusing on validating core functionality with key usability enhancements for a standalone SaaS application. While the MVP+ dashboard will use a basic HTML/CSS/JS implementation for rapid development, the backend API will leverage **Next.js API routes**, and the long-term plan involves migrating the dashboard to **Next.js with Shadcn UI / Tailwind CSS**. This version incorporates a visual selector, split URL testing, AI-assisted variant suggestions, and basic statistical significance reporting.

---

**1. Introduction**

**1.1 Purpose of This Document**

This document outlines the architecture, key features, and implementation plan for the SplitStream SaaS MVP+. It is the technical reference for developers and stakeholders, detailing components needed to test core functionalities:
_ User authentication (Clerk) and subscription payment integration (Stripe).
_ Visual Element Selector (iframe-based) for easy experiment setup, with fallbacks (CSS Selectors, Data Attributes).
_ JavaScript snippet generation and integration into any landing page.
_ Support for both Element Modification Tests and Split URL Tests.
_ AI-Assisted Variant Suggestions (manual trigger).
_ Backend API (using **Next.js API routes**) with data handling via Supabase.
_ A basic multi-armed bandit algorithm (epsilon-greedy).
_ Basic Statistical Significance reporting in the validation/analytics dashboard. \* Utilities: Manual variant forcing, integration health check.

**1.2 Project Objectives**
_ **Automate Landing Page Optimization:** Utilize a multi-armed bandit algorithm to dynamically test landing page variants.
_ **Seamless Integration & Flexibility:** Allow users to integrate via a JavaScript snippet onto _any_ website and run either element modification tests or split URL tests.
_ **User-Friendly Setup:** Enable easy selection of page elements for testing via a primary Visual Selector.
_ **AI Assistance:** Provide AI-powered suggestions for text variants.
_ **Rapid Validation:** Develop an MVP+ that validates the end-to-end SaaS flow – from auth/payment to variant selection/display, conversion tracking, and meaningful results reporting.
_ **Actionable Insights:** Provide basic statistical significance metrics. \* **Scalable Foundation:** Lay groundwork using **Next.js** for the API and planning for a full Next.js frontend migration post-MVP.

---

**2. System Overview**

**2.1 Architecture Overview**

The MVP+ SaaS architecture includes: 1. **Frontend Dashboard:**
_ Minimal web dashboard (**MVP+**: basic HTML/CSS/JS; **Post-MVP Target**: **Next.js/React with Shadcn UI/Tailwind**) for user registration/login (Clerk), subscription management (Stripe), experiment setup, snippet retrieval, and results viewing.
_ Includes the iframe-based Visual Selector component. 2. **JavaScript Integration Snippet:**
_ Standalone, lightweight JS file embedded by users on their external websites.
_ Communicates asynchronously with the Backend API.
_ Performs element modifications or client-side redirects based on API instructions.
_ Tracks visitor events and sends data to the Backend API. 3. **Backend API & Data Handling:**
_ API endpoints built with **Next.js API routes** (preferred).
_ Handles initialization, event tracking, AI suggestion proxying, MAB logic execution, statistical calculations, experiment config management.
_ Interacts with Supabase for data persistence.
_ Handles secure communication with Clerk and Stripe. 4. **Database:**
_ **Supabase** (PostgreSQL) storing user data, site/snippet configurations, experiment details (configs, selectors, variant URLs, stats), event logs, MAB state. 5. **Multi-Armed Bandit Algorithm:**
_ Server-side epsilon-greedy algorithm implemented within the Backend API. 6. **AI Variant Suggestion Service:**
_ Backend API endpoint proxies requests to a 3rd party Generative AI API. 7. **Validation & Analytics Components:**
_ Data aggregation and statistical significance calculations performed by the Backend API.
_ Results displayed in the Frontend Dashboard.
_ Integration Health Check status provided via API to the dashboard.

**2.2 Technology Stack**
_ **Frontend Dashboard (MVP+):** Basic HTML, CSS, JavaScript.
_ **Frontend Dashboard (Post-MVP Target):** **Next.js**, React, Shadcn UI, Tailwind CSS.
_ **Backend API:** **Next.js API Routes** (preferred). (Language: TypeScript/JavaScript).
_ **Database:** Supabase (PostgreSQL).
_ **Authentication:** Clerk.
_ **Payment:** Stripe.
_ **AI Suggestions:** Integration with a 3rd party LLM API (via Backend API).
_ **Deployment:** Vercel (ideal for Next.js) / Heroku / Similar PaaS. HTTPS required.

---

**3. Detailed Component Design**

**3.1 User Authentication & Payment Integration**
_ **Clerk:** Handle sign-up, login, session management via frontend SDK and backend verification. Secure dashboard access and API endpoints.
_ **Stripe:** Handle subscription selection/management via Checkout/Customer Portal. Backend webhooks update user status in Supabase based on payment events.

**3.2 Element Selection (Visual & Fallbacks)**
_ **Primary Method: iframe Visual Selector:**
_ Implemented within the Frontend Dashboard.
_ Loads external user URL in an iframe.
_ Dashboard JS captures events, generates stable CSS selector for clicked element.
_ Handles `X-Frame-Options` errors gracefully, offering fallbacks.
_ **Fallback Methods:** Manual CSS Selector input, Data Attribute (`data-splitstream-id`) targeting input within the dashboard. \* Selection configuration (selector/identifier) stored per experiment element in Supabase via Backend API.

**3.3 JavaScript Integration Snippet**
_ **Functionality:** Lightweight, standalone JS. Fetches instructions from Backend API (`/init`), applies DOM changes (text, src, href, display, classList) or performs redirects, tracks conversions via events, sends data to Backend API (`/track`). Manages visitor identity via first-party cookie. Handles forced variants via URL parameters.
_ **Communication:** Asynchronous `Workspace` calls to the Backend API.

**3.4 Backend API (Next.js API Routes)**
_ **Endpoints:**
_ `/api/init`: Authenticates snippet (via site ID/key), checks visitor cookie, runs MAB logic (fetching stats from Supabase), determines variant/redirect, returns instructions to snippet, logs impression implicitly/explicitly.
_ `/api/track`: Receives conversion event data, validates, stores raw event in Supabase.
_ `/api/ai-suggest`: Authenticates user (Clerk session), receives text, securely calls external LLM API, returns suggestions.
_ `/api/experiments`: CRUD endpoints for dashboard managing experiment configurations in Supabase (protected by Clerk auth).
_ `/api/health-check`: Provides snippet detection status to dashboard (protected by Clerk auth).
_ `/api/webhooks/stripe`: Receives Stripe events, updates Supabase (requires Stripe signature verification).
_ **Logic:** Contains MAB algorithm implementation, statistical significance calculation logic, data access layer for Supabase.

**3.5 Database (Supabase)** \* **Schema:** Tables for `users` (linking to Clerk/Stripe IDs, subscription status), `sites` (user sites, snippet keys), `experiments` (type, status, config, URL, goal selectors), `variants` (content, URLs, stats FK), `variant_stats` (impressions, conversions - aggregated), `events` (raw impression/conversion logs), `mab_state` (if needed). Use appropriate indexing.

**3.6 Multi-Armed Bandit Algorithm & Statistics**
_ **Algorithm:** Server-side Epsilon-Greedy implemented in backend language. Reads aggregated stats from `variant_stats`.
_ **Aggregation:** Define strategy (e.g., Supabase function triggered by `events` inserts, scheduled job, or calculation during `/init`) to update `variant_stats` from `events`. \* **Significance:** Backend calculates significance (e.g., Chi-squared) when results are requested by the dashboard API call.

**3.7 AI Variant Suggestions** \* Backend API endpoint acts as a secure proxy, managing external API key and prompt engineering.

**3.8 Validation & Analytics Dashboard Components**
_ **Results View (Frontend):** Fetches processed data (stats + significance) from a dedicated backend API endpoint. Displays table, winner indicator, significance info.
_ **Health Check (Frontend/Backend):** Backend logs last seen time for snippet; frontend fetches/displays status.

**3.9 Experiment Types**
_ **Element Modification:** Configured via Visual Selector/fallbacks. Backend returns element modification instructions to snippet.
_ **Split URL:** Configured via URL inputs in dashboard. Backend returns redirect URL instruction to snippet.

---

**4. Performance, Security, & Scalability Considerations**
_ **Performance:** Optimize JS snippet size/execution. Use efficient backend logic (Next.js serverless functions recommended). Index Supabase tables. Consider read replicas or caching (e.g., Redis) for stats if needed at scale.
_ **Security:** Standard web security practices (HTTPS, input validation/sanitization, output encoding). Secure API key management. Clerk for authN/authZ. Stripe webhook verification. Prevent XSS in dashboard and snippet manipulations. Address iframe security (sandboxing). CORS configuration for API. \* **Scalability:** Leverage serverless nature of **Next.js API routes** and Supabase's managed PostgreSQL. Consider message queues for event ingestion at very high scale.

---

**5. Future Porting & Roadmap Considerations**
_ **Frontend:** Planned migration of MVP+ basic HTML/JS dashboard to a full **Next.js application using React, Shadcn UI, and Tailwind CSS**.
_ **Backend:** API built with **Next.js** provides a solid foundation. \* **See separate Roadmap Document for detailed future features.**

---

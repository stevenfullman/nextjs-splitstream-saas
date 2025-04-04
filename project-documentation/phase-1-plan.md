# SplitStream SaaS MVP+ - Phase 1 Implementation Plan

This document outlines the planned approach for completing Phase 1: Foundation & Setup. Tasks will be executed sequentially, adhering to the project's task management rules (one task at a time with approval).

## Phase 1 Goal

Establish the essential infrastructure for the SplitStream application, including project setup, authentication, payment integration, and a basic dashboard shell.

## Proposed Task Sequence (Based on `implementation-plan.md`)

1.  **1.1 Project Initialization & Environment Setup (Remaining Tasks 1.1.2 - 1.1.7):**
    -   Define project structure.
    -   Configure local development environment.
    -   Initialize Next.js backend project.
    -   Initialize basic frontend dashboard project (HTML/CSS/JS).
    -   Setup Supabase project.
    -   Configure initial deployment pipeline.
2.  **1.2 Authentication Setup (Clerk) (Tasks 1.2.1 - 1.2.6):**
    -   Configure Clerk application.
    -   Integrate Clerk frontend SDK.
    -   Implement frontend session management & protected routing.
    -   Implement backend API authentication middleware.
3.  **1.3 Payment Setup (Stripe) (Tasks 1.3.1 - 1.3.6):**
    -   Configure Stripe account & products.
    -   Integrate Stripe Checkout/Customer Portal.
    -   Implement backend webhook endpoint.
    -   Implement logic to update user status in Supabase.
4.  **1.4 Basic Dashboard & Snippet UI Shell (Tasks 1.4.1 - 1.4.4):**
    -   Create basic dashboard layout & navigation.
    -   Implement placeholder UIs for Installation, Account, and Experiments.

## Phase 1 Component Interaction Diagram

```mermaid
graph TD
    subgraph "User Facing (Browser)"
        A[Frontend Dashboard (Basic HTML/JS)]
        C[Clerk UI Components]
        S[Stripe Checkout/Portal]
    end

    subgraph "Backend (Next.js API Routes on Vercel/PaaS)"
        B[Backend API]
        CW[Clerk Backend SDK]
        SW[Stripe Webhook Handler]
        DB[Supabase (PostgreSQL)]
    end

    subgraph "External Services"
        CLERK[Clerk Service]
        STRIPE[Stripe Service]
    end

    A -- Manages/Displays --> C
    A -- Initiates/Redirects --> S
    A -- API Calls --> B

    B -- Verifies Auth --> CW
    B -- Handles Data --> DB
    B -- Processes Payments --> SW

    C -- Communicates --> CLERK
    S -- Communicates --> STRIPE
    CW -- Communicates --> CLERK
    SW -- Receives Events --> STRIPE
    STRIPE -- Sends Webhooks --> SW

    style DB fill:#f9f,stroke:#333,stroke-width:2px
    style CLERK fill:#ccf,stroke:#333,stroke-width:2px
    style STRIPE fill:#cfc,stroke:#333,stroke-width:2px
```

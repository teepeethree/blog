---
author: tpotts
pubDatetime: 2024-07-03T00:00:00Z
title: All hail web apps
slug: ex-allhailwebapps
featured: false
draft: false
tags:
  - web-app
description: All hail web apps
---

## All hail web apps - down with mobile apps

Because:

- No publishing to app store
- No updating nonsense
- Every device can use an internet explorer

## SvelteKit learning

- SvelteKit is a framework (think like an opinionated template)
- Svelte handles HTML, CSS and JS / TS inside of Svelte components
- Svelte components are just reusable pieces of code (but handles UI, Business Logic and Data)
- SvelteKit splits client-side (+page.svelte) and server-side (+page.server.ts) computations / rendering / retrievals
- Imagine both sides handle their own UI, Business Logic, and Data processing
- You have the ability to choose what is rendered client-side, or server-side, or a mix of both.

## Front-end for Ordering

- Authentication (including custom claims)
- Use GET from Google Sheets to retrieve user-specific data
- User uses dynamically populated form that then POST's data to Google Sheets
- After submission, the user can see the Sheet has changed as intended

So the user flow is:

- User logs in
- User navigates to the form page
- User starts using the form as intended – data is populated from Google Sheets
- User fills out the form
- User submits the form - and data is then transmitted to Google Sheets
- User then can see the updated data change

### Architecture

The architecture would be:

- SvelteKit
- Tailwind CSS
- PocketBase

Where? Not sure where it'd be hosted. Should be hosted on the main server, and have a sub-domain to point to the app.

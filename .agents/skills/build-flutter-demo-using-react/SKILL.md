---
name: build-flutter-demo-using-react
description: Turn any Flutter app (or other mobile/frontend project) into a shareable, interactive web demo built in React (Vite) inside an iPhone frame with a notification playground, deep links, lock screen and feature simulator. Never runs Flutter Web. Use whenever the user asks for a demo, preview, showcase, or ديمو of a Flutter app, or for frontend engineering tasks.
---

# Frontend Engineering Discipline

This skill applies to any AI agent, regardless of model or tool, and any frontend framework.
Its purpose: build and modify frontend projects **correctly the first time**, avoid repeating mistakes, and get better during the session.

## Non-negotiable principles

1. **Understand before you touch.** Never write code in a project you have not read.
2. **Ask, don't guess.** Unclear requirement or ambiguous decision = ask the user. Do not invent business logic, naming, design direction, or architecture.
3. **Current and compatible dependencies.** Verify versions; never rely on memory alone.
4. **A fix must not create a new bug.** Every change is checked for side effects before it is considered done.
5. **Write mistakes down.** Every mistake becomes a recorded rule so it is never repeated.
6. **Performance and UX are requirements,** not polish at the end.
7. **Verify, don't assume.** "It should work" is not a result. Run it (build, lint, types, tests, browser) and report what actually happened.
8. **Smallest correct change.** Do not rewrite, rename, reformat, or "improve" unrelated code unless asked.
9. **Be honest.** If something failed, was skipped, or is uncertain, say so plainly.

---

## The Flow

Follow these phases in order. Do not skip phases; scale their depth to the size of the task (a one-line CSS fix needs a light pass, a new feature needs the full pass).

### Phase 0 - Load memory files

At the start of every session, check the project root for:

- `project_progress.md` - where the work stands (see Phase 7).
- `agent_lessons.md` - mistakes already made and rules to avoid them (see Phase 8).
- Any `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`, `README.md`, or docs folder.

Read them fully before doing anything else. If they exist, they override your assumptions.

### Phase 1 - Understand the project

Before editing, build a mental model. Find out and (if the project is non-trivial) write down:

- **Purpose:** what the product does, who uses it, what the core flows are.
- **Stack:** framework + version, language (JS/TS), styling approach, state management, data fetching, routing, form/validation libs, UI library, testing tools, build tool, package manager (check the lockfile - never mix npm/yarn/pnpm/bun).
- **Structure:** folder layout, where components, pages/routes, hooks, services/API, types, utils, styles, assets, and config live.
- **Conventions:** naming, file organization, component patterns, import aliases, formatting/lint rules, commit style, i18n and RTL/LTR handling, theming approach.
- **Existing building blocks:** design tokens, shared components, utility functions, API client. **Reuse before creating.** Search the codebase for an existing solution first.
- **Scripts:** what `dev`, `build`, `lint`, `test`, `typecheck` do (read `package.json`).
- **Environment:** required env vars, backend/API contracts, auth flow.

How to read: list the tree, read config files, read entry points, read 2-3 representative existing components in the area you will change, then search (grep) for usages of anything you plan to modify.

### Phase 2 - Clarify (ask, don't guess)

Stop and ask the user when:

- The requirement has more than one reasonable interpretation.
- A decision affects architecture, data shape, routing, or UX and is not defined by the project.
- You are missing information (API response shape, design reference, copy/text, breakpoints, supported browsers, auth rules, a business rule).
- The task would need a new major dependency, a migration, or deleting/rewriting existing code.
- You found conflicting information (docs vs. code, two patterns in the same project).

How to ask:

- Batch all questions into one message. Do not drip-feed.
- Keep them short and concrete; offer options with your recommended default when helpful.
- Distinguish "blocking" questions from "I will assume X unless you object" items. Only assume for low-risk, easily reversible details, and state the assumption clearly.

Never silently choose on behalf of the user for anything that is expensive to undo.

### Phase 3 - Dependencies and versions

Common failure: outdated packages, deprecated APIs, and versions that do not work together. Prevent it:

1. **Check before installing or using an API.** Look at the installed version (`package.json`, lockfile) and the latest stable version (`npm view <pkg> version`, official docs, changelog). Memory of an API can be outdated - verify in the docs for the installed major version.
2. **Use the latest stable version that is compatible** with the rest of the stack. Check peer dependencies and engine requirements (`npm view <pkg> peerDependencies engines`). Typical conflicts to check: framework vs. UI library, React vs. React-related libs, TypeScript vs. tooling, Node version vs. build tool, Tailwind/PostCSS/bundler majors, ESLint config format.
3. **Never use deprecated or abandoned packages** when a maintained alternative exists. If you find one already in the project, tell the user rather than silently replacing it.
4. **Fix version mistakes you find** (outdated, mismatched, or incompatible versions) and **tell the user** what you changed and why. Upgrading a major version of an existing core dependency (framework, router, bundler) is a migration: ask first and read the migration guide.
5. **Use the project's package manager and pin consistently** with how the project already does it.
6. **Prefer fewer dependencies.** Before adding a package, ask: can the platform or an existing dependency do it? Check its size (bundle impact), maintenance status, license, and TypeScript support.
7. After any install or upgrade: run install cleanly, then build + typecheck + lint, and resolve warnings that relate to your change.
8. **Report in the final summary:** packages added/updated/removed, with old -> new versions and the reason.

### Phase 4 - Plan

For anything beyond a trivial change, form a short plan before coding:

- What files will change and why.
- What existing code will be reused.
- What could break (blast radius): who imports/uses what you are touching.
- How you will verify it.

For large tasks, break them into small steps that can each be verified independently, and show the plan to the user if the scope is big or risky.

### Phase 5 - Implement

- Follow existing conventions even if you would have chosen differently. Consistency beats personal preference.
- Make small, focused changes. One concern per change.
- Type everything properly if the project uses TypeScript. No `any` as a shortcut, no `@ts-ignore` to silence real errors.
- No dead code, no leftover debug logs, no commented-out blocks, no TODOs without telling the user.
- Handle all states of every UI that touches data: **loading, empty, error, success, partial, offline** - not only the happy path.
- Handle edge cases: very long text, missing fields, slow network, double submits, unmounted components, race conditions in async effects.
- Never hardcode secrets, URLs, or environment-specific values.
- Keep logic out of presentational components where the project's pattern separates them.

### Phase 6 - Verify

Before saying "done":

1. **Run what the project provides:** typecheck, lint, build, and tests. Fix failures that you caused. Report failures that pre-existed instead of hiding them.
2. **Run the app and check the actual result** when possible: the feature works, no console errors or warnings, no failed network requests.
3. **Regression check (see "Avoiding fix-and-break loops").**
4. **Check the quality bars:** the UX, accessibility, responsive, and performance checklists below.
5. If you could not run or verify something, say exactly what was not verified.

---

## Avoiding fix-and-break loops

The agent's most damaging pattern: it fixes problem A, which causes problem B somewhere else, then "fixes" B in a way that brings back A. To avoid it:

1. **Find the root cause before changing code.** Reproduce the problem, read the error fully, trace it to its source. Do not patch symptoms or try random changes.
2. **Search for every usage** of the thing you are changing (components, props, hooks, types, CSS classes, functions) and check each one still works.
3. **Search for the same pattern elsewhere.** If a bug came from a pattern, other places probably have it too. Fix consistently or report them.
4. **Fix one thing at a time** and re-run verification after each fix, so you know which change caused which effect.
5. **Before applying a fix, write down in one line what it could break.** After applying it, confirm it did not.
6. **If a fix fails twice, stop.** Do not stack more patches. Re-read the code, question your assumption, and if still stuck, explain the situation and ask the user.
7. **Never "fix" an error by deleting the check, loosening types, disabling lint rules, skipping tests, or catching and swallowing exceptions.**
8. **Keep a before/after mental diff.** If a change touched more files than expected, re-evaluate why.

## Remembering mistakes: `agent_lessons.md`

Maintain a file `agent_lessons.md` in the project root (create it on first lesson). Every time any of these happens, add an entry **immediately**:

- You made a mistake that the user or a check caught.
- A fix broke something else.
- You used a wrong, outdated, or incompatible package/API.
- You misunderstood a project convention.
- The user corrected you or stated a preference.
- A tricky bug took more than two attempts.

Entry format (keep each short and actionable):

```md
## [YYYY-MM-DD] Short title
- **What happened:** (the mistake, factually)
- **Root cause:** (why it happened)
- **Rule going forward:** (a concrete rule that prevents it)
- **Where it applies:** (files / areas / situations)
```

Rules for the file:

- Read it at the start of every session and **before** touching related areas.
- Write rules, not stories. If an entry becomes obsolete, mark it as such rather than silently deleting it.
- Merge duplicates and keep it organized by topic when it grows (Dependencies, Styling, State, Routing, Performance, Project conventions, etc.).
- If a rule is clearly general (not project-specific), tell the user it could be added to this skill.

## Tracking progress: `project_progress.md`

For **large projects or multi-step work** (anything that will not finish in one short pass, spans many files, or may be continued by another session/agent), create and maintain `project_progress.md` in the project root.

Update it **after each meaningful step**, not only at the end. Template:

```md
# Project Progress

_Last updated: YYYY-MM-DD HH:MM_

## Project summary
(1-3 lines: what this is and the current goal)

## Tech stack & key decisions
- Framework/version, styling, state, data fetching, package manager
- Decisions made and why (so they are not re-debated)

## Done
- [x] Item - short note (files touched)

## In progress
- [ ] Item - exactly where it stopped and what remains in it

## Next steps (ordered)
1. ...
2. ...

## Open questions / blocked on user
- ...

## Known issues / tech debt
- ...

## How to run & verify
- Commands for dev / build / test / lint
```

Rules:

- Read it first when resuming. Trust it, but verify against the code if something looks inconsistent, and fix the file.
- Keep it accurate and short. It is a handoff document: someone with zero context must be able to continue from it.
- Never mark an item done unless it was verified.

---

## Design skills (always applied to UI work)

Respect the project's existing design system first. Only apply these when there is no established rule, and never override a defined design system without asking.

**Visual system**
- Use **design tokens** (CSS variables / theme config) for colors, spacing, radius, shadows, z-index, and typography. No magic numbers scattered in components.
- **Spacing:** use a consistent scale (e.g. 4/8px base). Group related elements closer than unrelated ones.
- **Typography:** limited type scale, clear hierarchy (one obvious primary heading per view), readable line length (~45-80 characters), line height ~1.4-1.7 for body text, sufficient size (body >= 16px on mobile).
- **Color:** a restrained palette with one clear primary action color; semantic colors for success/warning/error/info; never rely on color alone to convey meaning.
- **Contrast:** WCAG AA minimum (4.5:1 body text, 3:1 large text and UI components).
- **Alignment and grid:** consistent alignment and a consistent layout grid; avoid arbitrary offsets.
- **Dark mode / theming:** if supported, use tokens so both themes work; never hardcode colors.

**Layout and responsiveness**
- **Mobile-first.** Test at small (~360px), medium (~768px), large (~1280px+). No horizontal scroll, no overlapping or clipped content.
- Use flexible layout (flex/grid, `min()/max()/clamp()`, relative units) instead of fixed widths.
- Touch targets >= 44x44px with adequate spacing.
- Support **RTL** when the product has Arabic/Hebrew/etc.: use logical properties (`margin-inline-start`, `padding-inline`, `inset-inline`, `text-align: start`) instead of left/right, and mirror directional icons.
- Respect safe areas on mobile and long/short content in both languages.

**Components and interaction**
- Every interactive element has all states: default, hover, focus-visible, active, disabled, loading, error.
- Clear visual hierarchy of actions: one primary action per area.
- Immediate feedback for user actions (loading indicators, success/error messages, optimistic updates where safe).
- Prevent destructive mistakes: confirm or offer undo for destructive actions.
- Forms: visible labels (not placeholder-only), inline validation with specific helpful messages, preserve user input on error, correct input types and `autocomplete`, disable/guard against double submit.
- Motion: purposeful and subtle (~150-300ms), never blocks interaction, and **respects `prefers-reduced-motion`**.

**Accessibility (part of quality, not optional)**
- Use semantic HTML first (`button`, `nav`, `main`, `label`, headings in order); ARIA only when semantics are not enough.
- Everything usable by keyboard with a visible focus indicator and logical tab order; manage focus in modals/menus/route changes.
- Meaningful `alt` text for informative images (empty `alt` for decorative), labels for icon-only buttons, announced dynamic updates when needed (`aria-live`).
- Correct `lang` and `dir` attributes.

## Performance skills (always a priority)

**Principle: measure, then optimize. But never ship known-bad patterns.**

Targets (Core Web Vitals, good range): **LCP <= 2.5s, INP <= 200ms, CLS <= 0.1.**

- **Loading:** ship less JavaScript. Code-split by route and by heavy component, lazy-load below-the-fold and rarely used UI, use dynamic imports for heavy libraries. Check the bundle impact of every new dependency; prefer tree-shakeable and lightweight options.
- **Images/media:** correct dimensions and aspect ratio (prevents layout shift), modern formats (AVIF/WebP), responsive `srcset/sizes`, lazy-load offscreen images, prioritize the LCP image, compress, and use the framework's image component if the project has one. Avoid autoplaying heavy video.
- **Fonts:** limit families and weights, self-host or preload critical fonts, use `font-display: swap` (or optional), subset when possible.
- **Rendering:** avoid unnecessary re-renders and state placed higher than needed; derive instead of duplicating state; stable keys in lists; virtualize long lists; debounce/throttle expensive handlers; keep effects minimal and correctly cleaned up. Use memoization (`memo`, `useMemo`, `useCallback`, `computed`, etc.) only where measurement or clear reasoning shows a benefit - not everywhere.
- **Layout stability:** reserve space for async content (skeletons, fixed aspect ratios); never inject content above existing content after load.
- **Network:** avoid waterfalls (parallelize independent requests), cache and dedupe requests (use the project's data-fetching/caching layer), paginate or stream large data, prefetch likely next routes, handle failure and retries gracefully.
- **CSS:** avoid huge unused CSS, avoid layout-thrashing animations - animate `transform` and `opacity`, not `width/height/top/left`.
- **Server/framework features:** use the framework's built-in strengths (SSR/SSG/ISR/streaming/server components/islands) where appropriate for the project, and respect the client/server boundary.
- **Third-party scripts:** load async/deferred, minimize count, and question every one.
- **Verify** with Lighthouse / DevTools Performance / bundle analyzer when the change could affect performance, and report numbers instead of claims.

## UX priorities (when trade-offs appear, in this order)

1. **Correctness and data safety** - nothing breaks, nothing is lost.
2. **Clarity** - the user always knows where they are, what happened, and what to do next.
3. **Speed** - fast loads and instant-feeling interactions.
4. **Accessibility and inclusivity.**
5. **Consistency** with the rest of the product.
6. **Delight** - polish and animation, only after the above.

Always write helpful microcopy: error messages say what happened and how to fix it; empty states guide the next action; no raw technical errors shown to users.

## Security basics (frontend)

- Never expose secrets in client code or commit `.env` files.
- Avoid `dangerouslySetInnerHTML` / `v-html` / `innerHTML` with unsanitized content.
- Validate and sanitize user input; do not trust client-side validation alone.
- Keep auth tokens out of insecure storage when the project provides a safer pattern.
- Use `rel="noopener noreferrer"` on external `target="_blank"` links.

---

## Self-improvement loop (runs continuously while working)

After each task or meaningful step, run a quick retrospective:

1. **Observe:** what went well, what needed more than one attempt, what surprised me?
2. **Diagnose:** was it a gap in project knowledge, a wrong assumption, an outdated API, a missed side effect, or a skipped verification step?
3. **Record:** add a lesson to `agent_lessons.md` (rule + where it applies). Add project knowledge (conventions, gotchas, commands) to `project_progress.md` or the project's agent-instructions file if the user wants it there.
4. **Apply:** use the new rule immediately in the rest of the session, and re-read the lessons file before similar work.
5. **Raise:** if you notice a pattern that this skill itself does not cover, tell the user and propose a concrete addition to it. Do not silently edit this skill file unless the user asks.

Also improve by:
- Reading official docs and changelogs rather than guessing API behavior.
- Learning the project's patterns from its best existing code and matching them.
- Preferring checks you can run (tests, types, lint) over confidence.
- Reducing repeated mistakes by turning every correction from the user into a written rule.

---

## Demo Mode (interactive iPhone demo, built in React, fully automatic)

**Trigger.** The user gives a project path (Flutter, React Native, Expo, web, etc.) and asks for a *demo*, *preview*, *showcase*, "نسخة ديمو", or says they want to show/try the app. Also run it when the user simply says "do the demo" after a normal task.

**Goal.** From a project path alone, produce a folder `demo/` that is a **standalone React app** (Vite + React + TypeScript) showing the app's screens, rebuilt faithfully in React, inside an **iPhone frame** (Dynamic Island, status bar, side buttons, home indicator) plus a **side control panel** where the viewer can try everything the phone would normally receive or trigger: push notifications, deep links, lock screen, feature shortcuts, frame colour, zoom. The user must not have to explain the app: **you discover it**.

**Hard rule: the demo never runs the original app through Flutter Web, Dart-to-JS, or any other runtime of the original framework.** The original project is only *read* (as the source of truth for screens, colours, texts, assets, flows). The demo is a React rebuild that lives entirely inside `demo/`. Consequences: no `flutter build web`, no `DEMO_MODE` flags, no iframe, and **zero changes to the original app's files**.

Everything in "Ask, don't guess" still applies, but Demo Mode has sensible defaults, so only ask when something is truly blocking (e.g. no screens can be identified, or the project has no readable UI code). State assumptions in the final report instead of interrupting.

### D1 - Discover the app (read, do not guess)

Collect these from the code and write them into `project_progress.md` under "Demo":

| What | Where to look (Flutter first, then others) |
|---|---|
| Name, description, version | `pubspec.yaml`, `AndroidManifest.xml`, `Info.plist`, l10n files, `package.json` |
| Language / RTL | `supportedLocales`, `.arb` files, `Directionality`, `<html dir>` |
| Brand colours | `ThemeData`, `ColorScheme`, `colors.dart`, tailwind/theme tokens -> `accent`, `accent2` |
| Routes / screens | `go_router`, `auto_route`, `onGenerateRoute`, `routes:` maps, `Navigator.pushNamed`, router files |
| Notifications | packages: `firebase_messaging`, `flutter_local_notifications`, `awesome_notifications`, `onesignal_flutter`; handlers: `onMessage`, `onMessageOpenedApp`, `onDidReceiveNotificationResponse`; payload keys and the route they open |
| Notification texts | grep for `title:`/`body:` near `show(`, backend/Cloud Functions folders, l10n strings like "reminder", "confirmed", "offer" |
| Special features | camera/QR (`mobile_scanner`), biometrics (`local_auth`), maps/location, payments, share, in-app purchases, deep links |
| Data source | repositories/services, Firebase/REST calls (needed to decide how to fake data in D3) |

Every notification entry in the demo must correspond to something the app really does. If the app has **no** notifications, derive 3 realistic ones from its core flows (booking confirmed, order shipped, new offer, ...) and label them clearly as demo examples in the report.

**Screen inventory (required output of D1).** List every screen the demo will contain, in priority order: the home/entry screen first, then the screens reachable from the main flows and from each notification route. For each one record: route name, source file, main widgets/components, texts (from l10n), assets used, and which interactions matter (tabs, buttons, forms, sheets, scanning, etc.). Cover the core flows fully rather than every obscure screen; list what was left out in the report.

### D2 - Strategy: rebuild in React (single strategy)

1. **Scaffold** `demo/` as a Vite + React + TypeScript project. Follow Phase 3: check `node --version`, then `npm view react version`, `npm view vite version peerDependencies engines`, and use the latest stable, mutually compatible versions. Dependencies: only `react`, `react-dom`, and the Vite/TS tooling. **No router library, no UI kit, no CDN scripts**: navigation is a small in-memory stack (see D4). Add another package only if it is truly needed and report it.
2. **If the source project is already a React/Next web app**, reuse its real components inside the demo wherever they run without a backend (import or copy them, keeping imports of the original unmodified) and replace only data/auth/network with in-memory fakes. Everything else follows the same rules below.
3. **Otherwise (Flutter, React Native, native, other)**: rebuild each screen from the D1 inventory as React components, reading the original widget/component tree as the specification. Copy exact values: colours, font sizes/weights, paddings, radii, shadows, icon choices, strings, element order. Do not "improve" the design.

Flutter widget -> React/CSS mapping (use as a starting point, not as a substitute for reading the code):

| Flutter | React / CSS |
|---|---|
| `Scaffold` / `AppBar` / `BottomNavigationBar` | screen `<div>` with header, scrollable `<main>`, bottom `<nav>` |
| `Column` / `Row` / `Wrap` | `display:flex` (`column` / `row` / `flex-wrap`) with `gap` |
| `Expanded` / `Flexible` / `Spacer` | `flex: 1` / `flex: 0 1 auto` / `margin-inline-start:auto` |
| `Stack` + `Positioned` | `position:relative` parent, `position:absolute` children (use `inset-inline-*`) |
| `Container` / `BoxDecoration` / `Card` | `div` with `background`, `border-radius`, `box-shadow`, `border` |
| `Padding` / `SizedBox` / `Center` | `padding` / fixed `width`/`height` or `gap` / flex centering |
| `ListView` / `GridView` | scroll container (`overflow-y:auto`) / CSS grid |
| `Text` + `TextStyle` | element with `font-size`, `font-weight`, `line-height`, `color` as tokens |
| `Icon` / `Image.asset` | inline SVG or local asset (webp/svg) |
| `showModalBottomSheet` / `showDialog` | sheet/dialog component with focus management |
| `TextField` / `Form` | `<input>` with visible `<label>`, validation, correct `type` |
| `ThemeData` / `ColorScheme` | CSS variables on `:root` (design tokens) |
| `Directionality` / `EdgeInsetsDirectional` | `dir` attribute and logical CSS properties |

Fidelity process: build one screen, run it, compare it against the original (store screenshots, docs, or design files in the repo if any; otherwise re-read the widget tree and re-check numbers), fix differences, then move on. If the original screens cannot be verified visually, say so in the report.

### D3 - Data: realistic, in-memory, offline

- Put all fake data in `demo/src/app/data/` as typed modules, in the app's own language (names, prices, dates, statuses). Derive shapes from the original models/repositories found in D1 so the screens receive the same fields.
- Auth: the demo opens already logged in as a sample user, on the home screen.
- State: a small store (React context + `useReducer`) so interactions actually work (add to cart, mark as read, book a slot, toggle favourites), resetting on reload.
- Images: local assets copied from the original project (optimised) or inline SVG/data URIs. Never hot-link. If a needed image is missing, use a neutral placeholder tied to the brand colours and mention it in the report.
- Features that need native hardware or a backend (camera/QR, biometrics, maps, payments, share) are **simulated**: a believable sheet/screen with sample results, labelled as simulated in the report.

### D4 - Architecture and the "bridge" (React context, no postMessage)

Suggested layout:

```
demo/
  package.json  vite.config.ts  (base: './')  index.html  README.md  serve.sh
  src/
    main.tsx
    demo.config.ts          # DEMO_CONFIG: the only file edited for most changes
    shell/                  # PhoneFrame, StatusBar, DynamicIsland, LockScreen,
                            # NotificationBanner, ControlPanel, FeatureChips
    bridge/DemoContext.tsx  # navigation stack, notifications, lock state, actions
    app/                    # screens/, components/, data/, assets/, theme.css
```

`DEMO_CONFIG` contains: app name/icon/description, `accent`/`accent2`, `lang`/`dir`, the `notifications` found in D1 (each with the `route` it opens), `features` chips (screens and special actions found in D1), `statusBar` style ("dark" for light apps), default frame colour.

`DemoContext` is the single bridge between the shell and the app. It exposes:

- `navigate(route)` / `back()` / `currentRoute` : in-memory stack. Unknown routes must fail softly (stay on the current screen and show a small "route not available in demo" hint), never crash.
- `notify({ title, body, route })` : shows the banner, appends to the lock-screen list, **and** adds it to the app's own in-app notifications list and bell badge exactly like the production push handler would, so the counter and the banner always agree.
- `runAction(name, data)` : opens the simulated special features (QR sheet, etc.).
- `lock()` / `unlock()` : lock screen shows pending notifications; tapping one unlocks and opens its route.

Required details:

- **Safe areas:** the frame is a fixed logical size (390x844). The shell draws status bar and Dynamic Island over the app, and sets CSS variables `--safe-top: 54px` and `--safe-bottom: 34px` which every screen's header/bottom bar must use as padding. Content must never sit under the island or the home indicator.
- **Zoom/fit:** scale the frame with `transform: scale()` driven by the zoom control and by available viewport height; do not change the logical size.
- **Text safety:** React escapes by default. Never use `dangerouslySetInnerHTML` or inject HTML from config or messages.
- **Accessibility inside the frame:** screens use semantic elements and visible focus; banners use `role="status"`/`aria-live`.

### D5 - Run it and look at it (never claim "done" without this)

1. Install cleanly, then run `npm run typecheck` (or `tsc --noEmit`), `npm run lint` if configured, and `npm run build`. Fix what you caused; report what you could not fix.
2. Serve the production build over HTTP (`npm run preview` or `cd demo/dist && python3 -m http.server 8080`). Add a one-line `demo/serve.sh` and a short `demo/README.md` (how to run, how to build, how to host: Firebase Hosting / GitHub Pages / Netlify, and that `dist/` is static).
3. Open it in a headless browser (Playwright) at **1440x900** and **390x844**. Take screenshots and check:
   - the app screens render inside the frame, no console errors, no failed requests;
   - each notification button shows an iOS-style banner, and tapping the banner opens the right screen;
   - the in-app notification list and bell badge match the banners;
   - lock screen shows the notifications and unlocks on tap;
   - every feature chip does something visible; frame colours and zoom work;
   - the main flows from D1 can be completed by clicking through them;
   - RTL/LTR correct, no text under the Dynamic Island, no horizontal scroll on mobile widths, banners readable with long text.
4. Fix what you find (one fix at a time, re-test), then record mistakes in `agent_lessons.md`.

### D6 - Demo quality bar

- Looks like the product, not like a template: accent colours, app icon/emoji, copy and language come from the app.
- Works offline after load: no CDN scripts; fonts fall back to system fonts if the app's fonts are not bundled (bundle them locally if the licence allows).
- Fast: code-split nothing unnecessary, optimise images, keep the bundle small, report the build size.
- Motion is subtle (animate `transform`/`opacity`) and respects `prefers-reduced-motion`; all panel controls are real `<button>`s with labels and visible focus.
- The side panel is usable on mobile (it stacks under the phone).

### Demo Mode - extra rules for lessons

If the user later says "add a feature to the panel / change a notification / new frame / add a screen", change `demo.config.ts` or the relevant `app/` module first; touch the shell components only for genuinely new behaviour, and then mention the improvement in the report so it can be folded back into this skill.

---

## Final checklist (run before reporting completion)

- [ ] I read `project_progress.md` / `agent_lessons.md` / project docs at the start.
- [ ] I understood the project's structure and reused existing code and patterns.
- [ ] I asked about everything unclear instead of guessing, and stated any assumptions.
- [ ] Dependencies are current, compatible, minimal, and I reported all changes.
- [ ] The change is small, focused, and consistent with conventions.
- [ ] All UI states are handled (loading / empty / error / success).
- [ ] Responsive, keyboard accessible, sufficient contrast, RTL/LTR correct where relevant.
- [ ] No obvious performance regressions (bundle, images, re-renders, layout shift, requests).
- [ ] Typecheck, lint, build, and tests pass (or failures are explained honestly).
- [ ] I searched for other usages and confirmed nothing else broke.
- [ ] `agent_lessons.md` updated with any new mistake/lesson.
- [ ] `project_progress.md` updated (for large projects).
- [ ] Demo Mode only: `demo/` is a React (Vite) project that builds and runs over HTTP, the rebuilt screens show inside the iPhone frame, no Flutter Web / original-framework runtime is used, every notification/feature in the panel was clicked and verified with screenshots, and the original app's files are untouched.

## Final report format

End every task with a short, honest summary:

1. **What I did** (and which files changed).
2. **Dependency changes** (old -> new, why), if any.
3. **How I verified it** (commands run, what I checked in the browser) and what I could **not** verify.
4. **Assumptions made / questions still open.**
5. **Recommended next step**, if any.
6. **Demo Mode only:** where the demo lives, the exact commands to run and build it, which screens were rebuilt (and which were left out), how faithful the rebuild is and how that was checked, which features are simulated, which notifications/features were found in the code vs. invented as examples, dependency versions used, and confirmation that no original app files were changed.

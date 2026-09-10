# YOUNG VIP — Complete Navigation, Workflow & Implementation Map

**Product:** The technology lab for legal professionals  
**Navigation model:** Discover | Labs | Rooms | Builds | Fluency  
**Authoritative product source:** `Young_VIP_Product_Specification.md`  
**Purpose:** Document the navigation currently implemented in the Flutter codebase, every important destination and control, controls that only change the current screen, inert or misleading controls, and the specification-aligned navigation that the app is intended to represent.

---

## 1. How to read this document

The codebase uses Flutter's imperative `Navigator` with anonymous `MaterialPageRoute` objects. It does not use named routes or a central route registry.

| Term | Meaning |
|---|---|
| **Navigates** | Pushes, replaces, or switches to another screen. |
| **Tab switch** | Changes one of the five screens inside `MainNavigationView`; it does not create a new route. |
| **In-place action** | Changes state on the current screen, such as a selected filter, toggle, tab, flag, bookmark, or checklist item. |
| **Feedback only** | Shows a snackbar/dialog without completing the underlying product operation. |
| **Inert** | Looks interactive but has no effective handler or has an empty handler. |
| **Demo behavior** | Uses static/sample data or simulated success rather than a real backend, payment, authentication, or persistence flow. |
| **Specification target** | Behavior required or implied by `Young_VIP_Product_Specification.md`, whether or not the current code implements it. |

The current implementation is a visual/demo prototype. It contains many complete-looking screens, but navigation, permissions, persistence, authentication, payments, and backend operations are not yet equivalent to the Product Specification.

---

## 2. Application startup and first-open workflow

### 2.1 Actual application entry

The app always starts at `HomepageView`:

```text
Flutter main()
→ MyApp
→ MaterialApp
→ HomepageView
```

There is currently no startup authentication guard, saved-session check, email-verification check, subscription-entitlement check, or onboarding-progress resolver.

### 2.2 Actual first screen

The first screen is the public-style homepage. It contains:

- Menu icon opening the shared drawer.
- Enter App.
- Start Free.
- Browse Labs.
- Interactive track/category cards.
- A second Start Free call-to-action near the bottom.
- Static marketing metrics, value propositions, workflow explanation, and testimonial-style content.

### 2.3 Homepage controls

| Control | Current result |
|---|---|
| Menu | Opens `CustomDrawer`; the same internal drawer is available on the public homepage. |
| **Enter App** | Replaces the homepage with `MainNavigationView(initialIndex: 0)`, opening Discover. No login/account check occurs. |
| **Start Free** in hero | Pushes `CreateAccountView`. |
| **Browse Labs** | Replaces the homepage with `MainNavigationView(initialIndex: 1)`, opening Labs. No account/entitlement check occurs. |
| Track/category cards | Replace the homepage with `MainNavigationView(initialIndex: 1)`, opening Labs. The selected category is not passed into Labs. |
| Bottom Start Free CTA | Pushes `CreateAccountView`. |
| Static metrics and explanatory cards | No navigation. |

### 2.4 Intended first-time product workflow

According to the Product Specification:

```text
Public Homepage
→ Start Free
→ Create Account
→ Verify Email
→ Profile Setup
→ Technology Interests
→ Fluency Assessment
→ Assessment Result
→ Discover
```

The current app has these screens, but does not enforce this sequence because users can enter the main app directly through Enter App, Browse Labs, the public drawer, or the fake Sign In link.

---

## 3. Global navigation architecture

### 3.1 `MainNavigationView`

`MainNavigationView` owns five child views in a state-preserving `IndexedStack`:

```text
Index 0 → DiscoverView
Index 1 → LabsView
Index 2 → LabRoomView
Index 3 → MyBuildsView
Index 4 → MyFluencyView
```

| Index | Label | Screen | Intended purpose |
|---:|---|---|---|
| 0 | Discover | `DiscoverView` | Technology discovery, current Lab, recommendations, relevant Room activity. |
| 1 | Labs | `LabsView` | Lab library, categories, active Labs, Lab details. |
| 2 | Rooms | `LabRoomView` | Contextual Lab Room activity. |
| 3 | Builds | `MyBuildsView` | Completed work and evidence. |
| 4 | Fluency | `MyFluencyView` | Fluency map, domains, assessment result, credentials. |

### 3.2 Bottom navigation behavior

The bottom navigation contains exactly:

```text
Discover | Labs | Rooms | Builds | Fluency
```

Behavior:

- Tapping another item changes the indexed-stack index.
- Tapping the current item gives haptic feedback but does not reload it.
- The Labs icon shows a red notification dot, but the code does not define its meaning or clear it.
- System back on Labs, Rooms, Builds, or Fluency switches to Discover.
- System back on Discover can exit/pop the main shell.
- The main shell owns the shared bottom bar; its root child screens do not render another bar.

### 3.3 Directly pushed tab screens

The tab screens have an optional `isRootTab` flag. When pushed independently with `isRootTab: false`, they may render their own bottom navigation bar. Therefore the code has two modes:

```text
MainNavigationView
→ shared bottom navigation
→ indexed child screen
```

and:

```text
Another screen
→ Navigator.push(child screen)
→ child screen may render a second standalone bottom navigation
```

This is a major source of navigation complexity.

### 3.4 `TabNavigationService`

```text
switchToTab(context, index)
→ pop every pushed route until the first route
→ call MainNavigationView's tab callback
→ change the active tab
```

Consequences:

- Switching tabs from a pushed detail/profile/Lab screen removes that screen first.
- Switching tabs from the main shell returns to the shell and changes its index.
- Switching tabs from the public homepage has no effect because no tab callback exists yet. The drawer closes, but the homepage stays visible.
- The shared drawer therefore behaves differently on the homepage and inside the main shell.

---

## 4. Shared drawer navigation

`CustomDrawer` is used by the homepage, onboarding, Lab screens, stage screens, account screens, community screens, and internal screens.

### 4.1 Core Platform

| Drawer item | Current behavior |
|---|---|
| Discover | Closes drawer and calls tab index 0; works only when a main-shell callback exists. |
| Labs | Closes drawer and calls tab index 1; same limitation. |
| Rooms | Closes drawer and calls tab index 2; same limitation. |
| Builds | Closes drawer and calls tab index 3; same limitation. |
| Fluency | Closes drawer and calls tab index 4; same limitation. |

The current drawer subtitles use prototype terms such as “trends,” “active sprint,” “weekly sprint,” and “configured labs,” which do not consistently match the Product Specification's Lab, Room, Builds, and Fluency terminology.

### 4.2 Admin & Governance

The drawer currently exposes these to every user, including public homepage visitors:

| Drawer item | Destination |
|---|---|
| Review Experts | `ReviewExpertsView` |
| Expert Studio | `ExpertStudioView` |

This is not permission-gated in the current UI. The Product Specification requires Admin to use a separate web portal and Expert Studio to be visible only to approved Build Experts. Permissions must also be enforced server-side.

### 4.3 Lab Workflow

The drawer exposes:

| Drawer item | Destination |
|---|---|
| Build It | `BuildItView` |
| Break It | `BreakItView` |
| Understand It | `UnderstandItView` |
| Advise Better | `AdviseBetterView` |
| Contextual Connection | `ContextualConnectionView` |
| Lab Complete | `LabCompleteView` |

The section label says “5 STAGES,” but the Product Specification defines four learning stages. Contextual Connection is a community/connection step, not a fifth learning stage, and Lab Complete is a completion destination.

Target structure:

```text
One Lab Player
├── Build It
├── Break It
├── Understand It
└── Advise Better
→ Lab Complete
→ Contextual Lab Room / Connections
```

The current drawer lets users jump directly into any stage without a selected Lab or entitlement.

### 4.4 Membership & Access

| Drawer item | Current destination |
|---|---|
| All-Access Pricing | `AllAccessPricingView` |
| Premium Locked Gate | `PremiumLockedGateView` |
| VIP Pass | `PremiumLabView` |

The Product Specification defines Free access, All Access Monthly, and All Access Annual. “VIP Pass,” “Builder Pass,” “credit pass,” XP, and similar labels are prototype language, not separate launch products or membership tiers.

### 4.5 Account

| Drawer item | Destination |
|---|---|
| Profile | `ProfileView` |
| Edit Profile | `EditProfileView` |
| User profile card | `ProfileView` |
| Close | Closes the drawer |

The Product Specification also requires Messages, Notifications, Subscription, Privacy, and Settings. These are not currently complete drawer destinations; pricing exists, but real Subscription/Billing management does not.

### 4.6 Public homepage drawer issue

Because the public homepage uses the same drawer, a logged-out visitor can open Review Experts, Expert Studio, every Lab stage, Lab Complete, premium screens, Profile, and Edit Profile. This contradicts the intended public/onboarding flow and is particularly confusing for a non-technical user.

---

## 5. Public and onboarding flows

### 5.1 Create Account

```text
Homepage → Start Free → CreateAccountView
```

The screen contains name, email, password, confirm password, profession/role chips, Terms acceptance, password visibility controls, Create Free Account, Sign In, back, and menu.

Behavior:

- Role chips change local selection.
- Password eye buttons change local visibility.
- Validation blocks invalid form data.
- Missing Terms acceptance shows a snackbar and stays on the page.
- Valid submission replaces the screen with `VerifyEmailView`.
- **Sign In** replaces the screen with `MainNavigationView` without authentication or a login form; it is a demo bypass.

Build Expert is not a signup role, which agrees with the Product Specification, but the account data is not connected to a persisted identity system.

### 5.2 Verify Email

```text
CreateAccountView → VerifyEmailView → ProfileSetupView
```

The screen contains six OTP fields, Paste Demo Code, verification, Resend Confirmation Code, Change Email dialog, support/help, back, and drawer.

Behavior:

- Completing the final digit can trigger verification automatically.
- If the code is incomplete, verification fills `849201` before checking; this is demo behavior.
- Successful verification replaces the screen with Profile Setup.
- Resend clears fields and shows a snackbar.
- Change Email opens a dialog.
- Continue to Profile Setup replaces the screen with Profile Setup.
- Help shows support text in a snackbar.
- Back pops the prior route, or falls back to the main app if no route can be popped.

### 5.3 Profile Setup

```text
Verify Email → Profile Setup → Interests
```

The screen collects name, professional role, organization, experience level, and domain/specialization selections.

- Continue validates and replaces the screen with Interests.
- Skip also replaces the screen with Interests.
- Selectors change local state.
- Back behavior depends on the route stack.

### 5.4 Interests

```text
Profile Setup → Interests → Fluency Assessment
```

Controls include presets, search, clear-search, category chips, topic cards, selected-interest state, complete, and skip.

- Presets apply selections in place.
- Search filters the visible topics.
- Clear removes the search query.
- Category chips change the filter.
- Topic cards toggle selection.
- Complete requires the view model's minimum selection rule and then replaces the screen with Fluency Assessment.
- Skip also proceeds to Fluency Assessment and shows skip feedback.

### 5.5 Fluency Assessment

```text
Interests → FluencyAssessmentView → AssessmentResultView
```

Controls include menu, answer options, flag current question, numbered question navigation, previous, next, submit/complete, and skip.

- Answer selection changes the current question state.
- Flag toggles the current question.
- Question numbers navigate in place.
- Previous/Next changes the current question in place.
- Completion opens a non-dismissible celebration dialog.
- View Results closes the dialog and replaces the screen with Assessment Result.
- Skip also replaces the screen with Assessment Result.

The current assessment is static/demo data and does not define production scoring, versioning, retakes, or domain weighting.

### 5.6 Assessment Result

Current controls:

| Control | Behavior |
|---|---|
| Back | Pops the current route. |
| Drawer | Opens `CustomDrawer`. |
| Result tabs | Change the active section in place. |
| Copy/share-style result control | Shows snackbar feedback; no real share/export contract. |
| Continue to Discover | Clears the current stack and opens `MainNavigationView(initialIndex: 0)`. |
| Add to Profile | Toggles local saved-credential state and shows snackbar feedback. |
| View Profile | Pushes `ProfileView`. |
| Launch Recommended Lab | Pushes `BuildItView`, bypassing Lab Detail and the normal Lab Player entry. |
| Retake Assessment | Replaces the screen with `FluencyAssessmentView`. |

---

## 6. Discover tab

`DiscoverView` is tab index 0.

| Area/control | Current behavior |
|---|---|
| Menu | Opens drawer. |
| Notification icon | Opens a sample notification bottom sheet with a close action. |
| Avatar | Opens the drawer, not Profile. |
| Search field | Accepts text locally. |
| Search button | Dismisses keyboard and switches to Labs; the query is not passed and there is no results route. |
| Continue Lab | Pushes `BreakItView` for a fixed sample Lab. |
| Continue Lab “All activity” | Switches to Labs. |
| Recommended Labs “View all” | Switches to Labs. |
| Featured Lab stage rows | Push individual stage screens. |
| Free Lab row | Pushes `BuildItView`. |
| Premium Lab row | Pushes `PremiumLockedGateView`. |
| Category cards | Switch to Labs; selected category is not passed. |
| Participant/Room links | Push `LabRoomView`. |
| Connect controls | Toggle local/demo connection state; no persisted request. |
| Recent Room activity | Pushes `LabRoomView`. |
| Recent Builds header | Expands/collapses content in place. |
| Profile/edit CTA where present | Pushes `EditProfileView`. |

The intended specification flow is:

```text
Discover → Recommended Lab → Lab Detail → Start/Continue → Lab Player
```

The current implementation often goes directly to Build It, Break It, or the paywall, without preserving Lab identity or progress.

---

## 7. Labs tab

`LabsView` is tab index 1.

The current screen contains menu, notification icon, search icon, calendar strip, “Interactive Labs,” “Active Sprint,” domain cards, a carousel arrow, active Lab tracks, and Enter Active Lab.

| Control | Current behavior |
|---|---|
| Menu | Opens drawer. |
| Notification icon | Visual only; no tap handler. |
| Search icon | Visual only; no tap handler. |
| Calendar days | Select a day in place; sample Lab data does not change. |
| Domain/category cards | No tap handler; visual only. |
| Carousel arrow | Scrolls the horizontal domain-card list in place. |
| Active Lab Track row | Pushes `LabDetailView`; selected Lab identity is not passed. |
| Enter Active Lab | Pushes `LabDetailView`. |

Intended:

```text
Labs → Library → Category/Search → Lab Detail → Start/Continue → Lab Player
```

The current Labs screen is a static active-sprint dashboard rather than a complete searchable Lab library.

---

## 8. Lab Detail

Current route:

```text
Labs → LabDetailView
```

Controls:

- Back: pops.
- Menu: opens drawer.
- Start This Lab: pushes `BreakItView` directly.

The current action does not start Build It, does not carry a selected Lab identity, and does not enforce premium entitlement. The specification-aligned page must show title, technology/category, difficulty, duration, free/premium status, description, outcomes, four stages, actual block types, Start/Continue, participant count, Room teaser, Build Expert attribution, and optional bookmark.

---

## 9. Premium and subscription flows

### 9.1 Current premium flow

```text
Discover
→ Premium Lab row
→ PremiumLockedGateView
→ Annual/Monthly selection
→ Unlock
→ Simulated delay
→ Activation dialog
→ Launch Lab Sandbox Now
→ BuildItView
```

The unlock action does not process a payment, create a subscription, or enforce an entitlement.

### 9.2 Premium Locked Gate controls

- Back when pushed; otherwise menu.
- Annual plan selector: local state.
- Monthly plan selector: local state.
- Unlock: simulated success dialog, then `BuildItView`.
- Explore Free Community Content Instead: pops the gate.
- Drawer: opens shared drawer.

### 9.3 All Access Pricing controls

```text
Drawer → AllAccessPricingView
```

- Back: pops or returns to Discover.
- Annual/monthly toggle: local state.
- Plan cards: local state.
- Subscribe: simulated delay, success dialog, then clears the stack and opens Discover.

Target behavior:

```text
Premium Lab
→ Locked Gate
→ All Access Pricing
→ Secure Payment
→ Entitlement Granted
→ Lab Unlocked
→ Lab Player
```

The current code does not implement secure payment, cancellation, expiry, failed payment, restoration, or server-side entitlement checks.

### 9.4 VIP Pass / Premium Lab

The drawer's VIP Pass opens `PremiumLabView`, a separate prototype membership screen. It is not a canonical Product Specification destination or a separate launch product.

---

## 10. Lab Player and stage navigation

The Product Specification defines one Lab Player with four persistent stages. The current code implements separate screens that push each other:

```text
BuildItView
→ BreakItView
→ UnderstandItView
→ AdviseBetterView
→ ContextualConnectionView
→ LabCompleteView
```

### 10.1 Build It

- Back: pops.
- Menu: opens drawer.
- Stage/Break It item: pushes `BreakItView`.
- Technical toggles: local state.
- Code tabs: switch in place.
- Action buttons: local completion state plus snackbar.
- Continue/next: pushes `BreakItView`.

The screen is a specific technical demo rather than a renderer for configurable Lab content blocks.

### 10.2 Break It

- Back: pops.
- Menu: opens drawer.
- Break-test controls: local demo state.
- Continue/next: pushes `UnderstandItView`.

### 10.3 Understand It

- Back: pops.
- Menu: opens drawer.
- Stage navigator: Build It → `BuildItView`; Break It → `BreakItView`; Advise Better → `AdviseBetterView`.
- Inspector tabs: switch in place.
- Understanding/action buttons: local completion plus snackbar.

### 10.4 Advise Better

- Back: pops.
- Menu: opens drawer.
- Stage navigator: Build It, Break It, Understand It routes.
- Deliverables tabs: switch in place.
- Approval/action buttons: local state plus snackbar.
- Governance checklist rows: toggle local checked state.
- Next: Contextual Connection → `ContextualConnectionView`.
- Skip directly to Lab Complete → `LabCompleteView`.

Contextual Connection is not a fifth learning stage in the Product Specification.

### 10.5 Contextual Connection

- Back: returns to Advise Better when possible.
- Menu: opens drawer.
- Local tabs/sections: switch in place.
- Network/connection nodes: local bookmark/toggle state.
- Completion: pushes `LabCompleteView`.

This prototype visualization is not the required “Who Else Is Building This?” participant view.

### 10.6 Lab Complete

- Back: pops.
- Menu: opens drawer.
- Copy completion link: snackbar feedback.
- Save/add credential: local toggle plus snackbar.
- Explore More Labs: pops and switches to tab index 1, Labs.
- My Builds action: currently also switches to tab index 1, Labs; it does not open Builds index 3.
- View Profile: pushes `ProfileView`.

---

## 11. Rooms and contextual community

### 11.1 Rooms tab

`LabRoomView` is tab index 2. It currently shows one static/sample Room, not a list of the member's accessible Lab Rooms.

### 11.2 Current Room controls

| Control | Current behavior |
|---|---|
| Menu | Opens drawer. |
| Notification icon | Visual only; no handler. |
| Avatar | Visual only; no handler. |
| Weekly calendar days | Changes selected day in place; posts do not change. |
| Post author/avatar | Not a participant-profile route. |
| Like chip | Empty callback; no state change. |
| Reply/comment chip | Empty callback; no reply/discussion route. |
| Bookmark icon | Static; no handler. |
| Post Observation | Visual container; no handler. |

The Product Specification requires Questions, Failures, Insights, Observations, comments, replies, reactions, mentions, and discussion prompts. The current Room is primarily static display data.

### 11.3 Target Room flow

```text
Rooms
→ My Active Lab Rooms
→ Selected Lab Room
→ Question / Failure / Insight / Observation
→ Post detail
→ Comments / Replies / Reactions / Mentions
```

```text
Lab Room
→ Who Else Is Building This?
→ Participant Profile
→ Connect
→ Request Sent
→ Accepted / Connected
→ Messages
```

“Peers” is not a bottom-navigation item in the target product.

---

## 12. Who Else Is Building This? and Peers

`PeersView` exists in the repository, but is not a bottom-tab child and is not in the shared drawer.

Current controls:

- Menu opens drawer.
- Profile opens `ProfileView`.
- Connect opens `MessagesView` directly.

This bypasses the required connection state machine:

```text
Connect → Request Sent → Accepted → Connected → Messages
```

The current Connect action is a demo shortcut, not implemented private-messaging authorization.

---

## 13. Messages

`MessagesView` exists, but is not a primary bottom-tab destination and is not listed in the shared drawer.

Current entry path:

```text
PeersView → Connect → MessagesView
```

The screen contains a local search field, online-peer strip, conversation list, New Chat pill, menu, notification icon, and avatar.

Current issues:

- Notification icon is visual only.
- Avatar is visual only.
- New Chat has no demonstrated accepted-connection permission flow.
- Message threads are sample data.
- There is no clear individual conversation-detail route.
- Backend authorization is absent.

Target behavior is text messages, timestamps, unread indicators, mute, block, report, and remove connection only after an accepted connection. Unrestricted message-anyone behavior is not part of MVP.

---

## 14. Builds and Profile

### 14.1 Builds tab

`MyBuildsView` is index 3.

- Menu opens drawer.
- Notification and avatar are visual only.
- Filter pills change the selected filter in place.
- Build cards are display-only and do not open evidence/detail screens.
- Create New Build is a visual container with no tap handler.

Target Build evidence includes Lab name, technology, date, reflection, uploaded evidence, result/score, completed activities, failure scenarios, and Advise Better outcome. Requirements must be configurable by Lab.

### 14.2 Profile

`ProfileView` contains:

- Menu.
- Visual-only notification and search icons.
- Edit button → `EditProfileView`.
- Recent Builds expand/collapse in place.
- Edit Profile CTA → `EditProfileView`.
- View All Builds & Certs → `MyBuildsView`.

The current profile is a static identity/credential dashboard. The target profile should emphasize Technology Fluency and evidence rather than resemble a LinkedIn resume.

### 14.3 Edit Profile

- Back: pops.
- Menu: opens drawer.
- Editable fields.
- Save: snackbar then pop.
- Visibility/preferences toggles: local state.

The specification requires profile visibility, Lab-participation visibility, participant visibility, connection visibility, messaging permissions, notifications, data deletion, and account deletion. The current screen only partially represents these.

---

## 15. Fluency tab

`MyFluencyView` is index 4.

- Menu opens drawer.
- Notification and avatar are visual only.
- View Benchmark Assessment Result pushes `AssessmentResultView`.
- Fluency domain cards are display-only.
- Credential cards are largely display-only.

Target structure:

```text
Fluency → My Fluency → Fluency Map → Domain → Assessment → Result
```

Initial domains are AI Systems, AI Agents, Automation, Data Systems, Privacy & Data Flows, Cybersecurity, Responsible Technology, AI Governance, and Algorithmic Decision-Making. Admin must be able to add/edit domains.

---

## 16. Build Expert navigation

### 16.1 Current access

The shared drawer exposes `ExpertStudioView` directly to all users. There is no visible Build Expert application route in the drawer.

### 16.2 Current Expert Studio

The screen contains a creator profile card, Scenario Editor, Stress-Test Suite, Builder Analytics, Peer Reviews, authored Labs, Edit controls, and a primary action pill.

Most creator tool tiles, authored Lab Edit controls, and the bottom action pill are visual containers without implemented navigation handlers.

### 16.3 Target flow

```text
Profile / Settings / public Teach page
→ Apply to Become a Build Expert
→ Application
→ Submitted
→ Under Review
→ More Information Requested
→ Approved / Rejected
```

```text
Approved
→ Build Expert Studio
→ Propose Lab
→ Proposal Review
→ Lab Builder
→ Preview
→ Submit for Review
→ Quality Review
→ Changes Requested / Resubmit
→ Approved
→ Admin Publishes
→ Published Lab
```

Build Experts may create, edit, preview, and submit; they cannot publish. Only Admin publishes.

---

## 17. Admin navigation

### 17.1 Current implementation

The drawer opens `ReviewExpertsView`.

- Review Experts search and status filters change local state.
- Review actions update local/sample state and show feedback.

### 17.2 Target Admin Web Portal

Admin must be separate from member navigation and include Members, subscriptions/access, Build Expert applications/review, Lab proposals/drafts/revisions/review/publishing, categories/technologies, Fluency domains, Badges, Pricing, Payments, Notifications, Featured Labs, Free Lab designation, Lab Rooms, Reports, and Moderation.

Sensitive role, pricing, publishing, payment, moderation, and entitlement actions require server-side authorization and audit logging.

---

## 18. Complete current route map

```text
main()
└── HomepageView
    ├── Enter App → MainNavigationView(Discover)
    ├── Browse Labs → MainNavigationView(Labs)
    ├── Start Free → CreateAccountView
    │   └── VerifyEmailView
    │       └── ProfileSetupView
    │           └── InterestsView
    │               └── FluencyAssessmentView
    │                   └── AssessmentResultView
    │                       ├── MainNavigationView(Discover)
    │                       ├── ProfileView
    │                       ├── BuildItView
    │                       └── FluencyAssessmentView
    └── Shared CustomDrawer
        ├── MainNavigationView tabs
        ├── ReviewExpertsView
        ├── ExpertStudioView
        ├── BuildItView
        ├── BreakItView
        ├── UnderstandItView
        ├── AdviseBetterView
        ├── ContextualConnectionView
        ├── LabCompleteView
        ├── AllAccessPricingView
        ├── PremiumLockedGateView
        ├── PremiumLabView
        ├── ProfileView
        └── EditProfileView
```

Main shell:

```text
MainNavigationView
├── DiscoverView
│   ├── BuildItView / BreakItView / UnderstandItView / AdviseBetterView
│   ├── PremiumLockedGateView
│   └── LabRoomView
├── LabsView
│   └── LabDetailView
│       └── BreakItView
├── LabRoomView
├── MyBuildsView
└── MyFluencyView
    └── AssessmentResultView
```

Stage chain:

```text
BuildItView → BreakItView → UnderstandItView → AdviseBetterView
→ ContextualConnectionView → LabCompleteView
```

Other routes:

```text
PeersView → ProfileView / MessagesView
ProfileView → EditProfileView / MyBuildsView
```

---

## 19. Controls that currently do not work or do not complete their apparent action

### 19.1 Inert or empty controls

- Lab Room like button: empty callback.
- Lab Room reply/comment button: empty callback.
- Lab Room bookmark icon: no handler.
- Lab Room Post Observation pill: no handler.
- My Builds Create New Build pill: no handler.
- Labs notification icon: no handler.
- Labs search icon: no handler.
- Rooms notification icon: no handler.
- Rooms avatar: no handler.
- My Builds notification icon: no handler.
- My Builds avatar: no handler.
- My Fluency notification icon: no handler.
- My Fluency avatar: no handler.
- Profile notification icon: no handler.
- Profile search icon: no handler.
- Messages notification icon: no handler.
- Messages avatar: no handler.
- Expert Studio creator-tool tiles: no navigation handler.
- Expert Studio authored-Lab Edit controls: visual only.
- Expert Studio primary action pill: visual only.
- Labs domain/category cards: no handler.
- Several Lab/build list cards: display-only despite appearing selectable.

### 19.2 Controls doing something different from their labels

- Create Account Sign In opens the main app without authentication.
- Discover Search switches to Labs but does not submit the query.
- Discover category cards open Labs but do not carry the category.
- Labs active tracks all open the same generic Lab Detail.
- Lab Detail Start This Lab starts at Break It rather than Build It.
- Discover Continue Lab opens a fixed sample Break It screen rather than persisted current progress.
- Assessment Result Launch Recommended Lab opens Build It rather than the recommended Lab Detail/player route.
- Lab Complete My Builds selects Labs rather than Builds.
- Peers Connect opens Messages directly rather than sending a request.
- VIP Pass opens a separate prototype membership screen rather than the canonical All Access route.

### 19.3 Feedback without the intended backend operation

- Subscription purchase: simulated success dialog; no real payment.
- Premium unlock: simulated success dialog; no real entitlement.
- OTP verification: demo code can be inserted automatically.
- Credential save/add: local state and snackbar only.
- Copy completion link: snackbar feedback only.
- Room connections: local/demo state only.
- Stage completion buttons: local state/snackbar only.
- Admin export: snackbar feedback rather than an actual export contract.

---

## 20. Specification-aligned canonical navigation

### 20.1 Public/onboarding

```text
Public Homepage
├── Start Free
│   └── Create Account
│       └── Verify Email
│           └── Profile Setup
│               └── Interests
│                   └── Fluency Assessment
│                       └── Assessment Result
│                           └── Discover
└── Browse/preview Labs
```

### 20.2 Authenticated member shell

```text
Discover | Labs | Rooms | Builds | Fluency
```

Member menu:

```text
Profile
Messages
Notifications
Subscription
Privacy
Settings
Build Expert Studio [approved Build Experts only]
```

### 20.3 Discover

```text
Discover
├── Continue Current Lab → Lab Player
├── Recommended Lab → Lab Detail → Start/Continue → Lab Player
├── Browse Categories → Category → Labs → Lab Detail
├── Search → Labs / Technologies / Categories
├── Who Else Is Building This? → Participant Profile
└── Recent Lab Room Activity → Lab Room
```

### 20.4 Labs and premium access

```text
Labs → Library → Category/Search → Lab Detail → Start/Continue → Lab Player
```

```text
Premium Lab
→ Locked Gate
→ All Access Pricing
→ Secure Payment
→ Entitlement Granted
→ Lab Unlocked
→ Lab Player
```

### 20.5 Lab Player

```text
One Lab Player
├── Build It
├── Break It
├── Understand It
└── Advise Better
→ Lab Complete
→ My Builds / Fluency
```

### 20.6 Community

```text
Rooms
→ Accessible Lab Rooms
→ Discussion / Questions / Failures / Insights / Observations
→ Participant view
→ Connect
→ Request Sent
→ Accepted / Connected
→ Messages
```

### 20.7 Build Expert and Admin

```text
Apply → Review → Approved → Studio → Proposal → Builder → Preview
→ Submit → Quality Review → Revision or Approval → Admin Publishes
```

```text
Separate Admin Web Portal
→ Members
→ Build Experts
→ Labs
→ Categories / Fluency / Badges
→ Commercial
→ Moderation
→ Publishing
```

---

## 21. Non-negotiable navigation rules

- Bottom navigation has only Discover, Labs, Rooms, Builds, and Fluency.
- The four Lab stages are views inside one Lab Player, not four bottom-nav destinations.
- Contextual Connection is not a fifth learning stage.
- Peers is contextual inside Labs and Lab Rooms, not a primary destination.
- Messages are available only after an accepted connection.
- Build Expert Studio is visible only to approved Build Experts.
- Admin is a separate web portal.
- Premium access is controlled by subscription entitlement, not by a visual lock alone.
- The first free Lab is a complete Lab, not a stripped-down demo.
- Lab content is flexible, ordered, and based on configurable content blocks.
- Start/Continue preserves Lab identity and progress.
- Search carries the query into actual Labs/technology/category results.
- Participant discovery respects visibility settings.
- Role, access, subscription, upload, messaging, and publishing permissions are server-side concerns.
- A control must navigate, perform its promised in-place action, or be visibly non-interactive; final UI must not contain visual buttons with no behavior.

---

## 22. Final interpretation

The current codebase is a mixture of:

- A five-tab indexed member shell.
- Directly pushed prototype screens.
- A global drawer containing member, Admin, Build Expert, premium, and Lab-stage routes.
- Static sample content.
- Demo shortcuts.
- Visual-only controls.

The Product Specification requires a focused technology laboratory rather than disconnected demo screens:

```text
Discover technology
→ Enter a real Lab
→ Build It
→ Break It
→ Understand It
→ Advise Better
→ Discuss in the contextual Lab Room
→ Connect through shared Lab context
→ Prove fluency through Builds and evidence
```

**BUILD IT. BREAK IT. UNDERSTAND IT. ADVISE BETTER.**

# Nurse OS – Unified Developer Guidelines (v2.1, June 2025)

*These rules supersede all prior versions of the Dev Buddy, Feature‑Dev, and MVP Roadmap files.  Follow them unless a newer tagged version explicitly overrides them.*

---

## 1. Core Principles

1. **Mock‑first, service‑swap later** All features ship against in‑memory or Hive adapters before we touch Firebase (Phase 5).
2. **Design tokens only** No hard‑coded colors, sizes, or radii. Every visual constant lives in `lib/ui/style.dart` and is accessed through `Theme.of(context).extension<AppTheme>()`.
3. **No stealth renaming** Any file move or name change must be called out in the PR description with a one‑line rollback snippet.
4. **Incremental PRs** < 400 LOC per pull request, CI green, and one review (can be alt account) before merge.
5. **HIPAA by default** Never log PHI, block screenshots, store secrets in env vars, and restrict Firestore rules to `uid == user.uid`.

---

## 2. Folder & Module Structure

```
lib/
  ui/            → design system & theme extension
  models/        → pure data classes (no Flutter imports)
  services/      → repositories & adapters (in‑memory, Hive, Firebase)
  state/         → Riverpod providers & AsyncNotifiers (read‑only selectors)
  widgets/       → reusable UI components (NursePill, NurseButton, etc.)
  screens/       → page‑level widgets only; no business logic
mock_data/        → Scenario builders and seed constants
```

---

## 3. Design System (`style.dart`)

* **Spacing scale** (xs 4, sm 8, md 12, lg 16, xl 24)
* **Radii** (pill 50, card 12, avatar 40)
* **Color palette**
  *Primary* #007AFF / #0A84FF · Secondary #32D74B / #30D158 · Error #FF3B30 / #FF453A
* Expose as immutable `AppTheme extends ThemeExtension<AppTheme>` with `light` & `dark` factories.
* All widgets import tokens—never duplicate values.

---

## 4. Coding Conventions

| Topic           | Rule                                                                                 |
| --------------- | ------------------------------------------------------------------------------------ |
| **Null‑safety** | Never force‑cast. Return nullable types or throw typed errors.                       |
| **Async**       | Repositories return `AsyncValue<T>` via Riverpod `FutureProvider` / `AsyncNotifier`. |
| **Widget size** | Max 200 LOC. Factor sub‑widgets when larger.                                         |
| **Comments**    | Header docblock + inline explanations for beginners (per v6‑2 style).                |

---

## 5. State Management

* Group providers by domain (`patient_providers.dart`, `vitals_providers.dart`).
* Expose read‑only `select` views to UI; mutations go through repo methods.
* Use Riverpod 2.5 `AsyncNotifier` for CRUD flows.

---

## 6. Testing & CI

1. **Golden toolkit** for visual regressions on every reusable widget.
2. **Widget tests** for Patient List, Patient Detail, Vitals screens.
3. **GitHub Actions** runs `flutter test --coverage` and `flutter analyze` on every PR.
4. **Coverage gate** ≥ 80 % lines.

---

## 7. Security & HIPAA

| Area           | Requirement                                                     |
| -------------- | --------------------------------------------------------------- |
| Screenshots    | Block with `flutter_windowmanager` (Android) & iOS equivalents. |
| Secure storage | Use `flutter_secure_storage` for PHI once Firebase lands.       |
| Audit trail    | Add `wasAiGenerated` + `modifiedBy`, log via Cloud Functions.   |
| Secrets        | Keep API keys in `--dart‑define` or CI secrets.                 |

---

## 8. Offline & Sync

* Local cache = Hive boxes behind repository interfaces.
* Expose `simulateNetworkError` flag to test retry logic.
* Sync strategy: optimistic updates + conflict resolution timestamp.

---

## 9. Repository Interfaces

```dart
abstract class PatientRepository {
  Future<List<PatientModel>> fetchAll({bool forceRefresh = false});
  Future<PatientModel?> getById(String id);
  Future<void> upsert(PatientModel patient);
}
```

Duplicate pattern for `VitalsRepository`, `CarePlanRepository`.

---

## 10. Commit & PR Workflow

```bash
# feature branch
$ git checkout -b feature/<ticket‑slug>

# staged changes ≤ 400 LOC
$ git add .
$ git commit -m "feat(patient): add design tokens to PatientCardWidget"

# run tests & analyzer
$ flutter test && flutter analyze

# push & open PR
$ ./push.sh "feat(patient): add design tokens"
```

Every PR must:

* Reference Click‑Up ticket ID.
* Show before/after screenshots when UI changes.
* Pass CI.

---

## 11. Roadmap Snapshot (Weeks 1‑6)

| Week | Goal                                                   |
| ---- | ------------------------------------------------------ |
| 1    | Design system + PatientCard refactor                   |
| 2    | Clean‑up PR; Provider selectors; Vitals/CarePlan repos |
| 3    | Golden & widget test baseline; CI gating               |
| 4    | Offline cache (Hive) POC                               |
| 5    | Security hardening (FLAG\_SECURE, logging guard)       |
| 6    | Firebase POC branch & learnings merge                  |

*(See `NurseOS_MVP_Roadmap.md` for full schedule; keep this table in PR descriptions.)*

---

## 12. GPT Integration Rules

* All AI‑generated suggestions must be labelled in logs (`wasAiGenerated=true`).
* No direct patient‑facing copy until reviewed by a human nurse admin.
* GPT modules run in Cloud Functions, not on device.

---

## 13. Distribution

* Build targets: **iOS** TestFlight, **Android** internal track (Phase 4), Web & macOS desktop (Phase 7+).
* Versioning: `major.minor.patch+build` – bump build on every CI artefact.

---

## 14. Feature Scope & Backlog

*Every item below ties to a real nurse pain‑point and a measurable business KPI.  Any new idea must land here via PR before work begins.*

### 14.0 Discovery Sprint *(Weeks 0‑2)*

| Deliverable                                     | Nurse outcome                  | KPI we test                 |
| ----------------------------------------------- | ------------------------------ | --------------------------- |
| Shadow two shifts & capture friction            | Validate real‑world workflow   | Qualitative feedback log    |
| TestFlight prototype: Patient List + dummy data | Gauge navigation intuitiveness | Time‑to‑first‑action < 30 s |

### 14.1 Foundation Sprint *(Weeks 3‑6)*

* **Design system & responsive UI** (style.dart, tokens)
* **Mock authentication** (local accounts, session persistence)
* **Patient List** with risk pills, pull‑to‑refresh
* **Vitals module** (add, history, graph)
* **Offline cache** behind repository interfaces
* **Micro‑AI hint**: vitals out‑of‑range flag (local logic, no GPT)

### 14.2 Structured Inputs *(Weeks 7‑12)*

* **Firebase integration** (Auth & Firestore)
* **Head‑to‑Toe Assessment** form → Firestore
* **Care Plan** view with version history
* **Sentiment Notes** v1 (AI rewrite assistant; Cloud Function)
* **FHIR‑compatible data schema** groundwork

### 14.3 Engagement & Compliance *(Weeks 13‑18)*

* **Gamification suite** — badges, XP dashboard, streak tracker
* **HIPAA audit trail** (`wasAiGenerated`, `modifiedBy`) + secure storage
* **CSV export** for manual EHR import

### 14.4 Admin & Analytics *(Weeks 19‑24)*

* **Web admin portal** — patient assignment, nurse scheduling
* **Advanced analytics dashboard** (patient trends, nurse performance)

### 14.5 Platform Expansion *(Weeks 25‑30)*

* **Android release** — parity with iOS
* **Voice dictation** for vitals & notes
* **Full FHIR integration** (live sync)

> **Success metrics** (tracked each phase): Daily Active Nurses (DAN), Monthly Active Nurses (MAN), Avg Task Completion Time, Retention (WAU/MAU), Error rate in charting.

---

## 15. Progress Snapshot Protocol

When the user asks for a **status recap** (e.g., "progress snapshot", "roadmap update", or "completed vs pending"), the assistant responds with two concise tables:

### 15.1 Completed (since last snapshot or Phase start)

| Task                  | PR / commit hash     | Date merged   |
| --------------------- | -------------------- | ------------- |
| <filled by assistant> | <link or short hash> | \<yyyy‑mm‑dd> |

### 15.2 Pending / In progress

| Task   | Owner           | Blocker                    |
| ------ | --------------- | -------------------------- |
| <task> | \<owner or `—`> | \<brief blocker or `None`> |

**Rules**

1. The assistant pulls task names directly from the Phase tables (Section 14) and any newly created tickets.
2. Mark a task *Completed* only when its PR is merged to `main`.
3. The snapshot must not exceed 12 rows per table; group minor tasks under a single row if needed.
4. Include a one‑sentence *Next focus* line after the tables.

> This keeps each chat high‑signal without copy‑pasting the entire roadmap.

---

## 16. Nurse Pain Points & Feature Alignment

*Stakeholder reference: Every major feature traces back to a real pain point validated in the Phase 0 discovery sprint.*

| Pain Point                     | Daily Impact                      | Nurse OS Relief Feature(s)                                                         | Notes / Future Enhancements                                 |
| ------------------------------ | --------------------------------- | ---------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| Documentation overload         | 25‑35 % of shift lost to charting | **Sentiment Notes AI**, **Vitals auto‑range checks**, upcoming **Voice Dictation** | Make AI rewrite a one‑tap action; surface confidence score. |
| Fragmented hand‑offs           | Missed meds, duplicated work      | **Head‑to‑Toe Assessment**, **Care Plan version history**                          | Add “changed‑since‑last‑shift” badge.                       |
| Alarm fatigue / cognitive load | Important vitals buried           | **Risk pills**, local AI out‑of‑range flag                                         | Offer silent summary mode for low‑risk trends.              |
| Data hunting across tabs       | Time wasted, context lost         | Unified **Patient Detail** screen                                                  | Prioritize offline cache for dead zones.                    |
| Compliance anxiety             | Fear of litigation                | **Sentiment Notes AI**, **Audit log** (`wasAiGenerated`)                           | Inline diffs to explain AI edits.                           |
| Burnout & low morale           | High turnover                     | **Gamification** (XP, badges)                                                      | Tie XP to quality‑of‑care tasks, not volume.                |
| Device / Wi‑Fi downtime        | Charting stalls                   | **Offline Hive cache**, optimistic sync                                            | Show clear “sync pending” icon.                             |
| Double entry into EHR          | Duplication risk                  | **CSV export** (Phase 3), **FHIR integration** (Phase 5)                           | Mock CSV export now for quick wins.                         |
| Tool learning curve            | Adoption friction                 | **Design‑system consistency**, minimal UI                                          | Five‑step onboarding walkthrough.                           |

> **Keep this table in sync**: Whenever a new pain point or feature is validated, update this section in the same PR that adds the ticket.

---

## 17. Testing Prompt Rule

To prevent bug‑fix overwhelm, the assistant **must prompt the user to run and test the app** at every logical checkpoint:

1. **After a feature branch compiles locally with no analyzer errors** – before starting the next task.
2. **Right after golden/widget tests pass in CI** – confirm UI looks correct on a real device.
3. **Immediately post‑merge into `dev` or `main`** – smoke‑test the merged build.

The prompt should be concise, e.g.:

> "✅ Build is green. When you have a minute, run the app on iOS Simulator and tap through Patient List → Detail to confirm the new pill styles look right. Let me know if anything breaks and we’ll fix before moving on."

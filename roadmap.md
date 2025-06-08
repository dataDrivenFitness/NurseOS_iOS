# 🛣️ NurseOS iOS – Roadmap v6

_Last updated: June 7, 2025_

---

## ✅ Phase 1: Core UI + Mock State (Complete)

- [x] Login / Sign-up (UI only)
- [x] Home screen with greeting
- [x] Patient list screen (mocked, sortable)
- [x] Patient detail screen (photo, vitals, care plan)
- [x] Vitals entry screen (mocked)
- [x] Mock user support (photo, XP, level)
- [x] Routing with Navigator
- [x] Riverpod state architecture
- [x] Pronouns and profile photo support

---

## 🔄 Phase 2: Repository & Mock Layer

- [x] `VitalsRepository`, `PatientRepository` abstraction
- [x] `FakeVitalsRepository` with cache and mock save
- [x] `FakePatientRepository` with JSON fallback
- [ ] `CarePlanRepository` (Fake and Abstract)
- [ ] All mock data centralized in `.dart` or `.json` assets
- [ ] All state powered by repository interfaces

---

## 🎮 Phase 3: Gamification + UX Polish

- [ ] XP rewarded for completed vitals entries
- [ ] Level system increment logic
- [ ] XP & level display in dashboard/profile
- [ ] Auto-resizing Card UIs (care plan, vitals, etc.)
- [ ] iOS layout polish across simulators

---

## 🧑‍⚕️ Phase 4: Patient & Profile Editing

- [ ] Edit patient info (room, pronouns, photo)
- [ ] Create new patient
- [ ] Edit current user profile
- [ ] All changes saved in mock state only

---

## 🧠 Phase 5: GPT-Enabled Stubs (NLP Planned)

- [ ] Stub care plan generator (GPT placeholder)
- [ ] Stub patient summary summarizer
- [ ] Stub vitals anomaly detection logic

🛑 _No actual OpenAI integration until backend milestone_

---

## 🔐 Phase 6: Firebase Integration (Final)

- [ ] Implement `Firebase*Repository` versions
- [ ] Swap via feature flag toggle
- [ ] Add Firebase Auth logic (sign in/out)
- [ ] Match `UserModel` to Firebase Auth expectations
- [ ] HIPAA-aware Firestore rules

---

## 🧪 QA / Device Testing

- ✅ Intel Mac patch in Podfile
- ✅ Works on iOS Simulator
- 🔜 Physical device validation (before Firebase)
- ❌ Android/web deferred

---

## 📦 Technical Principles

- `StateNotifier` + `AsyncNotifier` only
- UI stays logic-free (uses Riverpod exclusively)
- Firebase is feature-flagged and opt-in
- HIPAA-compliant minimal UI by design

---

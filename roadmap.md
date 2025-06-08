# 🛣️ NurseOS iOS – Development Roadmap

_Last updated: June 7, 2025_

---

## ✅ Phase 1: UI + Riverpod State (Complete)

- [x] Login / Sign-up UI (mock only)
- [x] Home screen with time-based greeting
- [x] Patient list screen with filter + sorting
- [x] Patient detail screen with vitals + care plans
- [x] Vitals entry screen (mock save)
- [x] Care plan viewer (per-patient)
- [x] Profile viewing (photo, name, pronouns)
- [x] Routing + state hooks
- [x] User/patient photos, pronouns, gamification (XP, level)

---

## 🔄 Phase 2: Repository Refactor

- [x] Abstract repository pattern (`VitalsRepository`, `PatientRepository`)
- [x] `Fake*Repository` implementations
- [ ] `CarePlanRepository` implementation
- [ ] Centralize test/mock data (JSON or `.dart` file)
- [ ] Begin provider swaps using feature flags

---

## 🎯 Phase 3: Gamification Expansion

- [ ] XP visualization on dashboard/profile
- [ ] XP rewards for completing care tasks or vitals
- [ ] Level-up logic for user

---

## 🧑‍⚕️ Phase 4: Patient & Profile Editing

- [ ] Edit patient profiles (pronouns, room, photo)
- [ ] Create new patient from FAB
- [ ] Add/edit user profile (photo, display name)
- [ ] All changes saved to mock layer

---

## 🧠 Phase 5: GPT/NLP Logic (Stubbed)

- [ ] Care plan auto-generation (GPT-4 placeholder logic)
- [ ] Patient summary summarizer (stub only)
- [ ] Vitals anomaly notes (no live GPT calls)

---

## 🔐 Phase 6: Firebase Integration

- [ ] Add real Firebase repos (Auth, Firestore)
- [ ] Match UserModel to Firebase Auth
- [ ] Toggle Firebase with feature flag
- [ ] Add auth logic (sign in/out, session)
- [ ] Secure Firebase rules (HIPAA-aware)

---

## 🧪 QA / Device Testing

- ✅ Simulator ready (Intel Mac Podfile patch)
- 🔜 Physical device test before Firebase
- ❌ Android/web deferred

---

## 🔐 Technical Policies

- Riverpod only (State/AsyncNotifier)
- Mock-first architecture
- Platform locked to iOS
- HIPAA-aligned minimalist UX

---

# 🛠️ Services Layer

This folder contains all the service and repository implementations responsible for fetching, storing, and updating app data.

---

## 📄 Key Files

### `in_memory_patient_repository.dart`
- Implements `PatientRepository`
- Local-only storage of `PatientModel` for mock/test environments
- Can be swapped out with `FirebasePatientRepository` in Phase 5

### `fake_shift_note_service.dart`, `fake_vitals_service.dart`
- Provide mock implementations for GPT output and vital readings
- Used to simulate backend behavior in mock-first builds

---

## 🔄 Transition Plan

In the future (Phase 5+), you'll replace these files with:
- `firebase_patient_repository.dart`
- `firebase_shift_note_service.dart`

---

## 🧠 Architecture Note

Each service implements a clean, abstract interface (like `PatientRepository`) and can be easily swapped via providers or flags.

---

## ✅ Best Practice

- Use `in_memory_*` naming for test/dummy implementations
- Avoid "fake_" or "mock_" in core architecture to simplify transitions
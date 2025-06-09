
# 🛠️ NurseOS Developer Guidelines (v5 – MVP-Plus with Mock-First Strategy)

## ⚙️ BUILD RULES

### Mock-First Architecture
- **DO NOT** integrate Firebase Auth or Firestore until the final MVP phase
- All features must use **mock data** and **local-only state**
- Structure all models and services to match Firestore schema (UIDs, timestamps, nested collections)
- Use `lib/services/` for mock logic and `lib/mock_data/` for static test data

### Development Priority Order
1. Complete remaining tasks from current sprint (Vitals, Care Plans, Notes)
2. Build the **Head-to-Toe Assessment module** as the next active task
3. Integrate Shift Handoff generation, including linked assessments
4. Enable GPT-powered Shift Notes with mock input/output flow
5. Implement Assigned Nurse Access model using mock UIDs
6. Add polish (Inter font, quick actions, theme) only if time allows

---

## 📦 FILE STRUCTURE

```
/lib/
  /mock_data/                # Mock dataset files
    mock_patients.dart
    mock_notes.dart
    mock_vitals.dart
    mock_assessments.dart
    mock_users.dart

  /services/                 # Mock service logic (e.g., read/write)
    mock_patient_service.dart
    mock_note_service.dart
    mock_vitals_service.dart
    mock_auth_service.dart
    mock_assessment_service.dart

  /screens/                  # UI components by feature
    head_to_toe_screen.dart
    shift_handoff_screen.dart
    shift_note_editor.dart

  /widgets/                  # Reusable UI components
    vitals_card.dart
    patient_card.dart
    assessment_section.dart

  /state/                    # Riverpod providers
    patient_provider.dart
    auth_provider.dart
    assessment_provider.dart
```

---

## 🧪 MOCK STRATEGY

- **Patients**: assigned mock `uid`, pronouns, flags
- **Vitals**: static lists, recent entries ordered by date
- **Care Plans**: non-branching list of tasks
- **Assessments**: sectioned input, saved per patient per date
- **Notes & Shift Notes**: linked to mock `nurseId`, sentiment tags
- **Hand-offs**: generated from most recent patient data, assessment, and notes

---

## 🔐 ACCESS LOGIC

- No real authentication—simulate user session via mock `currentUser`
- Use UID-based filtering in services: `where assignedNurses contains uid`
- Prepare providers for Firestore-ready swap-in during final phase

---

## 🧠 GPT Integration Guidelines

- Shift Notes must support optional GPT-generated content
- GPT output can be mocked via static string or simulated async return
- Maintain `wasAiGenerated = true` metadata for audit trace

---

## 🚀 NEXT TASK

➡️ **Build the Head-to-Toe Assessment module next**, following the shared UI/UX patterns. It should:
- Use dropdowns, text fields, and checkboxes grouped by body system
- Be saveable to mock storage with timestamps and nurse ID
- Appear in the patient timeline
- Integrate into shift handoff summaries as a snapshot

---

*Keep it lean. Keep it usable. Build for real nurses first.*

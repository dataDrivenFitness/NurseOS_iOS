# 🧬 /models/

This folder contains pure data models used throughout NurseOS.

## 📦 Rules
- No methods beyond serialization/deserialization
- Follow Firestore schema compatibility (UIDs, timestamps, nested fields)
- No business logic or UI imports

## 📚 Common Files
- `patient_model.dart`
- `vitals_model.dart`
- `care_plan_model.dart`
- `shift_note_model.dart`
- `user_display_preferences.dart`

## 🔁 Used By
- /services/
- /state/
- /test_utils/MockScenarioBuilder

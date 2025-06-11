# 🔧 /services/

Contains mock services for simulating backend behavior.

## 📦 Rules
- Async methods with fake delay
- No UI or Riverpod imports
- Include `simulateError` toggles for testing error states
- Only uses mock data and models

## 📚 Common Files
- `mock_patient_service.dart`
- `mock_vitals_service.dart`
- `mock_note_service.dart`
- `mock_auth_service.dart`

## 🔁 Depends On
- /models/
- /mock_data/

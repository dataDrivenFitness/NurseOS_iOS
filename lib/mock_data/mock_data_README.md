# 📁 mock_data/ – NurseOS Mock Data Directory

This folder contains the static test data used throughout the app during mock-first development.

## 🔗 Structure

- `mock_constants.dart` — Shared mock UIDs and names
- `mock_patients.dart`, `mock_vitals.dart`, etc. — Base entity lists for services
- `mock_shift_notes.dart` — AI or manual shift documentation examples
- `mock_users.dart` — Sample nurse data

## 🧠 Best Practices

- Use constants from `mock_constants.dart` instead of hardcoded strings.
- Build patients and related records using `MockScenarioBuilder` from `test_utils/`.
- Each patient UID should link to valid mock vitals, care plans, assessments, and notes.
- Avoid random data. Build consistent, story-driven mock profiles for better test coverage.

## 🛠 Maintenance Tips

- When models change, update the scenario builder before patching individual mock files.
- Use comments to track dependencies (`used by`, `depends on`) per file.
- Simulate edge cases in services using toggleable error states.

---

*Consistent data means reliable screens. Build your mocks like they’re real.*

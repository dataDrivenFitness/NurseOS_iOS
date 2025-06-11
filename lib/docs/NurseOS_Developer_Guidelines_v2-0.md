### 🧪 Scenario-Driven Mock Architecture

- All test data must be defined using shared constants from `mock_constants.dart`
- Use `MockScenarioBuilder` for all mock entities when possible:
  - Reduces duplication across services
  - Guarantees UID and timestamp consistency
  - Accelerates realistic screen testing
- All mock data files must be scenario-compatible (i.e., accept UIDs and timestamps)
- Error simulation logic must be built into all `mock_*_service.dart` classes

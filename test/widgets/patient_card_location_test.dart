import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/models/risk_level.dart';
import 'package:nurse_os/ui/style.dart';
import 'package:nurse_os/widgets/patient_card_widget.dart';
import 'package:nurse_os/state/display_preferences_provider.dart';   // provides DisplayPreferences

void main() {
  testWidgets('Patient card shows location row', (tester) async {
    final patient = PatientModel(
      id: 'demo',
      firstName: 'Test',
      lastName:  'Patient',
      age: 70,
      location: 'Room 101 · ICU',
      diagnosis: 'COPD',
      riskLevel: RiskLevel.medium,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: const [AppTheme.light]),
        home: Scaffold(
          body: PatientCardWidget(
            patient: patient,
            prefs: DisplayPreferences(),       // ← use default constructor
          ),
        ),
      ),
    );

    expect(find.text('Room 101 · ICU'), findsOneWidget);
  });
}

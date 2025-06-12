import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurse_os/widgets/patient_card_widget.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/models/risk_level.dart';
import 'package:nurse_os/ui/style.dart';

void main() {
  testWidgets('Patient card shows tag pills', (tester) async {
    final patient = PatientModel(
      id: 'demo',
      firstName: 'Test',
      lastName:  'Patient',
      age: 55,
      location: 'Room 1',
      diagnosis: 'Asthma',
      riskLevel: RiskLevel.medium,
      tags: ['fall-risk', 'DNR'],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: const [AppTheme.light]),
        home: Scaffold(
          body: PatientCardWidget(
            patient: patient,
            prefs: DisplayPreferences.empty(), // or stub provider
          ),
        ),
      ),
    );

    expect(find.text('fall-risk'), findsOneWidget);
    expect(find.text('DNR'),       findsOneWidget);
  });
}

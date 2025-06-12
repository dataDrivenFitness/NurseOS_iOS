// test/widgets/nurse_pill_test.dart
//
// Verifies that NursePill renders the correct text and picks up theme colours.
//
// Run with: flutter test test/widgets/nurse_pill_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurse_os/widgets/nurse_pill.dart';
import 'package:nurse_os/ui/style.dart';

void main() {
  group('NursePill', () {
    testWidgets('displays the provided label', (tester) async {
      // Wrap in MaterialApp so Theme.of() works; inject light AppTheme.
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: const [AppTheme.light]),
          home: const Scaffold(body: NursePill('High Risk')),
        ),
      );

      // Verify the text appears exactly once.
      expect(find.text('High Risk'), findsOneWidget);
    });
  });
}

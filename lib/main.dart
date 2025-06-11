import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state/theme_provider.dart';
import 'state/patient_provider.dart';
import 'mock_data/mock_patient_data.dart';

import 'screens/login_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/vitals_entry_screen.dart';
import 'screens/vitals_history_screen.dart';
import 'screens/vitals_chart_screen.dart';
import 'screens/vitals_dashboard_screen.dart';
import 'services/fake_patient_repository.dart';


import 'themes/typography.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        patientRepositoryProvider.overrideWith(
          (ref) => FakePatientRepository(patients: mockPatients),
        ),
      ],
      child: const NurseOSApp(),
    ),
  );
}

class NurseOSApp extends ConsumerWidget {
  const NurseOSApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    final lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.indigo);
    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NurseOS',
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        textTheme: buildInterTextTheme(lightColorScheme),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        textTheme: buildInterTextTheme(darkColorScheme),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/vitals-entry': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return VitalsEntryScreen(patientId: args['patientId']);
        },
        '/vitals-history': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return VitalsHistoryScreen(patientId: args['patientId']);
        },
        '/vitals-chart': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return VitalsChartScreen(patientId: args['patientId']);
        },
        '/vitals-dashboard': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return VitalsDashboardScreen(
            patientId: args['patientId'],
            range: args['range'],
          );
        },
      },
    );
  }
}

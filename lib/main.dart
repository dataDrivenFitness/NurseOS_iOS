// lib/main.dart
//
// iOS-only entry point for Nurse OS
// – Global ProviderScope
// – Light/Dark themes via design tokens
// – Portrait-only orientation
// – Launches Patient List (auth flow TBD)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/style.dart';
import 'package:nurse_os/screens/patient_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: NurseOSApp()));
}

class NurseOSApp extends StatelessWidget {
  const NurseOSApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Nurse OS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppTheme.light.background,
          extensions: const [AppTheme.light],
          fontFamily: 'SF Pro',
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppTheme.dark.background,
          extensions: const [AppTheme.dark],
          fontFamily: 'SF Pro',
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const PatientListScreen(),
      );
}

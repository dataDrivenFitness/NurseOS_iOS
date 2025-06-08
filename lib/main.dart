import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/login_screen.dart';
import 'state/theme_provider.dart';
import 'themes/typography.dart';
import 'screens/edit_profile_screen.dart';

void main() {
  runApp(const ProviderScope(child: NurseOSApp()));
}

class NurseOSApp extends ConsumerWidget {
  const NurseOSApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    final lightScheme = ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.light);
    final darkScheme = ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark);

    return MaterialApp(
      title: 'NurseOS',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: lightScheme,
        textTheme: buildInterTextTheme(lightScheme),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: darkScheme,
        textTheme: buildInterTextTheme(darkScheme),
        useMaterial3: true,
      ),
      routes: {
      '/edit-profile': (context) => const EditProfileScreen(),
      },
      home: const LoginScreen(),
    );
  }
}

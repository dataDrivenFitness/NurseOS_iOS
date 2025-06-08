import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) {
          final hasPhoto = user.photoUrl != null && user.photoUrl!.isNotEmpty;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.indigo,
                  backgroundImage: user.photoUrl != null && user.photoUrl!.isNotEmpty
                      ? FileImage(File(user.photoUrl!))
                      : null,
                  child: user.photoUrl == null || user.photoUrl!.isEmpty
                      ? Text(user.initials, style: const TextStyle(fontSize: 32, color: Colors.white))
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  user.fullName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Center(
                child: Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Profile'),
                onTap: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign Out'),
                onTap: () {
                  // Future sign-out logic
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

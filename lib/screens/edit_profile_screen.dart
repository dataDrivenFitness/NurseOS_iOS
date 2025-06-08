import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../state/user_provider.dart';
import '../models/user_model.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider).value!;
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _save() {
    final user = ref.read(userProvider).value!;
    final updated = user.copyWith(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      photoUrl: _imageFile?.path ?? user.photoUrl,
    );
    ref.read(userProvider.notifier).updateUser(updated);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).value!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: GestureDetector(
              onTap: () => _showPhotoSourceDialog(),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: theme.colorScheme.primary,
                backgroundImage:
                    _imageFile != null ? FileImage(_imageFile!) : (user.photoUrl != null ? FileImage(File(user.photoUrl!)) : null),
                child: _imageFile == null && user.photoUrl == null
                    ? const Icon(Icons.camera_alt, size: 30, color: Colors.white)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Save Changes'),
            onPressed: _save,
          ),
        ],
      ),
    );
  }

  void _showPhotoSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}

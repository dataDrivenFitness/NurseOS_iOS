import 'package:flutter/material.dart';
import 'package:nurse_os/models/risk_level.dart';

class FirstNameField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  const FirstNameField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'First Name'),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      onSaved: onSaved,
    );
  }
}

class LastNameField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  const LastNameField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Last Name'),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      onSaved: onSaved,
    );
  }
}

class AgeField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  const AgeField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Age'),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        final age = int.tryParse(value);
        if (age == null || age < 0) return 'Invalid age';
        return null;
      },
      onSaved: onSaved,
    );
  }
}

class RoomNumberField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  const RoomNumberField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Room Number'),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      onSaved: onSaved,
    );
  }
}

class DiagnosisField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  const DiagnosisField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Diagnosis'),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      onSaved: onSaved,
    );
  }
}

class PronounsField extends StatelessWidget {
  final FormFieldSetter<String?> onSaved;
  const PronounsField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Pronouns (optional)'),
      onSaved: onSaved,
    );
  }
}

class RiskOverrideField extends StatelessWidget {
  final FormFieldSetter<RiskLevel?> onSaved;
  const RiskOverrideField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<RiskLevel?>(
      decoration: const InputDecoration(labelText: 'Manual Risk Override (optional)'),
      items: [
        const DropdownMenuItem<RiskLevel?>(
          value: null,
          child: Text('None'),
        ),
        ...RiskLevel.values.map((level) => DropdownMenuItem(
              value: level,
              child: Text(level.name.toUpperCase()),
            )),
      ],
      onChanged: (_) {},
      onSaved: onSaved,
    );
  }
}

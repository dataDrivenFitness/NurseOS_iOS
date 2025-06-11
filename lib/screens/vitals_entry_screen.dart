import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:nurse_os/state/vitals_provider.dart';
import 'package:uuid/uuid.dart';

class VitalsEntryScreen extends ConsumerStatefulWidget {
  final String patientId;

  const VitalsEntryScreen({super.key, required this.patientId});

  @override
  ConsumerState<VitalsEntryScreen> createState() => _VitalsEntryScreenState();
}

class _VitalsEntryScreenState extends ConsumerState<VitalsEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  double? temperature;
  int? heartRate;
  int? systolic;
  int? diastolic;
  int? respiratoryRate;
  int? oxygenSaturation;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final vitals = VitalsModel(
        id: _uuid.v4(),
        patientId: widget.patientId,
        takenBy: 'nurse_001', // Mock nurse ID
        timestamp: DateTime.now(),
        temperature: temperature!,
        heartRate: heartRate!,
        systolic: systolic!,
        diastolic: diastolic!,
        respiratoryRate: respiratoryRate!,
        oxygenSaturation: oxygenSaturation!,
      );

      ref.read(vitalsControllerProvider(widget.patientId).notifier).addVitals(vitals);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter Vitals")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildNumberField("Temperature (°F)", (val) => temperature = double.tryParse(val ?? '')),
              _buildNumberField("Pulse (bpm)", (val) => heartRate = int.tryParse(val ?? '')),
              _buildNumberField("Systolic BP", (val) => systolic = int.tryParse(val ?? '')),
              _buildNumberField("Diastolic BP", (val) => diastolic = int.tryParse(val ?? '')),
              _buildNumberField("Respiration Rate", (val) => respiratoryRate = int.tryParse(val ?? '')),
              _buildNumberField("Oxygen Saturation (%)", (val) => oxygenSaturation = int.tryParse(val ?? '')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField(String label, Function(String?) onSaved) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        keyboardType: TextInputType.number,
        validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        onSaved: onSaved,
      ),
    );
  }
}

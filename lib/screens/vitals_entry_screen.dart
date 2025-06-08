import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/vitals_model.dart';
import '../state/vitals_provider.dart';
import 'package:nurse_os/state/user_state.dart';
import 'package:nurse_os/state/vitals_controller.dart';

class VitalsEntryScreen extends ConsumerStatefulWidget {
  final String patientId;

  const VitalsEntryScreen({super.key, required this.patientId});

  @override
  ConsumerState<VitalsEntryScreen> createState() => _VitalsEntryScreenState();
}

class _VitalsEntryScreenState extends ConsumerState<VitalsEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  double? _temperature;
  int? _pulse;
  int? _systolic;
  int? _diastolic;
  int? _respiration;
  int? _oxygen;
  String? _notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Vitals')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(label: 'Temperature (°F)', onSaved: (v) => _temperature = double.tryParse(v ?? '')),
              _buildField(label: 'Pulse (bpm)', onSaved: (v) => _pulse = int.tryParse(v ?? '')),
              _buildField(label: 'Systolic BP', onSaved: (v) => _systolic = int.tryParse(v ?? '')),
              _buildField(label: 'Diastolic BP', onSaved: (v) => _diastolic = int.tryParse(v ?? '')),
              _buildField(label: 'Respiration Rate', onSaved: (v) => _respiration = int.tryParse(v ?? '')),
              _buildField(label: 'Oxygen Saturation (%)', onSaved: (v) => _oxygen = int.tryParse(v ?? '')),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes (optional)'),
                maxLines: 3,
                onSaved: (v) => _notes = v,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Vitals'),
                onPressed: _handleSubmit,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({required String label, required void Function(String?) onSaved}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      onSaved: onSaved,
    );
  }

  void _handleSubmit() async {
  if (_formKey.currentState?.validate() ?? false) {
    _formKey.currentState?.save();

    final vitals = VitalsModel(
      id: _uuid.v4(),
      patientId: widget.patientId,
      timestamp: DateTime.now(),
      temperature: _temperature ?? 0,
      pulse: _pulse ?? 0,
      systolicBP: _systolic ?? 0,
      diastolicBP: _diastolic ?? 0,
      respirationRate: _respiration ?? 0,
      oxygenSaturation: _oxygen ?? 0,
      recordedBy: ref.read(currentUserProvider).fullName,
      notes: _notes,
    );

    await ref.read(vitalsControllerProvider(widget.patientId).notifier).addVitals(vitals);

    if (!mounted) return;
    Navigator.pop(context);
    }
  }
}
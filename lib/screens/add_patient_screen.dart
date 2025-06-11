import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/extensions/risk_utils.dart';
import 'package:nurse_os/widgets/form_fields/patient_form_fields.dart';
import 'package:nurse_os/services/fake_patient_repository.dart';
import 'package:nurse_os/state/patient_provider.dart';

class AddPatientScreen extends ConsumerStatefulWidget {
  const AddPatientScreen({super.key});

  @override
  ConsumerState<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends ConsumerState<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  int _age = 0;
  String _roomNumber = '';
  String _diagnosis = '';
  String? _pronouns;
  RiskLevel? _manualOverride;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Patient')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              FirstNameField(onSaved: (val) => _firstName = val!),
              LastNameField(onSaved: (val) => _lastName = val!),
              AgeField(onSaved: (val) => _age = int.parse(val!)),
              RoomNumberField(onSaved: (val) => _roomNumber = val!),
              DiagnosisField(onSaved: (val) => _diagnosis = val!),
              PronounsField(onSaved: (val) => _pronouns = val),
              RiskOverrideField(onSaved: (val) => _manualOverride = val),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final patient = PatientModel(
                      id: UniqueKey().toString(),
                      firstName: _firstName,
                      lastName: _lastName,
                      age: _age,
                      roomNumber: _roomNumber,
                      diagnosis: _diagnosis,
                      pronouns: _pronouns,
                      manualRiskOverride: _manualOverride,
                      admittedAt: DateTime.now(),
                      assignedNurses: ['nurse_001'],
                      ownerUid: 'nurse_001',
                      createdBy: 'nurse_001',
                    );

                    ref.read(patientRepositoryProvider.notifier).addPatient(patient);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

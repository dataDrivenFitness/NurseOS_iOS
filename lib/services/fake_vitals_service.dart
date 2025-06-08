import '../models/vitals_model.dart';

class FakeVitalsService {
  Future<void> submitVitals(VitalsModel vitals) async {
    await Future.delayed(const Duration(milliseconds: 400));
    print('[MOCK] Submitted vitals for ${vitals.patientId}: ${vitals.temperature}°C, ${vitals.pulse} bpm');
  }
}

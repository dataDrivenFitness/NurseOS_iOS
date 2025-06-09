import 'package:flutter/material.dart';

class VitalsActionButtons extends StatelessWidget {
  final String patientId;
  final VoidCallback? onAddVital;
  final VoidCallback? onViewGraph;

  const VitalsActionButtons({
    super.key,
    required this.patientId,
    this.onAddVital,
    this.onViewGraph,
  });

  @override
  Widget build(BuildContext context) {
    // Disabled to remove duplicate vitals button row
    return const SizedBox.shrink();
  }
}

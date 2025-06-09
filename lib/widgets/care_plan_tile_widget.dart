import 'package:flutter/material.dart';
import '../models/care_plan_model.dart';

class CarePlanTileWidget extends StatelessWidget {
  final CarePlanModel carePlan;

  const CarePlanTileWidget({super.key, required this.carePlan});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.assignment),
        title: Text(carePlan.title),
        subtitle: Text('Last updated: ${carePlan.createdAt.toLocal().toIso8601String().split('T').first}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, '/care-plan-detail', arguments: carePlan);
        },
      ),
    );
  }
}

// ... existing imports ...
import 'package:flutter/material.dart';
import 'package:shop/features/machine_monitoring/models/machine.dart';
import 'package:shop/features/machine_monitoring/presentation/machine_card.dart';
import 'package:shop/features/machine_monitoring/services/machine_api_service.dart'; // Ensure this is present
// ... rest of code ...

class MachineStatusScreen extends StatefulWidget {
  const MachineStatusScreen({Key? key}) : super(key: key);

  @override
  _MachineStatusScreenState createState() => _MachineStatusScreenState();
}

class _MachineStatusScreenState extends State<MachineStatusScreen> {
  final MachineApiService _apiService = MachineApiService();

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Floor Monitor'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: StreamBuilder<List<Machine>>(
        stream: _apiService.machineStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No machines found.'));
          }

          final machines = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              // *** ADJUST THIS VALUE ***
              // Make it a smaller number to make cards taller, e.g., 1.2 or 1.1
              childAspectRatio: 1.1, // Experiment with 1.2, 1.1, or even 1.0 if needed
            ),
            itemCount: machines.length,
            itemBuilder: (context, index) {
              return MachineCard(machine: machines[index]);
            },
          );
        },
      ),
    );
  }
}


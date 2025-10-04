import 'dart:async';
import 'dart:math';
import 'package:shop/features/machine_monitoring/models/machine_status_screen.dart';

import '../models/machine.dart';
import '../models/machine_status_screen.dart';

class MachineApiService {
  // Mock data for initial state
  List<Machine> _machines = [
    Machine(id: 'M001', name: 'CNC Lathe 1', location: 'Area A', status: MachineStatus.running, oee: 88.5),
    Machine(id: 'M002', name: 'Milling Center 2', location: 'Area B', status: MachineStatus.idle, oee: 75.2),
    Machine(id: 'M003', name: 'Laser Cutter 3', location: 'Area A', status: MachineStatus.down, oee: 52.1),
    Machine(id: 'M004', name: 'Welding Robot 4', location: 'Area C', status: MachineStatus.running, oee: 92.0),
  ];

  // Stream controller for real-time updates
  final _machineStreamController = StreamController<List<Machine>>.broadcast();

  Stream<List<Machine>> get machineStream => _machineStreamController.stream;

  MachineApiService() {
    // Simulate real-time data updates every 5 seconds
    Timer.periodic(const Duration(seconds: 5), (timer) {
      _updateMachineData();
      _machineStreamController.add(_machines);
    });
  }

  // Simulates a change in status and OEE
  void _updateMachineData() {
    final random = Random();
    _machines = _machines.map((machine) {
      // Randomly change status
      final newStatus = MachineStatus.values[random.nextInt(MachineStatus.values.length)];
      
      // Randomly change OEE (slight fluctuation)
      final double oeeChange = (random.nextDouble() * 4) - 2; // change between -2.0 and +2.0
      double newOEE = machine.oee + oeeChange;
      
      // Clamp OEE between 0 and 100
      newOEE = newOEE.clamp(0.0, 100.0);
      
      return Machine(
        id: machine.id,
        name: machine.name,
        location: machine.location,
        status: newStatus,
        oee: newOEE,
      );
    }).toList();
  }
  
  void dispose() {
    _machineStreamController.close();
  }
}
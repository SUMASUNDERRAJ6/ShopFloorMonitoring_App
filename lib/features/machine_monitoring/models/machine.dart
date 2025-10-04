import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shop/features/machine_monitoring/models/machine_status_screen.dart';

import 'machine_status_screen.dart';

class Machine {
  final String id;
  final String name;
  final String location;
  final MachineStatus status;
  final double oee; // Overall Equipment Effectiveness

  Machine({
    required this.id,
    required this.name,
    required this.location,
    required this.status,
    required this.oee,
  });

  // Helper to get status color
  static Color statusColor(MachineStatus status) {
    switch (status) {
      case MachineStatus.running:
        return Colors.green;
      case MachineStatus.idle:
        return Colors.yellow.shade800;
      case MachineStatus.down:
        return Colors.red;
      case MachineStatus.maintenance:
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }
}
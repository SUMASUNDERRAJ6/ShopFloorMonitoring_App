import 'package:flutter/material.dart';
import '../models/machine.dart';
import '../models/machine_status_screen.dart'; // Ensure this import is present

class MachineCard extends StatelessWidget {
  final Machine machine;

  const MachineCard({Key? key, required this.machine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color statusColor = Machine.statusColor(machine.status);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Slightly reduce padding to gain space
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Use MainAxisAlignment.spaceBetween to push content to ends if needed,
          // but CrossAxisAlignment.start is good for left alignment.
          // For overflow, the main axis is usually the problem.
          children: [
            // Machine Name
            Text(
              machine.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold), // Adjusted to titleMedium for potentially smaller text
              overflow: TextOverflow.ellipsis, // Prevents overflow for long names
              maxLines: 1,
            ),
            // Location
            Text(
              'Location: ${machine.location}',
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            
            const Spacer(), // Pushes status and OEE to the bottom, sharing available space

            // Status Indicator
            Row(
              children: [
                Container(
                  width: 10, // Slightly smaller circle
                  height: 10,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6), // Slightly smaller gap
                Text(
                  machine.status.name.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13, // Slightly smaller font size
                    color: statusColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
            const SizedBox(height: 8), // Add a small space

            // OEE Metric
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Current OEE:',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13), // Smaller font
                ),
                Text(
                  '${machine.oee.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 16, // Smaller font
                    fontWeight: FontWeight.bold,
                    color: machine.oee >= 85 ? Colors.green.shade700 : Colors.orange.shade700,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
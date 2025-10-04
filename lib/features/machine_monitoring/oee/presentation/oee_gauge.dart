import 'package:flutter/material.dart';
import 'package:shop/core/constants.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/constants.dart';

class OEEGauge extends StatelessWidget {
  final String title;
  final double value; // Percentage 0.0 to 100.0
  final Color color;

  const OEEGauge({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Normalize value to 0.0 to 1.0 for LinearProgressIndicator
    final double normalizedValue = value / 100.0;
    
    // Determine if the value is below the target OEE for alerting
    final bool isBelowTarget = value < AppConstants.targetOEE;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Value Display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${value.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress Bar
          LinearProgressIndicator(
            value: normalizedValue,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(
              isBelowTarget && title.contains('OEE') ? Colors.redAccent : color,
            ),
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }
}
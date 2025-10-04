import 'package:flutter/material.dart';
import 'package:shop/core/app_theme.dart';
import '../models/oee_metric.dart';
import '../services/oee_api_service.dart';
import 'oee_gauge.dart';
import '../../../core/app_theme.dart';
import 'package:shop/core/constants.dart';

class OEEDashboardScreen extends StatefulWidget {
  const OEEDashboardScreen({super.key});

  @override
  State<OEEDashboardScreen> createState() => _OEEDashboardScreenState();
}

class _OEEDashboardScreenState extends State<OEEDashboardScreen> {
  // Initialize the mock API service to get real-time stream data
  final OeeApiService _apiService = OeeApiService();

  @override
  void dispose() {
    // Clean up the stream controller when the widget is removed
    _apiService.dispose();
    super.dispose();
  }

  // Helper function to dynamically determine the overall OEE card color
  Color _getOEEColor(double value) {
    if (value >= AppConstants.targetOEE) return AppTheme.statusRunning;
    if (value >= 70.0) return AppTheme.statusIdle;
    return AppTheme.statusDown;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OEE Dashboard'),
      ),
      body: StreamBuilder<OEEMetric>(
        stream: _apiService.oeeStream,
        // Provide initial data to prevent a flicker while waiting for the first stream value
        initialData: OEEMetric.mock(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading OEE data: ${snapshot.error}'));
          }

          // Use the latest data from the stream
          final metrics = snapshot.data!;
          final oeeColor = _getOEEColor(metrics.overallOEE);

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              // 1. Overall OEE Metric Card (Most prominent display)
              Card(
                // Use a light version of the status color for the card background
                color: oeeColor.withOpacity(0.1),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Overall Equipment Effectiveness',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        // Display OEE value, fixed to one decimal place
                        '${metrics.overallOEE.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: oeeColor, // Use dynamic color based on status
                        ),
                      ),
                      Text(
                        'Target: ${AppConstants.targetOEE.toStringAsFixed(0)}%',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // 2. A, P, Q Breakdown (using the reusable OEEGauge widget)
              const Text(
                'OEE Factors Breakdown:', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              const Divider(height: 20),

              // Availability (A)
              OEEGauge(
                title: 'Availability (A)',
                value: metrics.availability,
                color: Colors.blue.shade700,
              ),
              const SizedBox(height: 10),

              // Performance (P)
              OEEGauge(
                title: 'Performance (P)',
                value: metrics.performance,
                color: Colors.purple.shade700,
              ),
              const SizedBox(height: 10),

              // Quality (Q)
              OEEGauge(
                title: 'Quality (Q)',
                value: metrics.quality,
                color: Colors.teal.shade700,
              ),
              const SizedBox(height: 10),

            ],
          );
        },
      ),
    );
  }
}
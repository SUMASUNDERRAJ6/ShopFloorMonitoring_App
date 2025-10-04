import 'package:flutter/material.dart';
import 'package:shop/features/machine_monitoring/oee/models/oee_metric.dart';
import 'package:shop/features/machine_monitoring/oee/presentation/oee_gauge.dart';
import 'package:shop/features/machine_monitoring/oee/services/oee_api_service.dart';
import '../models/oee_metric.dart';
import '../../../core/app_theme.dart';
import '../../../core/constants.dart';

class OEEDashboardScreen extends StatefulWidget {
  const OEEDashboardScreen({super.key});

  @override
  State<OEEDashboardScreen> createState() => _OEEDashboardScreenState();
}

class _OEEDashboardScreenState extends State<OEEDashboardScreen> {
  final OeeApiService _apiService = OeeApiService();

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OEE Dashboard'),
      ),
      body: StreamBuilder<OEEMetric>(
        stream: _apiService.oeeStream,
        initialData: OEEMetric.mock(), // Provide initial mock data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading OEE data: ${snapshot.error}'));
          }

          final metrics = snapshot.data!;
          
          Color getOEEColor(double value) {
            if (value >= AppConstants.targetOEE) return AppTheme.statusRunning;
            if (value >= 70.0) return AppTheme.statusIdle;
            return AppTheme.statusDown;
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              // Overall OEE Metric Card (Most prominent)
              Card(
                color: getOEEColor(metrics.overallOEE).withOpacity(0.1),
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
                        '${metrics.overallOEE.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: getOEEColor(metrics.overallOEE),
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
              const SizedBox(height: 20),
              
              // A, P, Q Breakdown
              const Text('OEE Factors Breakdown:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              // Availability
              OEEGauge(
                title: 'Availability (A)',
                value: metrics.availability,
                color: Colors.blue.shade700,
              ),

              // Performance
              OEEGauge(
                title: 'Performance (P)',
                value: metrics.performance,
                color: Colors.purple.shade700,
              ),

              // Quality
              OEEGauge(
                title: 'Quality (Q)',
                value: metrics.quality,
                color: Colors.teal.shade700,
              ),
            ],
          );
        },
      ),
    );
  }
}
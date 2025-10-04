import 'dart:async';
import 'dart:math';
import '../models/oee_metric.dart';

class OeeApiService {
  // Stream controller for real-time OEE updates
  final _oeeStreamController = StreamController<OEEMetric>.broadcast();

  Stream<OEEMetric> get oeeStream => _oeeStreamController.stream;

  // Initial mock OEE data
  OEEMetric _currentOEE = OEEMetric.mock();
  
  OeeApiService() {
    // Simulate real-time OEE fluctuation every 10 seconds
    Timer.periodic(const Duration(seconds: 10), (timer) {
      _updateOEEData();
      _oeeStreamController.add(_currentOEE);
    });
  }

  void _updateOEEData() {
    final random = Random();
    
    // Function to apply slight random fluctuation
    double fluctuate(double value) {
      final change = (random.nextDouble() * 2) - 1; // Change between -1.0 and +1.0
      return (value + change).clamp(50.0, 100.0);
    }

    _currentOEE = OEEMetric(
      availability: fluctuate(_currentOEE.availability),
      performance: fluctuate(_currentOEE.performance),
      quality: fluctuate(_currentOEE.quality),
    );
  }
  
  void dispose() {
    _oeeStreamController.close();
  }
}
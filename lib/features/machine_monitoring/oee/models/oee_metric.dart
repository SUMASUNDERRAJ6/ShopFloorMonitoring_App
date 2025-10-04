class OEEMetric {
  final double availability; // A
  final double performance; // P
  final double quality;     // Q
  final double overallOEE;  // A * P * Q

  OEEMetric({
    required this.availability,
    required this.performance,
    required this.quality,
  }) : overallOEE = (availability / 100) * (performance / 100) * (quality / 100) * 100;
  
  // Factory method for mock data
  factory OEEMetric.mock() {
    return OEEMetric(
      availability: 95.0,
      performance: 90.0,
      quality: 98.0,
    );
  }
}
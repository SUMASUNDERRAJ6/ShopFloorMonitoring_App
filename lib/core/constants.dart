// APIim endpoints, static numbers, and route names

class AppConstants {
  // --- Navigation Routes ---
  static const String rootRoute = '/';
  static const String machineStatusRoute = '/status';
  static const String oeeDashboardRoute = '/oee';

  // --- API Configuration (Placeholder for a real setup) ---
  // Use a secure WebSocket connection (wss://) in production
  static const String websocketUrl = 'ws://your-api-server.com/ws/monitoring'; 
  static const Duration apiTimeout = Duration(seconds: 15);
  
  // --- Key Metrics Configuration ---
  // Defines the OEE score considered "World Class" or the application's goal
  static const double targetOEE = 85.0; 
}// TODO Implement this library.
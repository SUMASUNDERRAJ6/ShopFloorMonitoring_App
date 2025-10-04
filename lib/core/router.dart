import 'package:flutter/material.dart';
import 'package:shop/features/machine_monitoring/oee/presentation/oee_dashboard_screen.dart';
import '../features/machine_monitoring/presentation/machine_status_screen.dart';
import '../widgets/bottom_nav_bar_shell.dart'; // Import the main shell
import 'constants.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // The root route now points to the Bottom Navigation Shell
      case AppConstants.rootRoute:
        return MaterialPageRoute(builder: (_) => const BottomNavBarShell());

      // Although these screens are in the shell, defining them allows for deep-linking
      case AppConstants.machineStatusRoute:
        return MaterialPageRoute(builder: (_) => const MachineStatusScreen());
        
      case AppConstants.oeeDashboardRoute:
        return MaterialPageRoute(builder: (_) => const OEEDashboardScreen());
        
      default:
        // Fallback route for undefined paths
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text('404: No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
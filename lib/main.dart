import 'package:flutter/material.dart';
// Import the new shell widget
import 'widgets/bottom_nav_bar_shell.dart'; 

void main() {
  runApp(const ShopFloorMonitorApp());
}

class ShopFloorMonitorApp extends StatelessWidget {
  const ShopFloorMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Floor Monitor',
      debugShowCheckedModeBanner: false,
      // You can replace the hardcoded theme with the one from app_theme.dart
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      
      // REPLACE MachineStatusScreen with BottomNavBarShell
      home: const BottomNavBarShell(), 
      
      // If you implement named routes, use the router instead:
      // onGenerateRoute: AppRouter.generateRoute,
      // initialRoute: AppConstants.machineStatusRoute,
    );
  }
}
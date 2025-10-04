import 'package:flutter/material.dart';
import 'package:shop/features/machine_monitoring/oee/presentation/oee_dashboard_screen.dart';
import '../features/machine_monitoring/presentation/machine_status_screen.dart';

class BottomNavBarShell extends StatefulWidget {
  const BottomNavBarShell({super.key});

  @override
  State<BottomNavBarShell> createState() => _BottomNavBarShellState();
}

class _BottomNavBarShellState extends State<BottomNavBarShell> {
  int _selectedIndex = 0;

  // 1. List of screens corresponding to the navigation items
  static const List<Widget> _widgetOptions = <Widget>[
    MachineStatusScreen(),
    OEEDashboardScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2. Display the selected screen
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      // 3. Define the Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Machine Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'OEE Dashboard',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped, // Call handler on tap
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(const CorruptionTrackerApp());
}

class CorruptionTrackerApp extends StatelessWidget {
  const CorruptionTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corruption Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SubmitReportScreen(),
    ViewReportsScreen(),
    BudgetScreen(),
    AdminLoginScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _bottomItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Submit'),
    BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Reports'),
    BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Budgets'),
    BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: 'Admin'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Placeholder Screens

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("Home Page"));
}

class SubmitReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("Submit Report Page"));
}

class ViewReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("View Reports Page"));
}

class BudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("Budgets Page"));
}

class AdminLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("Admin Login Page"));
}
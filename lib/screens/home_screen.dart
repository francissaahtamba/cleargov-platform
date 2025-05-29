import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ClearGov Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/submit'),
              child: const Text('Submit Report'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/view'),
              child: const Text('View Reports'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/budgets'),
              child: const Text('View Budgets'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/admin'),
              child: const Text('Admin Login'),
            ),
          ],
        ),
      ),
    );
  }
}
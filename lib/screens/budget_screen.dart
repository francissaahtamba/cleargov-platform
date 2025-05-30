import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<dynamic> budgets = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchBudgets();
  }

  Future<void> fetchBudgets() async {
    final url = Uri.parse('https://cleargov-platform-vxh2.onrender.com/api/budgets/');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          budgets = data;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load budgets (Status: ${response.statusCode})';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: budgets.length,
                  itemBuilder: (context, index) {
                    final budget = budgets[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(budget['title'] ?? 'No Title'),
                        subtitle: Text('Year: ${budget['year']} | Amount: \$${budget['amount']}'),
                      ),
                    );
                  },
                ),
    );
  }
}
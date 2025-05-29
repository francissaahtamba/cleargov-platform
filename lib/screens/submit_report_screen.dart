import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubmitReportScreen extends StatefulWidget {
  const SubmitReportScreen({super.key});

  @override
  State<SubmitReportScreen> createState() => _SubmitReportScreenState();
}

class _SubmitReportScreenState extends State<SubmitReportScreen> {
  final _formKey = GlobalKey<FormState>();

  String _fullName = '';
  String _email = '';
  String _title = '';
  String _description = '';
  String _location = '';
  DateTime _selectedDate = DateTime.now();

 Future<void> _submitForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    final url = Uri.parse('http://<your_django_server>/api/reports/'); // Replace with actual endpoint

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'full_name': _fullName,
        'email': _email,
        'title': _title,
        'description': _description,
        'location': _location,
        'date': _selectedDate.toIso8601String(),
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report submitted successfully!')),
      );
      _formKey.currentState!.reset();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit report')),
      );
    }
  }
}

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Report')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                onSaved: (value) => _fullName = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your full name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                onSaved: (value) => _description = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                onSaved: (value) => _location = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a location' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text('Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
                  const Spacer(),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
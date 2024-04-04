import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your age';
                  }
                  final age = int.tryParse(value);
                  if (age == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
                onSaved: (value) => _age = int.parse(value!),
              ),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _saveData();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData() async {
    final collectionName = _age! >= 18 ? 'senior' : 'junior';

    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .add({'name': _name, 'age': _age});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved successfully!')),
      );
    } catch (error) {
      print('Error saving data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('An error occurred while saving data. Please try again.')),
      );
    }
  }
}

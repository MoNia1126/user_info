import 'package:firestore_user_info/screens/display_data.dart';
import 'package:firestore_user_info/models/user_firebase_model.dart';
import 'package:firestore_user_info/services/user_firebase_services.dart';
import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();
  final UserFirebaseServices _userFirebaseServices = UserFirebaseServices();

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = UserFirebaseModel(
          id: '',
          name: _nameController.text,
          age: int.parse(_ageController.text),
          hobby: _hobbyController.text,
        );
        await _userFirebaseServices.addUser(user);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data saved successfully!')),
        );
        _nameController.clear();
        _ageController.clear();
        _hobbyController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hobbyController,
                decoration: InputDecoration(labelText: 'Favorite Hobby'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your favorite hobby';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Save Data'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DisplayData()),
                  );
                },
                child: Text('View Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:exercise_app/bmi_bmr/controllers/todo.dart';
import 'package:exercise_app/bmi_bmr/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

class ResetPassPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? _email;

  void _ResetPassApp(BuildContext context) async {
    bool result = await TodoController().ResetPassApp(_email.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('กรุณาไปตรวจสอบ ที่ Email ขอบคุณ')),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 30,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Reset Account",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _ResetPassApp(context);
                        //Navigator.pop(context);
                      }
                    },
                    child: PrimaryButton(buttonText: 'Reset Pass'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

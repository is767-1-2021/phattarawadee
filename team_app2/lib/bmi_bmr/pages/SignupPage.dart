// ignore_for_file: file_names

import 'package:exercise_app/bmi_bmr/controllers/todo.dart';
import 'package:exercise_app/bmi_bmr/models/PatienModel.dart';
import 'package:exercise_app/bmi_bmr/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  String? _firstName, _lastName, _email, _cid, _password;

  void _SignUpApp(BuildContext context) async {
    PatienModel _patienModel = PatienModel(
        first_name: _firstName, lastname: _lastName, email: _email, cid: _cid);
    bool result =
        await TodoController().SignupApp(_patienModel, _password.toString());
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
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
              bottom: 60,
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
                    "Create Account",
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
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your firstname',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter firstname.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _firstName = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your lastname',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter lastname.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _lastName = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your cid',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter cid.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _cid = value;
                    },
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your password',
                      suffixIcon: Icon(Icons.vpn_key),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter cid.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _SignUpApp(context);
                        //Navigator.pop(context);
                      }
                    },
                    child: PrimaryButton(buttonText: 'Sing Up'),
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

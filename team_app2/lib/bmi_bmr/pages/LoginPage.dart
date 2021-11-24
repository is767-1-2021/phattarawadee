// ignore_for_file: file_names

import 'package:exercise_app/bmi_bmr/controllers/todo.dart';
import 'package:exercise_app/bmi_bmr/pages/BMI_Data_Screen.dart';
import 'package:exercise_app/bmi_bmr/pages/ResetPassPage.dart';
import 'package:exercise_app/bmi_bmr/widgets/login_form.dart';
import 'package:exercise_app/bmi_bmr/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  void _loginApp(String _email, String _pass, BuildContext context) async {
    bool authen = await TodoController().AuthenApp(_email, _pass);
    if (authen) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BMI_Data_Screen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                Row(
                  children: [
                    const Text("This is a OnDiet app."),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Signup');
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                LogInForm(_email, _pass),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPassPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    _loginApp(_email.text, _pass.text, context);
                  },
                  child: PrimaryButton(buttonText: 'Login'),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

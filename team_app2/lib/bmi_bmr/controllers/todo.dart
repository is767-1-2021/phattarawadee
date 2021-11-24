import 'package:exercise_app/bmi_bmr/models/BMIModel.dart';
import 'package:exercise_app/bmi_bmr/models/PatienModel.dart';
import 'package:exercise_app/bmi_bmr/pages/ResultFemale.dart';
import 'package:exercise_app/bmi_bmr/pages/Resultmale.dart';
import 'package:exercise_app/bmi_bmr/services/bmi_service.dart';
import 'package:exercise_app/bmi_bmr/services/patien_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class TodoController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future getBmi(BMIModel bmiModel, BuildContext context) async {
    if (bmiModel.sex == "Male") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultMale(
            bmiModel: bmiModel,
            bmrModel: bmiModel.bmr.toStringAsFixed(2),
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultFemale(
            bmiModel: bmiModel,
            bmrModel: bmiModel.bmr.toStringAsFixed(2),
          ),
        ),
      );
    }
  }

  Future addBmi(BMIModel _bmiModel, context) async {
    await ServiceBmi().AddBmi(_bmiModel);
    if (_bmiModel.sex == "Female") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultFemale(
            bmiModel: _bmiModel,
            bmrModel: _bmiModel.toString(),
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultMale(
            bmiModel: _bmiModel,
            bmrModel: _bmiModel.toString(),
          ),
        ),
      );
    }
  }

  Future<bool> AuthenApp(String _email, String _pass) async {
    bool result = false;
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: _email, password: _pass);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<bool> SignupApp(PatienModel patienModel, String pass) async {
    bool result = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: patienModel.email.toString(), password: pass);
      await PatienService().addPatien(patienModel);
      result = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<bool> ResetPassApp(String email) async {
    bool result = false;
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) => result = true);

    return result;
  }

  Future SignOutApp() async {
    await FirebaseAuth.instance.signOut();
  }
}

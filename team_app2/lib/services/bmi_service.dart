import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/model/BMIModel.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ServiceBmi {
  Future AddBmi(String sex, BMIModel bmiModel) async {
    await _firestore.collection("Ondiet_bmi").add({
      'bmi': bmiModel.bmi,
      'bmr': bmiModel.bmr,
      'sex': sex,
      'isNormal': bmiModel.isNormal,
      'isUnder': bmiModel.isUnder,
      'isOver': bmiModel.isOver,
    }).then((value) => print('User Add'));
  }
}

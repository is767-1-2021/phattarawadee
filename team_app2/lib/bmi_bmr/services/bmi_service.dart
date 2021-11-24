import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/bmi_bmr/models/BMIModel.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ServiceBmi {
  Future AddBmi(BMIModel bmiModel) async {
    await _firestore.collection("Ondiet_bmi").add({
      'height': bmiModel.height,
      'weight': bmiModel.weight,
      'age': bmiModel.age,
      'bmi': bmiModel.bmi,
      'bmr': bmiModel.bmr,
      'sex': bmiModel.sex,
      'isNormal': bmiModel.isNormal,
      'isUnder': bmiModel.isUnder,
      'isOver': bmiModel.isOver,
      'date': DateTime.now(),
    }).then((value) => print('User Add'));
  }
}

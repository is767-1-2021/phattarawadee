import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/bmi_bmr/models/PatienModel.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class PatienService {
  addPatien(PatienModel _patienModel) async {
    await _firestore.collection("Ondiet_patien").add({
      'first_name': _patienModel.first_name,
      'last_name': _patienModel.lastname,
      'email': _patienModel.email,
      'cid': _patienModel.cid,
    }).then((value) => print('User Patien'));
  }
}

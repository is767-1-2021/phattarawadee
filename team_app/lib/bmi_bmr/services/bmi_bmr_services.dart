//import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/bmi_bmr/model/bmi_bmr_model.dart';

abstract class Services {
  Future<List<BMI>> getBMIs();
  Future<void> updateBMIs(int idl, bool completed);
}

class FirebaseServices extends Services {
  @override
  Future<List<BMI>> getBMIs() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('BMIs').get();

    AllBMIs BMIs = AllBMIs.fromSnapshot(snapshot);
    return BMIs.BMIs;
  }

  @override
  Future<void> updateBMIs(int _id, bool completed) async {
    CollectionReference _ref =
        await FirebaseFirestore.instance.collection('BMIs');
    FirebaseFirestore.instance
        .collection('BMIs')
        .where('id', isEqualTo: _id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _ref
            .doc(doc.id)
            .update({'completed': completed})
            .then((value) => print("BMIs Updated"))
            .catchError((error) => print("Failed to update BMIs : $error"));
      });
    });
  }
}

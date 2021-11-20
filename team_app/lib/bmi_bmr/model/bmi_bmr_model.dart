import 'package:cloud_firestore/cloud_firestore.dart';

class BMI {
  double bmi;
  double bmrf;
  double bmrm;
  late bool isNormal;
  late bool isUnder;
  late bool isOver;
  late String comments;

  BMI(this.bmi, this.bmrf, this.bmrm,
      {bool? isNormal, bool? isUnder, bool? isOver, String? comments});

  factory BMI.fromJson(
    Map<String, dynamic> json,
  ) {
    return BMI(
      json['bmi'] as double,
      json['bmrf'] as double,
      json['bmrm'] as double,
    );
  }
}

class AllBMIs {
  final List<BMI> BMIs;
  AllBMIs(this.BMIs);
  factory AllBMIs.fromJson(List<dynamic> json) {
    List<BMI> BMIs;
    BMIs = json.map((index) => BMI.fromJson(index)).toList();

    return AllBMIs(BMIs);
  }

  factory AllBMIs.fromSnapshot(QuerySnapshot s) {
    List<BMI> BMIs = s.docs.map((DocumentSnapshot ds) {
      return BMI.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();

    return AllBMIs(BMIs);
  }
}

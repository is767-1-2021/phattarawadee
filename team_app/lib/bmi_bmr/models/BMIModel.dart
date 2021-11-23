// ignore_for_file: file_names

class BMIModel {
  double bmi;
  double bmr;
  bool isNormal;
  bool isUnder;
  bool isOver;
  String comments;
  BMIModel(
      {required this.bmi,
      required this.bmr,
      required this.isNormal,
      required this.isOver,
      required this.isUnder,
      required this.comments});
}

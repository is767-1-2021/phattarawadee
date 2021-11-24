// ignore_for_file: file_names

class BMIModel {
  int weight;
  int height;
  int age;
  double bmi;
  double bmr;
  bool isNormal;
  bool isUnder;
  bool isOver;
  String comments;
  String sex;
  BMIModel(
      {required this.weight,
      required this.height,
      required this.age,
      required this.bmi,
      required this.bmr,
      required this.isNormal,
      required this.isOver,
      required this.isUnder,
      required this.comments,
      required this.sex});
}

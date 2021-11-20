import 'dart:async';

import 'package:team_app/bmi_bmr/model/bmi_bmr_model.dart';
import 'package:team_app/bmi_bmr/services/bmi_bmr_services.dart';

class BMIController {
  final Services services;
  List<BMI> BMIs = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  BMIController(this.services);

  Future<List<BMI>> fectBMIs() async {
    onSyncController.add(true);
    BMIs = await services.getBMIs();
    onSyncController.add(false);
    return BMIs;
  }

  Future<void> updateBMI(int id, bool completed) async {
    await services.updateBMIs(id, completed);
  }
}

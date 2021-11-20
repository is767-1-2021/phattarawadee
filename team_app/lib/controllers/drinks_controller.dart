import 'dart:async';

import 'package:team_app/models/drink.dart';
import 'package:team_app/services/drinks_services.dart';

class DrinkController{
  final Services services;
  List<Drink> drinks = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  DrinkController(this.services);

  Future<List<Drink>> fectDrinks() async{
    onSyncController.add(true);
    drinks = await services.getDrinks();
    onSyncController.add(false);
    return drinks;
  }

}
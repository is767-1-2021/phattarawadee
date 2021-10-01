import 'package:flutter/material.dart';

class FirstFormModel extends ChangeNotifier {
  String? _diet = 'None';
  String? _meal;
  int? _calories;
  int _counter = 0;

  get diet => this._diet;
  set diet( value) {
    this._diet = value;
    notifyListeners();
  } 

  get meal => this._meal;
  set meal( value) {
    this._meal = value;
    notifyListeners();
  } 

  get calories => this._calories;
  set calories( value) {
    this._calories = value;
    notifyListeners();
  } 

  get counter => this._counter;
  set counter( value) {
    this._counter = value;
    notifyListeners();
  } 
}
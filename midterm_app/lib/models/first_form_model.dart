import 'package:flutter/material.dart';

class FirstFormModel extends ChangeNotifier {
  String? _drinks;
  int? _calories;
  String? _date;
  
  get date => this._date;
  set date (value) {
    this._date = value;
    notifyListeners();
  } 
  
  get drinks => this._drinks;
  set drinks (value) {
    this._drinks = value;
    notifyListeners();
  } 

  get calories => this._calories;
  set calories (value) {
    this._calories = value;
    notifyListeners();
  } 
  
}
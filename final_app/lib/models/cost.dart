import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Cost{

  String costid = '';
  String title = "";
  double totalamount = 0;
  double amount = 0;
  int list = 0;
  bool icon = true;
  int userlistSelected = 0;
  double userBasedamount = 0;

  Cost(Map data)
  {
    costid = data["costid"];
    title = data["title"];
    totalamount = data['totalamount'];
    amount = data['amount'];
    list = data['list'];
    icon = data['icon'];
    userlistSelected = data['userlistSelected'];
    userBasedamount = data['userBasedamount'];
  }

  Cost.fromEmpty(); 

  Map<String, dynamic> toJson() {
    return {
      "costid": this.costid,
      "title": this.title,
      "totalamount": this.totalamount, 
      "amount": this.amount, 
      "list": this.list,     
      "icon": this.icon,  
      "userlistSelected": this.userlistSelected,    
      "userBasedamount": this.userBasedamount,    
      
    };
  }

  Cost.fromSavedJson(Map<String, dynamic> data) {
    costid = data["costid"];
    title = data["title"];
    totalamount = data['totalamount'];
    amount = data['amount'];
    list = data['list'];
    icon = data['icon'];
    userlistSelected = data['userlistSelected'];
    userBasedamount = data['userBasedamount'];
    
  }
static Future<void> saveCostsForDate(DateTime dateTime, List<Cost> costList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savingList = [];
    for(int i =0; i < costList.length; i ++)
    {
      Map<String, dynamic> json = costList[i].toJson();
      String newAddition = jsonEncode(Cost.fromSavedJson(json));
      savingList.add(newAddition);
    }
    String dateTimeKey = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    await prefs.setStringList(dateTimeKey, savingList);
  }

  static Future getSavedCostsForDate(DateTime dateTime) async {
    String dateTimeKey = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    List<Cost> savedListForDate = [];
    final prefs = await SharedPreferences.getInstance();
    List<String> alreadySaved = prefs.getStringList('$dateTimeKey') ?? [];
    for(int i=0; i < alreadySaved.length; i++)
    {
      Map<String, dynamic> decodeList = jsonDecode(alreadySaved[i]);
      Cost cost = Cost.fromSavedJson(decodeList);
      savedListForDate.add(cost);
    }
    return savedListForDate;
  }
}

class CostModel extends ChangeNotifier {
  String? _costid;
  String? _title;
  double _totalamount = 0;
  int _amount = 0;
  int _list = 0;
  bool _icon = true;
  

 get costid => this._costid;

  set costid(value) {
    this._costid = value;
    notifyListeners();
  }

  get title => this._title;

  set title(value) {
    this._title = value;
    notifyListeners();
  }

  get totalamount => this._totalamount;

  set totalamount(value) {
    this._totalamount = value;
    notifyListeners();
  }

  get amount => this._amount;

  set amount(value) {
    this._amount = value;
    notifyListeners();
  }

  get list => this._list;

  set list(value) {
    this._list = value;
    notifyListeners();
  }

  get icon => this._icon;

  set icon(value) {
    this._icon = value;
    notifyListeners();
  }
}
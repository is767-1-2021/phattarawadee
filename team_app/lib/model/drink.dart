import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Drink{

  String drinkId = '';
  String drinkName = "";
  int drinkKCalPerCup = 0;
  int totalCups = 0;
  int userCupSelected = 0;
  int userBasedCalories = 0;

  Drink(Map data)
  {
    drinkId = data["drinkId"];
    drinkName = data["drinkName"];
    totalCups = data['totalCups'];
    drinkKCalPerCup =  data["kcal"];
    userCupSelected = data["userCupSelected"];
    userBasedCalories = data["userBasedCalories"];
  }

  Drink.fromEmpty(); 

  Map<String, dynamic> toJson() {
    return {
      "drinkId": this.drinkId,
      "drinkName": this.drinkName,
      "totalCups": this.totalCups,    
      "drinkKCalPerCup": this.drinkKCalPerCup, 
      "userCupSelected" : this.userCupSelected,   
      "userBasedCalories": this.userBasedCalories 
    };
  }

  Drink.fromSavedJson(Map<String, dynamic> data) {
    drinkId = data["drinkId"];
    drinkName = data["drinkName"];
    totalCups = data['totalCups'];
    drinkKCalPerCup =  data["drinkKCalPerCup"];
    userCupSelected = data["userCupSelected"];
    userBasedCalories = data["userBasedCalories"];
    
  }

  static Future<void> saveDrinksForDate(DateTime dateTime, List<Drink> drinkList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savingList = [];
    for(int i =0; i < drinkList.length; i ++)
    {
      Map<String, dynamic> json = drinkList[i].toJson();
      String newAddition = jsonEncode(Drink.fromSavedJson(json));
      savingList.add(newAddition);
    }
    String dateTimeKey = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    await prefs.setStringList(dateTimeKey, savingList);
  }

  static Future getSavedDrinksForDate(DateTime dateTime) async {
    String dateTimeKey = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    List<Drink> savedListForDate = [];
    final prefs = await SharedPreferences.getInstance();
    List<String> alreadySaved = prefs.getStringList('$dateTimeKey') ?? [];
    for(int i=0; i < alreadySaved.length; i++)
    {
      Map<String, dynamic> decodeList = jsonDecode(alreadySaved[i]);
      Drink drink = Drink.fromSavedJson(decodeList);
      savedListForDate.add(drink);
    }
    return savedListForDate;
  }
}
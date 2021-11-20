import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Drink{

  String drinkId = '';
  String drinkName = "";
  int drinkKCalPerCup = 0;
  int totalCups = 0;
  double caloriesPerMinute = 0;
  int userTimeMinutesSelected = 0;
  String userTimeSelected = '';
  int userTimeBasedCalories = 0;

  Drink(Map data)
  {
    drinkId = data["drinkId"];
    drinkName = data["drinkName"];
    totalCups = data['totalCups'];
    drinkKCalPerCup =  data["kcal"];
    caloriesPerMinute =  data["timePerMinute"];
  }

  Drink.fromEmpty(); 

  Map<String, dynamic> toJson() {
    return {
      "drinkId": this.drinkId,
      "drinkName": this.drinkName,
      "totalCups": this.totalCups,    
      "drinkKCalPerCup": this.drinkKCalPerCup,    
      "caloriesPerMinute": this.caloriesPerMinute,  
      "userTimeMinutesSelected": this.userTimeMinutesSelected,  
      "userTimeSelected": this.userTimeSelected,  
      "userTimeBasedCalories": this.userTimeBasedCalories,  
    };
  }

  Drink.fromSavedJson(Map<String, dynamic> data) {
    drinkId = data["drinkId"];
    drinkName = data["drinkName"];
    totalCups = data['totalCups'];
    drinkKCalPerCup =  data["drinkKCalPerCup"];
    caloriesPerMinute =  data["caloriesPerMinute"];
    userTimeMinutesSelected =  data["userTimeMinutesSelected"];
    userTimeSelected =  data["userTimeSelected"];
    userTimeBasedCalories =  data["userTimeBasedCalories"];
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
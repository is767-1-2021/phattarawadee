import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/models/drink.dart';


abstract class Services {
  Future<List<Drink>> getDrinks();
  Future<String> addDrinks(Drink value);
}

class FirebaseServices extends Services {
  @override
  Future<List<Drink>> getDrinks() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('drinks').get();

    AllDrinks drinks = AllDrinks.fromSnapshot(snapshot);
    return drinks.drinks;
  }
 Future<String> addDrinks(Drink value) async {
    DocumentReference ref =
        await FirebaseFirestore.instance.collection('drinks').add({
      'id': value.id,
      'drinks': value.drinks,
      'calories': value.calories,
      'date': value.date,
    });

    return ref.id;
  }
}
   
    
  



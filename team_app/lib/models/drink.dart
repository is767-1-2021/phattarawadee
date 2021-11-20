import 'package:cloud_firestore/cloud_firestore.dart';

class Drink {
  final int id;
  final String drinks;
  final int calories;
  final String date;
  

  Drink(this.id,this.drinks, this.calories, this.date);

  factory Drink.fromJson(
    Map<String, dynamic> json,
  ) {
    return Drink(
      json['id'] as int,
      json['drinks'] as String,
      json['calories'] as int,
      json['date'] as String,
    );
  }

}

class AllDrinks {
  final List<Drink> drinks;
  AllDrinks(this.drinks);
  factory AllDrinks.fromJson(List<dynamic> json) {
    List<Drink> drinks;
    drinks = json.map((index) => Drink.fromJson(index)).toList();

    return AllDrinks(drinks);
  }

  factory AllDrinks.fromSnapshot(QuerySnapshot s) {
    List<Drink> drinks = s.docs.map((DocumentSnapshot ds) {
      return Drink.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();

    return AllDrinks(drinks);
  }
  
}
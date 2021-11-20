import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_app/models/drinks_form_model.dart';
import 'package:provider/provider.dart';
import 'package:team_app/controllers/drinks_controller.dart';
import 'package:team_app/pages/drink_history_page.dart';
import 'package:team_app/services/drinks_services.dart';

class Drinks extends StatelessWidget{ 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('Drinks Record',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0),
        ),
      ),
      body: MyCustomDrinksForm(),
    );
  }
}

class MyCustomDrinksForm extends StatefulWidget{
  @override
  _MyCustomDrinksFormState createState() => _MyCustomDrinksFormState();
}

class _MyCustomDrinksFormState extends State<MyCustomDrinksForm> {
  final _formKey = GlobalKey<FormState>();
  int? _id;
  String? _drinks;
  int? _calories;
  String? _date;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, 
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter date',
              icon: Icon(Icons.calendar_today),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter date.';
              }
              return null;
            },
            onSaved: (value) {
              _date = value;
            },
            initialValue: context.read<DrinksFormModel>().date,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your drinks',
              icon: Icon(Icons.fastfood),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter drinks.';
              }
              return null;
            },
            onSaved: (value) {
               _drinks = value;
            },
            initialValue: context.read<DrinksFormModel>().drinks,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Calories',
              icon: Icon(Icons.monitor_weight),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Calories.';
              }
              if (int.parse(value) < 0) {
                return 'Please enter valid Calories.';
              }
              return null;
            },
            onSaved: (value) {
              _calories = int.parse(value!);
            },
            initialValue: context.read<DrinksFormModel>().calories.toString(),
          ),           
          Divider(
            height: 32.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                    
                  } 
                ),
              ),  
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () async {
                    var services = FirebaseServices();
                    var controller = DrinkController(services);
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      await FirebaseFirestore.instance
                      .collection('group_deals')
                      .add({
                    'createddrinks': 'drinks',
                    'id': _id,
                    'drinks': _drinks,
                    'calories': _calories,
                    'date': _date,
                   
                  });
                  /*ใส่ function addDeal*/
                  /*ใส่ snackbar โชว์ว่าอัพเดทไปแล้ว*/
                  /*pushReplacement ให้ใส่หน้าใหม่เข้ามาแทน+รีเฟรชด้วย แทนหน้าเดิม*/
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DrinksHistory(controller: controller)));
                }
              },
                
              

                     /* context.read<DrinksFormModel>().date = _date;
                      context.read<DrinksFormModel>().drinks = _drinks;
                      context.read<DrinksFormModel>().calories = _calories;
                      
                      Navigator.pop(context);
                      */
              
                    
                    
                ),
                ),
            ],
          ),
        ],
      ),
      );
  }
}
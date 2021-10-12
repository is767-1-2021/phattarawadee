import 'package:flutter/material.dart';
import 'package:team_app/models/drinks_form_model.dart';
import 'package:provider/provider.dart';

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
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      context.read<DrinksFormModel>().date = _date;
                      context.read<DrinksFormModel>().drinks = _drinks;
                      context.read<DrinksFormModel>().calories = _calories;
                      
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
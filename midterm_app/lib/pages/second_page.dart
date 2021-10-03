import 'package:flutter/material.dart';
import 'package:midterm_app/models/first_form_model.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatelessWidget{ 
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
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget{
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
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
            initialValue: context.read<FirstFormModel>().date,
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
            initialValue: context.read<FirstFormModel>().drinks,
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
            initialValue: context.read<FirstFormModel>().calories.toString(),
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

                      context.read<FirstFormModel>().date = _date;
                      context.read<FirstFormModel>().drinks = _drinks;
                      context.read<FirstFormModel>().calories = _calories;
                      
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
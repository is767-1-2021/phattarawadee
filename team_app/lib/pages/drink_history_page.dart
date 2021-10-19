import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app/models/drinks_form_model.dart';

class DrinksHistory extends StatefulWidget{
  @override
  _DrinksHistoryState createState() => _DrinksHistoryState();
}
class _DrinksHistoryState extends State<DrinksHistory> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('My History',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0),
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.notification_add
            )
          ),
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.settings
            )
          ),
        ],
      ), 
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Consumer <DrinksFormModel> (
                builder: (context, form, child) {
                  return Text ('Today ${form.date}, You drink ${form.drinks}  ${form.calories} kcal');
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/2');               
              },
              child: Text('Fill this form please'),
            ),
            Divider(
                height: 32.0,
            ),   
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      child: Center(child: Text('Date')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    Container(
                      child: Center(child: Text('Drinks')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    Container(
                      child: Center(child: Text('Calories')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      child: Center(child: Text('02/10/2021')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    Container(
                      child: Center(child: Text('Tea')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    Container(
                      child: Center(child: Text('100')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                     Container(
                      child: Center(child: Text('01/10/2021')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    Container(
                      child: Center(child: Text('Matcha Latte')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    Container(
                      child: Center(child: Text('350')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      child: Center(child: Text('30/09/2021')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    Container(
                      child: Center(child: Text('Lemon Tea')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    Container(
                      child: Center(child: Text('250')),
                      padding: EdgeInsets.all(5.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),  
    );
  }
}
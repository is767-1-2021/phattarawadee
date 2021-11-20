import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app/models/drink.dart';
import 'package:team_app/models/drinks_form_model.dart';
import 'package:team_app/controllers/drinks_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/services/drinks_services.dart';

class DrinksHistory extends StatefulWidget{
  final DrinkController controller;
  DrinksHistory({required this.controller});

  @override
  _DrinksHistoryState createState() => _DrinksHistoryState();
}
class _DrinksHistoryState extends State<DrinksHistory> {
List<Drink> drinks = List.empty();
  bool isLoading = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    _getDrinks();
    super.initState();

    widget.controller.onSync
        .listen((bool synState) => setState(() => isLoading = synState));
  }

  void _getDrinks() async {
    var newDrinks = await widget.controller.fectDrinks();

    setState(() {
      drinks = newDrinks;
    });
  }
   Widget get body => isLoading
      ? CircularProgressIndicator()
      : SingleChildScrollView(
         physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 5),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    itemCount: drinks.isEmpty ? 1 : drinks.length,
                    itemBuilder: (BuildContext context, int index) {
                      Drink ds = drinks[index];
                      if (drinks.isNotEmpty) {
                        return InkWell(
                          onTap: () {
                          },
                          child: Card(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Container(
                              width: double.infinity,
                              height: 100.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /*Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: 70.0,
                                      height: 70.0,
                                      child: Icon(
                                        drinks[index].category ==
                                                'id'
                                            ? Icons.dinner_dining
                                            : drinks[index].category ==
                                                    'drinks'
                                                ? Icons.tv
                                                : drinks[index].category ==
                                                        'cal'
                                                    ? Icons.landscape
                                                    : drinks[index].category ==
                                                            'date'
                                      
                                                            ? Icons.money
                                                            : null,
                                        size: 35.0,
                                      ),
                                    ),
                                  ),*/
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(drinks[index].id.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0)),
                                        Text(drinks[index].drinks,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 16.0)),
                                        Wrap(
                                          spacing: 100.0,
                                          children: [
                                            Text(
                                              drinks[index].calories.toString(),
                                              style: TextStyle(fontSize: 14.0),
                                            ),
                                            Text(drinks[index].date,
                                                style:
                                                    TextStyle(fontSize: 14.0)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                        width: 35.0,
                                        height: 35.0,
                                        child: Icon(Icons.favorite_border)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Text('');
                      }
                      } //     snapshot.data!.docs[index];
                    ),
              )
            ],
          ),
        );

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
     /* body: Center(
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
      */ 
    );
  }
}
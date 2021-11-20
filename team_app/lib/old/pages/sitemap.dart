import 'package:exercise_app/old/pages/cat.dart';
import 'package:exercise_app/old/pages/webview.dart';
import 'package:exercise_app/old/update/form.dart';
import 'package:exercise_app/screens/home/home.dart';
import 'package:flutter/material.dart';
//import 'package:team_app/pages/score.dart';
//import 'package:team_app/pages/workout_result.dart';
import 'BMICalculatorScreen.dart';
import 'menu_page.dart';

class sitemap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Container(
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BMICalculatorScreen()));
                    },
                    icon: Icon(
                      Icons.health_and_safety_sharp,
                      color: Colors.pink,
                    ),
                    label: Text("Check BMI&BMR"),
                    style: TextButton.styleFrom(
                      primary: Colors.orangeAccent,
                      backgroundColor: Colors.pink[900],
                      onSurface: Colors.black12,
                    )),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
              Container(
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    icon: Icon(
                      Icons.forward,
                      color: Colors.pink,
                    ),
                    label: Text("Exercise Record"),
                    style: TextButton.styleFrom(
                      primary: Colors.orangeAccent,
                      backgroundColor: Colors.purple[800],
                      onSurface: Colors.black12,
                    )),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
              Container(
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewExample()));
                    },
                    icon: Icon(
                      Icons.local_pizza,
                      color: Colors.pink,
                    ),
                    label: Text("News"),
                    style: TextButton.styleFrom(
                      primary: Colors.orangeAccent,
                      backgroundColor: Colors.green[900],
                      onSurface: Colors.black12,
                    )),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
              Container(
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormScreen()));
                    },
                    icon: Icon(
                      Icons.wine_bar,
                      color: Colors.pink,
                    ),
                    label: Text("Meal Record"),
                    style: TextButton.styleFrom(
                      primary: Colors.orangeAccent,
                      backgroundColor: Colors.blue[900],
                      onSurface: Colors.black12,
                    )),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
              Container(
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cat()));
                    },
                    icon: Icon(
                      Icons.food_bank,
                      color: Colors.pink,
                    ),
                    label: Text("Tips"),
                    style: TextButton.styleFrom(
                      primary: Colors.orangeAccent,
                      backgroundColor: Colors.redAccent,
                      onSurface: Colors.black12,
                    )),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
              Container(
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MenuPage()));
                    },
                    icon: Icon(
                      Icons.umbrella,
                      color: Colors.pink,
                    ),
                    label: Text("Recipe"),
                    style: TextButton.styleFrom(
                      primary: Colors.orangeAccent,
                      backgroundColor: Colors.teal[900],
                      onSurface: Colors.black12,
                    )),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "HOME",
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 56,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

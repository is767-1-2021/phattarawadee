import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:team_app/pages/score.dart';
import 'package:team_app/pages/menu_page.dart';
import 'package:team_app/pages/workout_result.dart';
import 'BMICalculatorScreen.dart';
import 'Home_menu.dart';
import 'note_result.dart';


class Sitemap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('On-diet app',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0),
        ),
      
      centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.menu),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                "HOME",
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 56,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8,
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
                      color: Colors.teal[900],
                    ),
                    label: Text("BMI"),
                    style: TextButton.styleFrom(
                      primary: Colors.teal[900],
                      backgroundColor: Colors.tealAccent[400],
                      onSurface: Colors.black12,
                    )),
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
              Container(
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    icon: Icon(
                      Icons.forward,
                      color: Colors.pink,
                    ),
                    label: Text("Home"),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FirstPage()));
                    },
                    icon: Icon(
                      Icons.local_pizza,
                      color: Colors.pink,
                    ),
                    label: Text("ประเมิณ"),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => result()));
                    },
                    icon: Icon(
                      Icons.wine_bar,
                      color: Colors.pink,
                    ),
                    label: Text("workout"),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => noteresult()));
                    },
                    icon: Icon(
                      Icons.food_bank,
                      color: Colors.pink,
                    ),
                    label: Text("meal"),
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
                    label: Text("menu"),
                    style: TextButton.styleFrom(
                      primary: Colors.orangeAccent,
                      backgroundColor: Colors.teal[900],
                      onSurface: Colors.black12,
                    )),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
    backgroundColor: Colors.tealAccent,
    items: <Widget>[
       Icon(Icons.home,size: 30), 
       Icon(Icons.menu, size: 30),
      Icon(Icons.compare_arrows, size: 30),
       Icon(Icons.person, size: 30),
    ],
    animationDuration: Duration(milliseconds: 200),
    index: 2,
    animationCurve: Curves.bounceInOut,
    onTap: (index) {
       Navigator.pushNamed(context, '/${index+1}');
     
      //Handle button tap
    },
  ),
    );
  }
}

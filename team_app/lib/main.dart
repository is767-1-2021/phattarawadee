import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/first_form_model.dart';
import 'models/food_form_model.dart';
import 'pages/BMICalculatorScreen.dart';
import 'pages/Home_menu.dart';
import 'pages/note_page.dart';
import 'pages/workout.dart';
import 'pages/sitemap.dart';
import 'pages/menu_page.dart';
import 'pages/daily_meal.dart';
import 'pages/score_result.dart';
import 'pages/welcome.dart';
import 'pages/workout_result.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FirstFormModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FoodFormModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.greenAccent,
          scaffoldBackgroundColor: Colors.teal[50],
         textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black,
          fontFamily: 'Montserrat',),
      
          
        ),
        ),
    
        initialRoute: '/1',
        routes: <String, WidgetBuilder>{
          '/1': (context) => Welcome(),
          '/2': (context) => BMICalculatorScreen(),
          '/3': (context) => Sitemap(),
          '/4': (context) => workout(),
          '/5': (context) => meal(),
          '/6': (context) => MenuPage(),
          '/7': (context) => SixthPage(),
          '/8': (context) => Home(),
          '/9': (context) => workout(),
          '/10': (context) => result(),
          '/11': (context) => NotePage(),
          
        });
  }
}

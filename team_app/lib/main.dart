import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app/controllers/drinks_controller.dart';
import 'package:team_app/models/drinks_form_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/services/drinks_services.dart';
import 'package:team_app/update/display.dart';
import 'package:team_app/update/form.dart';

import 'models/first_form_model.dart';
import 'models/food_form_model.dart';
import 'pages/BMICalculatorScreen.dart';
import 'pages/Home_menu.dart';
import 'pages/daily_drink.dart';
import 'pages/drink_history_page.dart';
import 'pages/note_page.dart';
import 'pages/webview.dart';
import 'pages/workout.dart';
import 'pages/sitemap.dart';
import 'pages/menu_page.dart';
import 'pages/daily_meal.dart';
import 'pages/score_result.dart';
import 'pages/welcome.dart';
import 'pages/workout_result.dart';

import 'update/display.dart';
import 'update/form.dart';

/*Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [FormScreen(), DisplayScreen()],
        ),
        backgroundColor: Colors.blue,
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              text: "บันทึกมื้ออาหาร",
            ),
            Tab(
              text: "ราการอาหาร",
            )
          ],
        ),
      ),
    );
  }
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var services = FirebaseServices();
  var controller = DrinkController(services);
  runApp(DrinkApp(
    controller: controller,
  ));
}

/*{
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FirstFormModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FoodFormModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DrinksFormModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}*/


/*class MyApp extends StatefulWidget {
  final DrinkController controller;
  MyApp({required this.controller});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
     
  
        initialRoute: '/13',
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
          '/12': (context) => Drinks(),
          '/13': (context) => DrinksHistory(controller: controller),
          '/14': (context) => WebViewExample(),
        
        }

  

  
        );
  }
}
*/
class DrinkApp extends StatelessWidget {
  final DrinkController controller;
  DrinkApp({required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*home: DrinksHistory(
        controller: controller,
        initialRoute: '/12',*/
      routes: <String, WidgetBuilder>{
       '/12': (context) => Drinks(),
       '/13': (context) => DrinksHistory(controller: controller),
      }
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller;
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[700],
      /*debugShowCheckedModeBanner: false,
      // home: HomePage(),
      initialRoute: '/12',
      routes: <String, WidgetBuilder>{
       '/12': (context) => Drinks(),
       '/13': (context) => DrinksHistory(controller: controller),
      }*/
      )
    );
  }
}



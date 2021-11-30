
import 'package:final_app/pages/add_custom_cost.dart';
import 'package:final_app/pages/home.dart';
import 'package:final_app/pages/select_cost.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Expense App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: Colors.greenAccent[400],
          accentColor: Colors.greenAccent[400],
        ),
       
        initialRoute:  '/1',
        routes: <String, WidgetBuilder>{
          '/1': (context) => Home(),
          '/2': (context) => AddCustomCost(),
        }
    );
  }
}

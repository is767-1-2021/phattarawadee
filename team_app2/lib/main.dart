import 'package:exercise_app/bmi_bmr/pages/LoginPage.dart';
import 'package:exercise_app/bmi_bmr/widgets/login_form.dart';
import 'package:exercise_app/old/pages/exercise_menu_page.dart';
import 'package:exercise_app/old/pages/menu_page.dart';
import 'package:exercise_app/old/pages/webview.dart';
import 'package:exercise_app/screens/home/dashboard.dart';
import 'package:exercise_app/screens/home/drinkpage.dart';
import 'package:exercise_app/screens/home/foodpage.dart';
import 'package:exercise_app/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bmi_bmr/pages/BMICalculatorScreen.dart';
import 'old/pages/Home_menu.dart';
import 'old/pages/daily_meal.dart';
import 'old/pages/score_result.dart';
import 'old/pages/sitemap.dart';
import 'old/pages/welcome.dart';
import 'old/pages/workout.dart';
import 'old/pages/workout_result.dart';
import 'bmi_bmr/pages/BMI_Data_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Exercise App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        initialRoute:  '/13',
        routes: <String, WidgetBuilder>{
          '/one': (context) => Welcome(),
          '/two': (context) => BMICalculatorScreen(),
          '/three': (context) => sitemap(),
          '/four': (context) => HomeScreen(),
          '/five': (context) => meal(),
          '/six': (context) => MenuPage(),
          '/seven': (context) => SixthPage(),
          '/eight': (context) => Home(),
          '/nine': (context) => workout(),
          '/ten': (context) => Dashboard(),
          '/eleven': (context) => DrinkPage(),
          '/twelve': (context) => FoodPage(),
          '/13': (context) => LoginPage(),
        
        });
  }
}

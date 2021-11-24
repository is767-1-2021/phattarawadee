import 'dart:io';

import 'package:exercise_app/old/pages/sitemap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News!',
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: Scaffold(
          appBar: AppBar(title: Text("News!"), 
          
         
           leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }
          ,icon: Icon(Icons.menu),
        ),
          actions: [
            IconButton(
                onPressed: () {
                   Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            /*IconButton(onPressed: () {}, icon: Icon(Icons.agriculture)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.bus_alert)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/3');
                  },
                  icon: Icon(Icons.medication)),
              IconButton(onPressed: () {}, icon: Icon(Icons.food_bank)),
            ],*/
          ]),
          body: WebView(
            initialUrl:
                'https://www.healthline.com/nutrition/50-super-healthy-foods',
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }
}

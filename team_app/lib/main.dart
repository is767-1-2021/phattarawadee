import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app/models/first_form_model.dart';
import 'pages/menu_page.dart';
import 'pages/note_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>FirstFormModel(),      
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
        primaryColor: Colors.lightGreen,
        accentColor: Colors.green,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
     initialRoute: '/5',
      routes: <String, WidgetBuilder> {
        '/1': (context) =>MenuPage(),
        '/2': (context) =>NotePage(),
        '/3': (context) =>SummaryPage(),
        '/5': (context) =>FifthPage(),
      }
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _decreaseCounter() {
    setState(() {
      _counter--;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
    
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class FifthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('Grid View'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(7, (index){
          return InkWell(
            onTap: (){
            Navigator.pushNamed(context, '/${index+1}');
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text('Tap at $index'),
            // ));
            },
            child: Container(
              margin: EdgeInsets.all(20.0), 
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
               child: Text(
                 'Page ${index+1}',
               style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        );
      }),
    ),
  );  
 }
} 

class SummaryPage extends StatefulWidget{
  @override
  _SummaryPageState createState() => _SummaryPageState();
}
class _SummaryPageState extends State<SummaryPage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
          IconButton(onPressed: () {}, icon: Icon(Icons.agriculture)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Consumer <FirstFormModel> (
                builder: (context, form, child) {
                  return Text ('Menu ${form.meal} Cal ${form.calories}');
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/2');               
              },
              child: Text('Fill this form please'),
            ),
          ],
        ),
      ),
    );
  }
}
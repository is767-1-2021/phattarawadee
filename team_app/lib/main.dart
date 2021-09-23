import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
        accentColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
     initialRoute: '/menu',
      routes: <String, WidgetBuilder> {
        '/menu': (context) =>MenuPage(),
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
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
 
 class MenuPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['Rice porridge', 'Spicy noodle salad', 'Spicy minced chicken salad','Rice porridge', 'Spicy noodle salad', 'Spicy minced chicken salad'];
    final List<String> entries2 = <String>['160 kcal', '350 kcal', '200 kcal','160 kcal', '350 kcal', '200 kcal'];
    final List<int> colorCodes = <int>[400, 200, 100]; 
  
    return Scaffold(
      appBar: AppBar(
         title: Text('Menu'),         
      ),
       body: ListView.separated(
        padding: EdgeInsets.all(8.0), 
        itemCount: entries.length, 
        itemBuilder: (context, index){
          return MenuTile(
            item: MenuItem(
              name: '${entries[index]}',
              cal: '${entries2[index]}',
              colorShade: colorCodes[index % 3],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final String cal;
  final int colorShade;

  const MenuItem(
    {Key? key, required this.name, 
    required this.cal, required this.colorShade});
   
}

class MenuTile extends StatelessWidget {
  final MenuItem item;

  const MenuTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => MenuDetail(item: item),
          ),
        );
      },
      child: Container(
        height: 100,
        color: Colors.lightGreen[item.colorShade],
        child: Center(
          child: Text('${item.name}'),
        ),
      ),
    );
  }
}

class MenuDetail extends StatelessWidget {
  final MenuItem item;

  const MenuDetail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0, 
      length: 2,
      child: Scaffold(
      appBar: AppBar(
        title: Text('Menu Name: ${item.name}'),
        bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.fastfood_sharp)
              ),
              Tab(
                icon: Icon(Icons.bookmark_sharp),
              ),
            ],
          ),
      ),
      body: TabBarView(
          children: [
            
            Center(
              child: Image.asset(
                  'assets/Pic1.png',           
              ),
              
            ),
            Center(
              child: Text('Cal: ${item.cal}')
            ),
           
          ], 
        ),
      ),
    );
  }

}
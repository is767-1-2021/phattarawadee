import 'package:exercise_app/old/pages/menu_detail.dart';
import 'package:exercise_app/services/services.dart';
import 'package:flutter/material.dart';



class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}


class _MenuPageState extends State<MenuPage> {
   
 /* var storage = FirebaseStorage.instance;
  late List<AssetImage> listOfMenu;
  bool clicked = false;
  List<String?> listOfStr = [];
  String? menu;
  bool isLoading = false;

  @override
  void initState() {
  super.initState();
  getImages();
}

void getImages() {
  listOfMenu = [];
  for (int i = 0; i < 10; i++) {
    listOfMenu.add(
        AssetImage('assets/images/plate' + i.toString() + '.png'),

        );
  }
 }*/

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      'Vegan salad',
      'Spicy noodle salad',
      'Vegan salad',
      'Spicy minced chicken salad',
      'Rice porridge',
      'Spicy noodle salad',
      'Vegan salad',
      'Spicy minced chicken salad'
    ];
    final List<String> entries2 = <String>[
      '160 kcal',
      '350 kcal',
      '160 kcal',
      '200 kcal',
      '160 kcal',
      '350 kcal',
      '160 kcal',
      '200 kcal'
    ];
    final List<int> colorCodes = <int>[400, 200, 100];
    final List<Image> menu = <Image>[
      /*Image.network('gs://is767-2021-ondiet.appspot.com/plate7.png'),
      Image.network('gs://is767-2021-ondiet.appspot.com/plate8.png'),
      Image.network('gs://is767-2021-ondiet.appspot.com/plate1.png'),
      Image.network('gs://is767-2021-ondiet.appspot.com/plate4.png'),
      Image.network('gs://is767-2021-ondiet.appspot.com/plate5.png'),
      Image.network('gs://is767-2021-ondiet.appspot.com/plate6.png'),
      Image.network('gs://is767-2021-ondiet.appspot.com/plate2.png'),
      Image.network('gs://is767-2021-ondiet.appspot.com/plate3.png'),*/

      Image.asset('assets/images/plate7.png'),
      Image.asset('assets/images/plate8.png'),
      Image.asset('assets/images/plate1.png'),
      Image.asset('assets/images/plate4.png'),
      Image.asset('assets/images/plate5.png'),
      Image.asset('assets/images/plate6.png'),
      Image.asset('assets/images/plate2.png'),
      Image.asset('assets/images/plate3.png')
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthy Food',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 25.0)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notification_add)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return MenuTile(
              item: MenuItem(
              name: '${entries[index]}',
              cal: '${entries2[index]}',
              colorShade: colorCodes[index % 3],
              menu: menu[index],
            
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
  final Image menu;
  

  const MenuItem({
    Key? key,
    required this.name,
    required this.cal,
    required this.colorShade,
    required this.menu,
  });
}

class MenuTile extends StatelessWidget {
  final MenuItem item;

  const MenuTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuDetail(item: item),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(5.0),
              height: 80,
              width: 100,
              child: item.menu),
          Container(
            padding: EdgeInsets.all(5.0),
            height: 80,
            width: 240,
            decoration: BoxDecoration(
              color: Colors.lightGreen[item.colorShade],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text('${item.name}',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16.0)),
            ),
          ),
        ],
      ),
    );
  }
}

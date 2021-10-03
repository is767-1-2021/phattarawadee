import 'package:flutter/material.dart';

class FifthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('Home Page',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0)
        ), 
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.notification_add
            )
          ),
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.person
            )
          ),
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.settings
            )
          ),
        ],
      ), 
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index){
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/${index+1}');
            },
            child: Container(
              margin: EdgeInsets.all(20.0), 
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child:Row(  
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,    
                children:<Widget>[ 
                  Text(
                   'Page ${index+1}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          );
         }
        ),
      ),
    );  
  }
} 
  
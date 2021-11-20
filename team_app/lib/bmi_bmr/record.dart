import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'controllers/bmi_bmr_controllers.dart';
import 'model/bmi_bmr_model.dart';

class RecordPage extends StatefulWidget {
  final BMIController controller;

  RecordPage({required this.controller});

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  List<BMI> bmis = List.empty();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    widget.controller.onSync
        .listen((bool synState) => setState(() => isLoading = synState));
  }

  void _getBMIs() async {
    dynamic newBMIs = await widget.controller.fectBMIs();

    setState(() {
      bmis = newBMIs;
    });
  }

  /*void _updateBMIs(int _id, bool _completed) async {
    await widget.controller.updateBMI(_id, _completed);
  }*/

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: bmis.isEmpty ? 1 : bmis.length,
          itemBuilder: (context, index) {
            if (bmis.isEmpty) {
              return Text("Tap button to fetch BMIs");
            }
            return ListTile(
                title: Text(
              bmis[index].bmi.toString(),
            ));
          },
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP BMIs'),
      ),
      body: Center(
        child: body,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBMIs,
        //onPressed: () {
        //var instance = FirebaseFirestore.instance.collection('BMIs');
        // },
        child: Icon(Icons.add),
      ),
    );
  }
}

// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/bmi_bmr/controllers/todo.dart';
import 'package:exercise_app/bmi_bmr/models/BMIModel.dart';
import 'package:exercise_app/bmi_bmr/pages/BMICalculatorScreen.dart';
import 'package:exercise_app/bmi_bmr/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

User? auth = FirebaseAuth.instance.currentUser;

class BMI_Data_Screen extends StatefulWidget {
  const BMI_Data_Screen({Key? key}) : super(key: key);

  @override
  _BMI_Data_ScreenState createState() => _BMI_Data_ScreenState();
}

class _BMI_Data_ScreenState extends State<BMI_Data_Screen> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Ondiet_bmi')
      .orderBy('date')
      .snapshots();
  late BMIModel _bmiModel;

  void _getBmiTodos(BMIModel bmiModel) async {
    await TodoController().getBmi(bmiModel, context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Image.asset(
            "assets/images/normal.png",
            fit: BoxFit.contain,
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.person_outline),
              iconSize: 30.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
            actions: [
              Text(auth!.email.toString(),
                  style: TextStyle(
                      fontSize: 18, height: 2.3, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.insert_drive_file_outlined),
                iconSize: 28.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BMICalculatorScreen()));
                },
              ),
            ],
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              DateTime d = data['date'].toDate();
              String d_date = d.day.toString() +
                  "/" +
                  d.month.toString() +
                  "/" +
                  d.year.toString();
              String d_time = d.hour.toString() + " : " + d.minute.toString();

              return GestureDetector(
                onTap: () {
                  _bmiModel = BMIModel(
                      height: data['height'],
                      weight: data['weight'],
                      age: data['age'],
                      bmi: data['bmi'],
                      bmr: data['bmr'],
                      isNormal: data['isNormal'],
                      isOver: data['isOver'],
                      isUnder: data['isUnder'],
                      comments: '',
                      sex: data['sex']);

                  _getBmiTodos(_bmiModel);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d_date + "  " + d_time,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Height',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(data['height'].toString())
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(right: 20)),
                            Column(
                              children: [
                                const Text(
                                  'weight',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(data['height'].toString())
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(right: 20)),
                            Column(
                              children: [
                                const Text(
                                  'BMI',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(data['bmi'].toStringAsFixed(2))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(right: 20)),
                            Column(
                              children: [
                                const Text(
                                  'BMR',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(data['bmr'].toStringAsFixed(2))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(right: 20)),
                            Column(
                              children: [
                                const Text(
                                  'Sex',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(data['sex']),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

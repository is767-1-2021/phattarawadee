// ignore_for_file: file_names

import 'package:exercise_app/bmi_bmr/models/BMIModel.dart';
import 'package:flutter/material.dart';

class ResultMale extends StatelessWidget {
  final BMIModel bmiModel;
  final String bmrModel;

  const ResultMale({required this.bmiModel, required this.bmrModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 200,
                height: 200,
                child: (bmiModel.isUnder)
                    ? Image.asset(
                        "assets/images/under.png",
                        fit: BoxFit.contain,
                      )
                    : (bmiModel.isNormal)
                        ? Image.asset(
                            "assets/images/normal.png",
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            "assets/images/over.png",
                            fit: BoxFit.contain,
                          )),
            SizedBox(
              height: 8,
            ),
            Text(
              "Your BMI is ${bmiModel.bmi.round()}",
              style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 34,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "พลังงานที่ต้องการใน1วันคือ ${bmiModel.bmr.round()} kcal",
              style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 16,
            ),
            (bmiModel.isUnder)
                ? Text(
                    "Underweighted!",
                    style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )
                : (bmiModel.isNormal)
                    ? Text(
                        "WOOHOO!Your BMI is Normal!",
                        style: TextStyle(
                            color: Colors.purple[700],
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      )
                    : (bmiModel.isOver)
                        ? Text("Sadly! Your BMI is Overweighted",
                            style: TextStyle(
                                color: Colors.orange[700],
                                fontSize: 20,
                                fontWeight: FontWeight.w700))
                        : Text(
                            "Sadly! Your BMI is Obesed",
                            style: TextStyle(
                                color: Colors.orange[700],
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.orangeAccent,
                  ),
                  label: Text("LET CALCULATE AGAIN"),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red,
                    onSurface: Colors.grey,
                  )),
              width: double.infinity,
              padding: EdgeInsets.only(left: 16, right: 16),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/models/cost.dart';



class AppController {

  final firestoreInstance = FirebaseFirestore.instance;
  Future addCost(String costid, String title, double amount, int list, double totalamount,bool icon) async {
    try {   
      double totalamount = (amount * list).toDouble();
      dynamic result = await firestoreInstance.collection("expense_app_for_final").doc(costid).set({
        'title': title,
        'totalamount': totalamount,
        'list' : list,
        'amount' : amount,
        'icon' : icon
      }).then((doc) async {
        print("success!");
        return true;
      }).catchError((error) {
        print("Failed to add user: $error");
        return false;
      });

      if (result)
      {
        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Status'] = "Success";
        return finalResponse;
      }
      else
      {
        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Error'] = "Error";
        finalResponse['ErrorMessage'] = "Cannot connect to server. Try again later";
        return finalResponse;
      }
    } catch (e) {
      print(e.toString());
      return setUpFailure();
    }
  }
   Future getAllCosts() async {
    List<Cost> costList = [];
    try  {
      dynamic result = await firestoreInstance.collection("expense_app_for_final")
      .get().then((value) {
      value.docs.forEach((result)
        {
          print(result.data);
          Map costData = result.data();
          costData['costid'] = result.id;
          Cost cost = Cost(costData);
          costList.add(cost);
        });
        return true;
      });

      if (result)
      {
        costList.sort((a, b) => a.title.toString().compareTo(b.title.toString()));
        return costList;
      }
      else
      {
        return costList;
      }
    } catch (e) {
      print(e.toString());
      return costList;
    }
  }
   }

 Map setUpFailure() {
    Map finalResponse = <dynamic, dynamic>{}; //empty map
    finalResponse['Status'] = "Error";
    finalResponse['ErrorMessage'] = "Please try again later. Server is busy.";
    return finalResponse;
  }
  


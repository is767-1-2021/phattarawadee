import 'package:final_app/services/app_controller.dart';
import 'package:final_app/models/cost.dart';
import 'package:final_app/utils/constants.dart';
import 'package:final_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCustomCost extends StatefulWidget {

  @override
  _AddCustomCostState createState() => _AddCustomCostState();
}

class _AddCustomCostState extends State<AddCustomCost> {
  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController totallist = TextEditingController();
  TextEditingController icon = TextEditingController();
  TimeOfDay? timeUser;
  /*List<Icon> _selectedicon = [
    Icon(Icons.bus_alert, color: Colors.black,),
    Icon(Icons.fastfood, color: Colors.black,),];*/
  String dropdownValue = 'iconfood';

  void saveCost() {
    int list = int.parse(totallist.text);
    Cost customCost = Cost.fromEmpty();
    customCost.costid = DateTime.now().millisecondsSinceEpoch.toString();
    customCost.title = title.text;
    customCost.amount = double.parse(amount.text);
    customCost.list = list;
    customCost.icon = true;
    customCost.totalamount = customCost.amount / (1 / customCost.list);
    customCost.userlistSelected = int.parse(totallist.text);
    customCost.userBasedamount = (customCost.totalamount);
    AppController().addCost(customCost.costid, customCost.title,customCost.amount,customCost.list,
        customCost.totalamount, customCost.icon);
    Get.back(result: customCost);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              child: Center(
                child: Text(
                  'Add Custom Expense',
                  style: TextStyle(
                      color: Colors.greenAccent[400],
                      fontSize: SizeConfig.fontSize * 2.3,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: title,
                  decoration: new InputDecoration(
                    hintText: "expense Name",
                    hintStyle: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: SizeConfig.fontSize * 1.8),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: amount,
                 // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: new InputDecoration(
                    hintText: "amount",
                    hintStyle: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: SizeConfig.fontSize * 1.8),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: totallist,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: "number of list",
                    hintStyle: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: SizeConfig.fontSize * 1.8),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: icon,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: "icon",
                    hintStyle: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: SizeConfig.fontSize * 1.8),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.greenAccent),
              underline: Container(
                height: 2,
                color: Colors.greenAccent[400],
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['iconfood', 'iconbus', 'icon3', 'icon4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
           
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.greenAccent[400]),
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.fontSize * 1.9),
                        )),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.greenAccent[400]),
                    child: TextButton(
                        onPressed: () {
                          if (title.text.isEmpty)
                            Constants.showDialog('Please enter expense name');
                          else if (amount.text.isEmpty)
                            Constants.showDialog('Please enter amount');
                          else if (amount.text.isEmpty)
                            Constants.showDialog('Please enter list');
                          else if (totallist.text.isEmpty)
                            Constants.showDialog('Please select icon');
                          else {
                            saveCost();
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.fontSize * 1.9
                          ),
                        )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

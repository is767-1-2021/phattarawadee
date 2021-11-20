import 'package:exercise_app/model/food.dart';
import 'package:exercise_app/utils/constants.dart';
import 'package:exercise_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCustomFood extends StatefulWidget {

  @override
  _AddCustomFoodState createState() => _AddCustomFoodState();
}

class _AddCustomFoodState extends State<AddCustomFood> {

  TextEditingController FoodName = TextEditingController();
  TextEditingController kcal = TextEditingController();
  TextEditingController timeField = TextEditingController();
  TimeOfDay? timeUser;

  Future<void> selectTime() async {
    DateTime showTime = DateTime.now();
    showTime = new DateTime(showTime.year, showTime.month, showTime.day, 1, 0, 0, 0, 0);

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(showTime),
      initialEntryMode: TimePickerEntryMode.dial
    );

    if(time != null)
    {
      timeUser = time;
      timeField.text = (time.minute >0) ? "${time.hour}:${time.minute}" : "${time.hour}";
      setState(() {});
    }
  }

  void saveFood(){
    int totalDishes = (timeUser!.hour * 60) + timeUser!.minute;
    Food customFood = Food.fromEmpty();
    customFood.foodId = DateTime.now().millisecondsSinceEpoch.toString();
    customFood.foodName = FoodName.text;
    customFood.totalDishes = totalDishes;
    customFood.foodKCalPerDish = int.parse(kcal.text);
    //customFood.caloriesPerMinute = customFood.foodKCalPerDish/customFood.totalDishes;
    //customFood.userTimeMinutesSelected = totalDishes;
    //customFood.userTimeSelected = (timeUser!.minute >0) ? "${timeUser!.hour}:${timeUser!.minute}" : "${timeUser!.hour}";
    //customFood.userTimeBasedCalories = (customFood.userTimeMinutesSelected * customFood.caloriesPerMinute).toInt();
    Get.back(result: customFood);
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
                  'Add Custom Food',
                  style :TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 2.3, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color : Colors.grey[300]
              ),
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: FoodName,
                  decoration: new InputDecoration(
                    hintText: "Food Name",
                    hintStyle: TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 1.8),
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
                color : Colors.grey[300]
              ),
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: kcal,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType : TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: "Calories",
                    hintStyle: TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 1.8),
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
                color : Colors.grey[300]
              ),
              child: Center(
                child: TextField(
                    style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                    readOnly: true,
                    enabled: false,
                    controller: timeField,
                    decoration: new InputDecoration(
                      hintText: "Dish",
                      hintStyle: TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 1.8),
                      border: InputBorder.none,
                  ),
                ),
              ),
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
                      color : Colors.green
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancel',
                        style :TextStyle(color: Colors.white, fontSize: SizeConfig.fontSize * 1.9),
                      )
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color : Colors.green
                    ),
                    child: TextButton(
                      onPressed: () {
                        if(FoodName.text.isEmpty)
                          Constants.showDialog('Please enter food name');
                        else if(kcal.text.isEmpty)
                          Constants.showDialog('Please enter calories');
                        else if(timeField.text.isEmpty)
                          Constants.showDialog('Please enter dish');
                        else
                        {
                          saveFood();
                        }
                      },
                      child: Text(
                        'Save',
                        style :TextStyle(color: Colors.white, fontSize: SizeConfig.fontSize * 1.9),
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
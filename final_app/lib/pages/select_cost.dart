import 'package:dropdown_search/dropdown_search.dart';
import 'package:final_app/models/cost.dart';
import 'package:final_app/pages/add_custom_cost.dart';
import 'package:final_app/services/app_controller.dart';
import 'package:final_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCost extends StatefulWidget {
  final List<Cost> selectedDayCostList;
  final String selectedDateText;
  final DateTime selectedDate;

  SelectCost(
      {required this.selectedDateText,
      required this.selectedDate,
      required this.selectedDayCostList});

  @override
  _SelectCostState createState() => _SelectCostState();
}

class _SelectCostState extends State<SelectCost> {
  List<Cost> costs = [];
  Cost? selectedCost;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getAllCosts(); //From Firebase
  }

  Future<void> getAllCosts() async {
    costs = await AppController().getAllCosts();
    //Remove already selected exercises if any
    for (int i = 0; i < widget.selectedDayCostList.length; i++) {
      costs.removeWhere(
          (cost) => cost.costid == widget.selectedDayCostList[i].costid);
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> showCustomCostDialog() async {
    dynamic customCategoryAdded = await Get.generalDialog(
        pageBuilder: (context, __, ___) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: AddCustomCost(),
            ));

    //Check if new customer category added
    if (customCategoryAdded != null) {
      setState(() {
        widget.selectedDayCostList.add(customCategoryAdded);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: InkWell(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select/Add Expense',
                style: TextStyle(
                    color: Colors.white, fontSize: SizeConfig.fontSize * 2),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              )
            ],
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // showCalender = true;
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: showCustomCostDialog,
      ),
      body: (loading)
          ? Container(
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text("loading ${costs.length}")
                  ],
                ),
              ),
            )
          : Container(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (costs.length >= 0)
                  Container(
                    height: SizeConfig.blockSizeVertical * 7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Center(
                      child: DropdownSearch<Cost>(
                        mode: Mode.BOTTOM_SHEET,
                        hint: "Search for expenses",
                        items: costs,
                        itemAsString: (Cost u) {
                          return u.title +
                              u.icon.toString() +
                              '\n' +
                              u.list.toString() +
                              "list" +
                              " - " +
                              u.amount.toString();
                        },
                        onChanged: (data) {
                          setState(() {
                            selectedCost = data;
                          });
                        },
                        showSearchBox: true,
                        //searchBoxDecoration: null,
                        dropdownSearchDecoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 12),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          border: InputBorder.none,
                        ),
                        dropdownBuilder: _customDropDownExample,
                      ),
                    ),
                  ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ListView.builder(
                          itemCount: widget.selectedDayCostList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return selectedCostCell(
                                widget.selectedDayCostList[index], index);
                          })),
                )
              ],
            )
          ),
          
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          await Cost.saveCostsForDate(
              widget.selectedDate, widget.selectedDayCostList);
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: SizeConfig.blockSizeVertical * 7,
          decoration: BoxDecoration(
              color: Colors.greenAccent[400],
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.fontSize * 2.3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customDropDownExample(
      BuildContext context, Cost? cost, String itemDesignation) {
    return Container(
      child: Text(
        'Search for Expenses',
        style: TextStyle(color: Colors.grey, fontSize: SizeConfig.fontSize * 2),
      ),
    );
  }

  Widget selectedCostCell(Cost cost, int index) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${cost.title}',
                style: TextStyle(
                    fontSize: SizeConfig.fontSize * 2.2,
                    fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                  onTap: () async {
                    widget.selectedDayCostList.removeAt(index);
                    setState(() {});
                    await Cost.saveCostsForDate(
                        widget.selectedDate, widget.selectedDayCostList);
                  },
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  )),
            ],
          ),
          subtitle: Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${cost.list} Transaction',
                    style: TextStyle(
                        fontSize: SizeConfig.fontSize * 1.8,
                        fontWeight: FontWeight.w500,
                        color: Colors.green),
                  ),
                  Text(
                    '${cost.amount.toStringAsFixed(2)} EUR',
                    style: TextStyle(
                        fontSize: SizeConfig.fontSize * 1.8,
                        fontWeight: FontWeight.w500,
                        color: Colors.green
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}

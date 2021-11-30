
import 'package:final_app/services/app_controller.dart';
import 'package:final_app/models/cost.dart';
import 'package:final_app/pages/add_custom_cost.dart';
import 'package:final_app/pages/select_cost.dart';
import 'package:final_app/utils/size_config.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List monthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  bool showCalender = false;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String currentCalenderMonth = "";
  String selectedHeading = "";
  DateTime selectedDate = DateTime.now();
  DateTime userSelectedDate = DateTime.now();
  List<Cost> selectedDateCosts = [];
  String totalamount = "0";
  String totallist = "0";
  List<Cost> costs = [];
  Cost? selectedCost;
  bool loading = true;
  

  @override
  void initState() {
    super.initState();
    currentCalenderMonth = monthNames[DateTime.now().month - 1];
    selectedHeading = 'Today';
    loadSavedCostForSelectedDay();
  }

  Future<void> loadSavedCostForSelectedDay() async {
    selectedDateCosts = await Cost.getSavedCostsForDate(userSelectedDate);
    setState(() {
      calculateTotalamount();
    });
  }

  void calculateTotalamount() {
    double totallistOfCost = 0;
    double amounts = 0;
    for (int i = 0; i < selectedDateCosts.length; i++) 
      totallistOfCost =
          (selectedDateCosts[i].userlistSelected) + totallistOfCost;
         
    for (int i = 0; i < selectedDateCosts.length; i++)  {
          if (amounts == '-') {
      amounts = selectedDateCosts[i].userBasedamount - amounts;
      }
      else { amounts = selectedDateCosts[i].userBasedamount + amounts;
      };
    }

    totalamount = amounts.toStringAsFixed(2);
    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
    totallist = totallistOfCost.toString().replaceAll(regex, "");

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: InkWell(
          onTap: () {},
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$totalamount EUR',
                style: TextStyle(
                    color: Colors.white, fontSize: SizeConfig.fontSize * 3 ),
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
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              showCalender = !showCalender;
            });
          },
          icon: Icon(
            (showCalender) ? Icons.calendar_today : Icons.calendar_today,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              if (showCalender)
                Container(
                  color: Colors.white,
                  child: TableCalendar(
                    headerVisible: true,
                    headerStyle: HeaderStyle(
                        titleCentered: true,
                        decoration:
                            BoxDecoration(color: Colors.greenAccent[400]),
                        formatButtonVisible: false,
                        titleTextFormatter: (data, Locale) => DateFormat.MMM(Locale).format(data),
                        titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.fontSize * 2,
                            fontWeight: FontWeight.bold)),
                    startingDayOfWeek : StartingDayOfWeek.monday,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.grey),
                      weekendStyle: TextStyle(color: Colors.grey),
                      dowTextFormatter:(date, locale) => DateFormat.E(locale).format(date)[0],
                    ),

                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          shape: BoxShape.circle),
                      defaultTextStyle: TextStyle(color: Colors.black),
                      rowDecoration: BoxDecoration(color: Colors.white),
                      selectedTextStyle: TextStyle(color: Colors.white),
                      selectedDecoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          shape: BoxShape.circle),
                      weekendDecoration: BoxDecoration(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.black),
                    ),

                    firstDay: DateTime(2021),
                    lastDay: DateTime(2100),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          if (_selectedDay!.day == DateTime.now().day &&
                              _selectedDay!.month == DateTime.now().month &&
                              _selectedDay!.year == DateTime.now().year)
                            selectedHeading = "Today";
                          else
                            selectedHeading = DateFormat('EEEE, MMM dd')
                                .format(_selectedDay!);
                          userSelectedDate = _selectedDay!;
                          showCalender = false;
                          loadSavedCostForSelectedDay();
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                        if (_focusedDay.year == DateTime.now().year)
                          currentCalenderMonth =
                              monthNames[focusedDay.month - 1];
                        else
                          currentCalenderMonth =
                              monthNames[focusedDay.month - 1] +
                                  " " +
                                  focusedDay.year.toString();
                      });
                    },
                  ),
                ),
              costView(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          await Get.to(SelectCost(
              selectedDateText: selectedHeading,
              selectedDate: userSelectedDate,
              selectedDayCostList: selectedDateCosts));
          setState(() {
            calculateTotalamount();
          });
        },
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
          ],
        ),
        subtitle: Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cost.list} transaction',
                  style: TextStyle(
                      fontSize: SizeConfig.fontSize * 1.8,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
                Text(
                  '${cost.amount} amount',
                  style: TextStyle(
                      fontSize: SizeConfig.fontSize * 1.8,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
              ],
            )),
      ),
    );
  }

  Widget costView() {
    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Net amount',
                  style: TextStyle(
                      fontSize: SizeConfig.fontSize * 1.9, color: Colors.black),
                ),
                Text(
                  '$totalamount £',
                  style: TextStyle(
                      fontSize: SizeConfig.fontSize * 1.9, color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction',
                  style: TextStyle(
                      fontSize: SizeConfig.fontSize * 1.9, color: Colors.black),
                ),
                Text(
                  '$totallist',
                  style: TextStyle(
                      fontSize: SizeConfig.fontSize * 1.9, color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                      'Net amount',
                      style: TextStyle(
                          fontSize: SizeConfig.fontSize * 2.2,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '$totalamount £',
                      style: TextStyle(
                          fontSize: SizeConfig.fontSize * 2.2,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 0),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: selectedDateCosts.length,
                        itemBuilder: (context, index) {
                          return costCell(selectedDateCosts[index]);
                        }
                    ),
                  ),
                ),],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget costCell(Cost cost) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(),
            child: Icon(
              Icons.fastfood,
              color: Colors.black,
            ),
          ),
          title: Text(
            '${cost.title}',
            style: TextStyle(
                fontSize: SizeConfig.fontSize * 2.2,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              '${cost.list} list',
              style: TextStyle(
                  fontSize: SizeConfig.fontSize * 1.8,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          trailing: Container(
            margin: EdgeInsets.only(right: 10),
              child: Text(
              '${cost.totalamount.toStringAsFixed(2)} £',
              style: TextStyle(
                  fontSize: SizeConfig.fontSize * 1.8,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
        )
      );
    }
  }

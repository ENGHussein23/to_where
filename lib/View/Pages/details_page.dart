import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/Controller/Constants/strings.dart';
import 'package:to_where/Model/month_year_model.dart';
import 'package:to_where/View/Pages/reservation_confirmation_page.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
import 'package:to_where/View/Widgets/item_container.dart';
import 'package:to_where/View/Widgets/small_widgets.dart';

class DetailsPage extends StatefulWidget{
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late int max_hours;
  late String servieceID;
  late String access_token;
  @override
  void initState() {
    super.initState();
    getToken();
    // testapi(_focusedDay,2);
  }
  // this function just to get token for one time to make tha page load faster
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token =  prefs.getString('access_token')??'';
  }
  int print_counter_api=0;
  // after we get the token then we starts with the our function
  // for wrap
  double crossAxisSpacing = 0.0;
  // to format the calendar
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  // list of all reservation
  List<MonthYear> monthYear3=[];
  // list of just the reservation days that had reached the maximum reservations
  List<MonthYear> monthYearMax=[];
  bool showTimes=false;
  Map<DateTime, List<MonthYear>> dateMap = {};
  // the function get events its for get the days that had reach the max reservation in the working day in every month
  List<DateTime> _getEvents(DateTime day) {
    List<DateTime> eventDates = [];

    // Check for marked dates
    for (int i = 0; i < monthYearMax.length; i++) {
      try {
        DateTime date = DateTime.parse(monthYearMax[i].date);
        if (date.day == day.day && date.month == day.month && date.year == day.year) {
          eventDates.add(date);
          print("Marked date: ${date.day}-${date.month}-${date.year}");
        }
      } catch (e) {print("Error parsing date: $e");}
    }
    if (eventDates.isNotEmpty) {
      return eventDates;
    }
    // If no events are found, return an empty list
    print("No events found for ${day.day}-${day.month}-${day.year}");
    return eventDates;
  }
  // this function for call the api and collect data about the days that had reach the max reservation and the all reservations in this month
  testapi( DateTime day,int max_hours, String servieceID)async{
    // if(print_counter_api>0){
    //   return;
    // }

    print('print_counter_api = ${print_counter_api++}');
    // the api url CustomerMonthYear
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(CustomerMonthYear),
    );
    request.fields.addAll({
      'year': day.year.toString(),
      'month':day.month.toString(),
      'service_id':servieceID.toString()
    });
    request.headers.addAll(headers);
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final jsonData3 = jsonDecode(responseBody);
    monthYear3=[];
    monthYear3 = jsonData3.map<MonthYear>((item) => MonthYear.fromJson(item)).toList();
    var dateCounts = <String, int>{};
    for (int i=0;i<monthYear3.length;i++) {
      var date = monthYear3[i].date;
      dateCounts[date] = (dateCounts[date]??0) + 1;
    }
    monthYearMax=[];
    for(int i=0;i<monthYear3.length;i++){
      if(dateCounts[monthYear3[i].date]==max_hours) {
        bool foundIt=false;
        for(int j=0;j<monthYearMax.length;j++){
          if(monthYearMax[j].date == monthYear3[i].date){
            foundIt=true;
            break;
          }
        }
        if(!foundIt){
          monthYearMax.add(monthYear3[i]);
        }
      }
    }

    dateMap = {};

    // String dateString = '2023-06-09';
    // DateTime dateToCompare = DateTime(2023, 6, 10); // example date to compare with
    // DateTime parsedDate = DateTime.parse(dateString);

    // DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    for (int i = 0; i < monthYear3.length; i++) {
      DateTime date = DateTime.parse(monthYear3[i].date);
      if (dateMap.containsKey(date)) {
        dateMap[date]?.add(monthYear3[i]);
      } else {
        dateMap[date] = [monthYear3[i]];
      }
    }
    print('finish the apiprint_counter_api = ${print_counter_api}');
  }
  // to check if the day we pressed on it if ,it is marked as max reservations day or not
  bool isDateMarked(String dateString, List<DateTime> markedDates) {
    DateTime dateToCheck = DateTime.parse(dateString);
    for (DateTime markedDate in markedDates) {
      if (markedDate.year == dateToCheck.year &&
          markedDate.month == dateToCheck.month &&
          markedDate.day == dateToCheck.day) {
        return true;
      }
    }
    return false;
  }
  // to check if the day we pressed on it if ,it is weekend day or not
  bool isWeekendDay(String dateString, List<int> weekendDays) {
    DateTime date = DateTime.parse(dateString);
    int weekday = date.weekday;
    return weekendDays.contains(weekday);
  }
  List<String> getKeys(List<Map<String, List<String>>> inputList) {
    List<String> outputList = [];
int i=0;
    for (var map in inputList) {
      outputList.addAll(map.keys);
      print ("===Key $i ${map.keys}=======");
      i++;
    }
    print("==========================");
    print(outputList.toString());
    print("==========================");
    return outputList;
  }
  //to get the weekend days from the past api that gev us the working days
  List<int> getRemainingDays(List<String> workingDays) {
    List<String> allDays = [
      "الأحد",
      "الاثنين",
      "الثلاثاء",
      "الأربعاء",
      "الخميس",
      "الجمعة",
      "السبت"
    ];

    List<int> remainingDays = [];

    for (var i = 0; i <allDays.length; i++) {
      if (!workingDays.contains(allDays[i])) {
        if(i==0)
          {
            remainingDays.add(7);
          }
        else
        remainingDays.add(i);
      }
    }
    print("==========================");
    print(remainingDays.toString());
    print("==========================");
    return remainingDays;
  }
  // to get working hours
  List<String> dayNames = ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
  late String selectedDayName;
  late Map<String, List<String>> selectedDayHoursMap;
  List<String>? selectedDayHours=[];
  getHourReservation(Hour){
// 1 is red 2 is green whatever else is gry
//  date.day == day.day && date.month == day.month && date.year == day.year
  for(int i=0;i<monthYear3.length;i++){
    DateTime date=DateTime.parse(monthYear3[i].date);
    if(Hour==monthYear3[i].hour&&(date.day == _selectedDay!.day && date.month == _selectedDay!.month && date.year == _selectedDay!.year))
      return 1;
  }
  return 0;
  }
  String formatHour(String hour) {
    String suffix = 'am';
    if (hour.contains(':')) {
      hour = hour.replaceAll(':', '');
    }
    int hourInt = int.parse(hour);
    if (hourInt >= 12) {
      suffix = 'pm';
    }
    if (hourInt > 12) {
      hourInt -= 12;
    }
    if (hourInt == 0) {
      hourInt = 12;
    }
    return '$hourInt:00 $suffix';
  }
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    List<Map<String, List<String>>> workingHoursMap=args['working_hours'];
    max_hours=workingHoursMap[0].values.first.length;
    print("max_hours is"+max_hours.toString());
     servieceID=args['service_id'];
    // print(workingHoursMap.toString()); //worked like this [{الأحد: [0, 10, 5]}, {الجمعة: [0, 10, 5]}, {السبت: [0, 10, 5]}]
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List <String> workDayes=getKeys(workingHoursMap)??[];
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 25,right: 15,left: 15),
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(color: Color.fromARGB(34, 107, 107, 107)),
        child: SingleChildScrollView(
          child: Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalCustomTextWithWeight("اسم مزود الخدمة",almost_bright_green,20.0,FontWeight.w700),
              space_V(10.0),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Expanded(child:  ItemContainerInnerWidget(Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  NormalCustomTextWithWeight("عدد الأشخاص",Colors.black,16.0,FontWeight.w500),
                ],
              ),(){print("its worked fine");})),
                 space_H(110.0),
                 Expanded(child:ItemContainerInnerWidget(Row(
                   textDirection: TextDirection.ltr,
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     NormalCustomTextWithWeight("احجز",Colors.black,16.0,FontWeight.w500),
                     space_H(3.0),
                     Container(
                       padding: const EdgeInsets.all(2),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle,
                         border: Border.all(
                           color: Colors.blue,
                           width: 1.0,
                         ),
                       ),
                       child: const Icon(Icons.bookmarks,size: 18,color: Colors.blue,),
                     ),
                   ],
                 ),(){print("its worked fine");
                 Get.to(ReservationConfirmationPage());}),
                 ),
                ],
              ),
              space_V(5.0),
              Center(child: NormalCustomTextWithWeight("الوقت المتبقي على انتهاء مدة الحجز 3:00 دقائق",Colors.red,14.0,FontWeight.w600),),
              space_V(5.0),
              ItemContainerInnerWidget(
                Container(
                  padding: const EdgeInsets.only(top: 3,right: 15,left: 15,bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        children:  [
                          white_icon_whith_dark_shadow(Icons.calendar_month),
                          space_H(4.0),
                          NormalCustomTextWithWeight("اختر اليوم",Colors.black45,16.0,FontWeight.w600),
                        ],
                      ),
                      space_V(4.0),
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                        ),
                        child: Column(
                          children: [
                            TableCalendar(
                              focusedDay: _focusedDay,
                              firstDay: DateTime(2021),
                              lastDay: DateTime(2025),
                              calendarFormat: _calendarFormat,
                              headerStyle: const HeaderStyle(titleCentered: true,formatButtonVisible: false),
                              weekendDays: getRemainingDays(workDayes),
                              onFormatChanged: (format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
                              selectedDayPredicate: (day) {
                                return _selectedDay == day;
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                if(!isWeekendDay(selectedDay.toString(), getRemainingDays(workDayes))){
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;

                                  });
                                  // Fetch data from the API
                                  testapi(selectedDay,max_hours,servieceID);
                                }
                                // Get the working hours for the selected day
                                setState(() {
                                  /////////////////////////
                                  selectedDayName = dayNames[_selectedDay!.weekday - 1];
                                  selectedDayHoursMap = workingHoursMap.firstWhere((element) => element.containsKey(selectedDayName));
                                  selectedDayHours = selectedDayHoursMap[selectedDayName];
                                  // Print the working hours for the selected day
                                  print('Working hours for $selectedDayName: ${selectedDayHours?.join(', ')}');
                                  ///////////////////////
                                });
                                print("==================================");
                                print("_selectedDay : $_selectedDay");
                                print("selectedDay : $selectedDay");
                                print("_focusedDay : $_focusedDay");
                                print("focusedDay : $focusedDay");
                                print("==================================");
                              },
                              eventLoader: _getEvents,
                              calendarStyle: const CalendarStyle(
                                isTodayHighlighted: false,
                                weekendDecoration: BoxDecoration(color: Color.fromARGB(50, 37, 52, 44), image: DecorationImage(image: AssetImage("assets/images/x.png"),),),
                                defaultDecoration: BoxDecoration(color: Color.fromARGB(50, 37, 52, 44)),
                                selectedDecoration: BoxDecoration(color: Color.fromARGB(150, 0, 255, 117)),
                                markerDecoration: BoxDecoration(shape: BoxShape.rectangle, image: DecorationImage(image: AssetImage("assets/images/Solid_red.png"), opacity: 0.4,),),
                                todayDecoration: BoxDecoration(color: Color.fromARGB(255, 160, 245, 42)),
                                todayTextStyle: TextStyle(color: Colors.black),
                                selectedTextStyle: TextStyle(color: Colors.black),
                                defaultTextStyle: TextStyle(color: Colors.black),
                                markersOffset: PositionedOffset(start: 0, bottom: 0, end: 0, top: 0),
                                cellMargin: EdgeInsets.only(top: 5, bottom: 9, left: 5, right: 5),
                                markersAnchor: 1, markerSize: 38,),
                            ),
                            space_V(5.0),
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                color_squer("حجزك",const Color.fromARGB(97, 8, 246, 103),),
                                space_H(5.0),
                                color_squer("متاح",const Color.fromARGB(97, 0, 0, 0)),
                                space_H(5.0),
                                color_squer("محجوز",const Color.fromARGB(97, 246, 8, 8),),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
                ,(){print("its worked fine");}
              ),
              space_V(20.0),
              Visibility(
                visible: (selectedDayHours!.length>0)?true:false,
                  child: ItemContainerInnerWidget(
                      Container(
                        padding: const EdgeInsets.only(top: 3,right: 15,left: 15,bottom: 10),
                        child:Column(
                          children: [
                            Row(
                              textDirection: TextDirection.rtl,
                              children:  [
                                white_icon_whith_dark_shadow(Icons.access_time),
                                space_H(4.0),
                                NormalCustomTextWithWeight("اختر الوقت",Colors.black45,16.0,FontWeight.w600),
                              ],
                            ),
                            space_V(7.0),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black),),
                                  child:Wrap(
                                    spacing: 0.0,
                                    runSpacing: -crossAxisSpacing * 5,
                                    children: List.generate(selectedDayHours!.length, (index) {
                                      String a = formatHour(selectedDayHours![index]);
                                      int b = 0;
                                      for (int i = 0; i < monthYear3.length; i++) {
                                        DateTime date = DateTime.parse(monthYear3[i].date);
                                        if (selectedDayHours![index] == monthYear3[i].hour &&
                                            (date.day == _selectedDay!.day &&
                                                date.month == _selectedDay!.month &&
                                                date.year == _selectedDay!.year)) {
                                          b = 1;
                                        }
                                      }
                                      return SizedBox(
                                        width: (MediaQuery.of(context).size.width - crossAxisSpacing * 7) / 7,
                                        child: StatefulBuilder(
                                          builder: (context, setState) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (b == 0) {
                                                  setState(() {
                                                    b = 2;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.all(3),
                                                height: 30,
                                                width: 80,
                                                color: b == 1
                                                    ? Color.fromARGB(147, 246, 8, 8)
                                                    : b == 2
                                                    ? Color.fromARGB(147, 8, 246, 8)
                                                    : Colors.black12,
                                                child: Center(
                                                  child: FittedBox(
                                                    child: Text(
                                                      a,
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }),
                                  ),
                              ), space_V(15.0),
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                color_squer("حجزك",const Color.fromARGB(197, 8, 246, 103),),
                                space_H(5.0),
                                color_squer("متاح",const Color.fromARGB(97, 0, 0, 0)),
                                space_H(5.0),
                                color_squer("محجوز",const Color.fromARGB(97, 246, 8, 8),),
                              ],
                            )
                          ],
                        ),
                      )
                      ,(){print("its worked fine");}),), space_V(25.0)
            ],
          ),
        ),
      ),
    );
  }
}
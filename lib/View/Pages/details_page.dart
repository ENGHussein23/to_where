import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/Controller/Getx_controllers/details_page_controller.dart';
import 'package:to_where/View/Pages/reservation_confirmation_page.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
import 'package:to_where/View/Widgets/NavigationIcon.dart';
import 'package:to_where/View/Widgets/item_container.dart';
import 'package:to_where/View/Widgets/small_widgets.dart';

class DetailsPage extends StatefulWidget{
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsController=Get.put(DetailsPageController());
  double crossAxisSpacing = 0.0;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<DateTime> _markedDates = [
    DateTime(2023, 6, 2),
    DateTime(2023, 6, 9),
    DateTime(2023, 6, 4),
    DateTime(2023, 6, 18),
  ];
  List<DateTime> _getEvents(DateTime day) {
    if (_markedDates.contains(day)) {
      return [day];
    } else {
      return _markedDates.where((date) => date.day == day.day && date.month == day.month && date.year == day.year).toList();
    }
  }

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
  bool showTimes=false;
  List<String> HourList =
  ['7:00 am', '8:00 am','9:00 am','10:00 am','11:00 am','12:00 pm',
    '1:00 pm','2:00 pm','3:00 pm','4:00 pm','5:00 pm', '6:00 pm',
    '7:00 pm','8:00 pm','9:00 pm','10:00 pm','11:00 pm'];

  ShowHours(List,from,where){
    for(int i=from;i<where;i++){
      SelectHour(HourList[i],i%3);
    }
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
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    List<Map<String, List<String>>> workingHoursMap=args['working_hours'];
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
                       padding: EdgeInsets.all(2),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle,
                         border: Border.all(
                           color: Colors.blue,
                           width: 1.0,
                         ),
                       ),
                       child: Icon(Icons.bookmarks,size: 18,color: Colors.blue,),
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
                  padding: EdgeInsets.only(top: 3,right: 15,left: 15,bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        children:  [
                          Icon(Icons.calendar_month,color: Colors.white,size: 30,shadows: [
                            Shadow(color: Colors.black45,blurRadius: 10,offset: Offset(1, 1),),
                            Shadow(color: Colors.black45,blurRadius: 10,offset: Offset(-1, -1),),
                            Shadow(color: Colors.black45,blurRadius: 10,offset: Offset(-1, 1),),
                            Shadow(color: Colors.black45,blurRadius: 10,offset: Offset(1, -1),),
                          ],),
                          space_H(4.0),
                          NormalCustomTextWithWeight("اختر اليوم",Colors.black45,16.0,FontWeight.w600),
                        ],
                      ),
                      space_V(4.0),
                      Container(
                        padding: EdgeInsets.all(7),
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
                              headerStyle: HeaderStyle(titleCentered: true,formatButtonVisible: false),
                              weekendDays: getRemainingDays(workDayes),
                              // weekendDays: [1],
                              // weekendDays: [ 0],
                              onFormatChanged: (format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
                              selectedDayPredicate: (day) {
                                return _selectedDay == day;
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                if(!isDateMarked(selectedDay.toString(), _markedDates)){
                                // if(true){
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });

                                }
                                else{
                                  Get.snackbar('', '',
                                      titleText: Text("هذا اليوم مكتمل الحجز مسبقا",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),),
                                      duration: Duration(seconds: 1),
                                      colorText: Colors.white,
                                      backgroundColor: Color.fromARGB(50, 255, 0, 0)
                                  );
                                }
                                print("==================================");
                                print("_selectedDay : $_selectedDay");
                                print("selectedDay : $selectedDay");
                                print("_focusedDay : $_focusedDay");
                                print("focusedDay : $focusedDay");
                                print("==================================");
                              },
                              eventLoader: _getEvents,
                              calendarStyle: CalendarStyle(
                                isTodayHighlighted: false,
                                weekendDecoration:BoxDecoration(color: Color.fromARGB(50, 37, 52, 44),image: DecorationImage(image:AssetImage("assets/images/x.png") )),
                                  defaultDecoration: BoxDecoration(color: Color.fromARGB(50, 37, 52, 44),),
                                  selectedDecoration: BoxDecoration(color: Color.fromARGB(150, 0, 255, 117),),
                                  markerDecoration: BoxDecoration(
                                      // color: Color.fromARGB(150, 255, 0, 0),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(image:AssetImage("assets/images/Solid_red.png") ,opacity: 0.4 )),
                                  todayDecoration: BoxDecoration(color: Color.fromARGB(
                                      255, 160, 245, 42),),
                                        todayTextStyle: TextStyle(color: Colors.black),
                                      selectedTextStyle: TextStyle(color: Colors.black),
                                  // markersAutoAligned: true,
                                  defaultTextStyle: TextStyle(color: Colors.black),
                                  markersOffset: PositionedOffset(start: 0,bottom: 0,end: 0,top: 0),
                                  cellMargin: EdgeInsets.only(top: 5,bottom: 9,left: 5,right: 5),
                                  markersAnchor: 1,
                                  markerSize: 38
                              ),
                            ),
                            space_V(5.0),
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                color_squer("حجزك",Color.fromARGB(97, 8, 246, 103),),
                                space_H(5.0),
                                color_squer("متاح",Color.fromARGB(
                                    97, 0, 0, 0)),
                                space_H(5.0),
                                color_squer("محجوز",Color.fromARGB(
                                    97, 246, 8, 8),),
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
                // visible: showTimes,
                visible: true,
                  child: ItemContainerInnerWidget(
                      Container(
                        // height:200,
                        padding: EdgeInsets.only(top: 3,right: 15,left: 15,bottom: 10),
                        child:Column(
                          children: [
                            Row(
                              textDirection: TextDirection.rtl,
                              children:  [
                                Icon(Icons.access_time,color: Colors.white,size: 30,shadows: [
                                  Shadow(color: Colors.black45,blurRadius: 10,offset: Offset(1, 1),),
                                  Shadow(color: Colors.black45,blurRadius: 10,offset: Offset(-1, -1),),
                                  Shadow(color: Colors.black45,blurRadius: 10,offset: Offset(-1, 1),),
                                  Shadow(color: Colors.black45,blurRadius: 10,offset: Offset(1, -1),),
                                ],),
                                space_H(4.0),
                                NormalCustomTextWithWeight("اختر الوقت",Colors.black45,16.0,FontWeight.w600),
                              ],
                            ),
                            space_V(7.0),
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                ),
                                child:Wrap(
                                  spacing: 0.0,
                                  runSpacing: -crossAxisSpacing *5,
                                  children: List.generate(HourList.length, (index) {
                                    return SizedBox(
                                      width: (MediaQuery.of(context).size.width - crossAxisSpacing * 7) / 7,
                                      child: color_squer_hour(HourList[index], index % 4),
                                    );
                                  }),
                                )
                              //   GridView.count(
                              //     crossAxisCount: 5,
                              //     shrinkWrap: true,
                              //     physics: NeverScrollableScrollPhysics(),
                              //     crossAxisSpacing: 0.0,
                              //     mainAxisSpacing:0.0,
                              //     children: List.generate(HourList.length, (index) {
                              //       return Align(
                              //           alignment: Alignment.topLeft,
                              //           child: color_squer_hour(HourList[index],index%4),
                              //
                              //       );
                              //     }),
                              // ),
                            ),
                            space_V(15.0),
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                color_squer("حجزك",Color.fromARGB(197, 8, 246, 103),),
                                space_H(5.0),
                                color_squer("متاح",Color.fromARGB(
                                    97, 0, 0, 0)),
                                space_H(5.0),
                                color_squer("محجوز",Color.fromARGB(
                                    97, 246, 8, 8),),
                              ],
                            )
                          ],
                        ),
                      )
                      ,(){print("its worked fine");}),),

              space_V(25.0)
            ],
          ),
        ),
      ),
    );
  }
}
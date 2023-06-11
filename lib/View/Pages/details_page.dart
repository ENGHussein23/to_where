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

  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  late bool itsSameDay;

  bool showTimes=false;

  Map<DateTime, List<dynamic>> _events = {
    DateTime(2023, 6, 1): ['Event A'],
    DateTime(2023, 6, 5): ['Event B'],
    DateTime(2023, 6, 10): ['Event C'],
  };

  // CalendarController _calendarController = CalendarController();
  List<String> HourList =
  ['7:00 am', '8:00 am','9:00 am','10:00 am','11:00 am','12:00 pm',
    '1:00 pm','2:00 pm','3:00 pm','4:00 pm','5:00 pm', '6:00 pm',
    '7:00 pm','8:00 pm','9:00 pm','10:00 pm','11:00 pm'];

  ShowHours(List,from,where){
    for(int i=from;i<where;i++){
      SelectHour(HourList[i],i%3);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                              focusedDay:  _focusedDay, firstDay: DateTime(2023), lastDay: DateTime(2050),
                              headerStyle: HeaderStyle(titleCentered: true,formatButtonVisible: false),
                              calendarFormat: _calendarFormat,
                              weekendDays: [],
                              onDaySelected: (selectedDay, focusedDay) {
                                if (!isSameDay(_selectedDay, selectedDay)) {
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                    showTimes=false;
                                  });
                                }
                                else{
                                  setState(() {
                                    showTimes=true;
                                  });
                                }
                              },
                              selectedDayPredicate: (day) {
                                itsSameDay=isSameDay(_selectedDay, day);
                                print(itsSameDay.toString());
                                return itsSameDay;
                              },
                              // eventLoader: (day) {
                              //   return _events[day] ?? [DateTime(2023, 6, 1),
                              //     DateTime(2023, 6, 5),
                              //     DateTime(2023, 6, 10)];
                              // },
                              calendarStyle: const CalendarStyle(
                                  defaultDecoration: BoxDecoration(color: Color.fromARGB(97, 37, 52, 44),),
                                  todayDecoration: BoxDecoration(color: Color.fromARGB(97, 0, 111, 255),),
                                  selectedDecoration: BoxDecoration(color: Color.fromARGB(97, 0, 255, 117),),
                                  markerDecoration: BoxDecoration(color: Color.fromARGB(97, 246, 8, 8),),
                                  todayTextStyle: TextStyle(color: Colors.black),
                                selectedTextStyle: TextStyle(color: Colors.black),
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
                  visible: showTimes,
                  child: ItemContainerInnerWidget(
                      Container(
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
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                ),
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(child: Row(
                                      children: [
                                        SelectHour(HourList[0],0),
                                        SelectHour(HourList[1],0),
                                        SelectHour(HourList[2],2),
                                        SelectHour(HourList[3],0),
                                        SelectHour(HourList[4],0)

                                      ],
                                    ),),
                                    FittedBox(child: Row(
                                      children: [
                                        SelectHour(HourList[5],0),
                                        SelectHour(HourList[6],2),
                                        SelectHour(HourList[7],0),
                                        SelectHour(HourList[8],0),
                                        SelectHour(HourList[9],1)

                                      ],
                                    ),),
                                    FittedBox(child: Row(
                                      children: [
                                        SelectHour(HourList[10],0),
                                        SelectHour(HourList[11],2),
                                        SelectHour(HourList[12],2),

                                      ],
                                    ),),
                                  ],
                                )

                              //   GridView.count(
                              //     crossAxisCount: 5,
                              //     shrinkWrap: true,
                              //     physics: NeverScrollableScrollPhysics(),
                              //     ////////////////1
                              //     // children: List.generate(HourList.length, (index) {
                              //     //   return SelectHour(index%3, HourList[index]);
                              //     // }
                              //     /////////2
                              //     // children: List.generate(HourList.length, (index) {
                              //     //   return color_squer_hour(HourList[index],index%4);
                              //     // }),
                              //     //////////3
                              //     // children: [
                              //     //   SelectHour(HourList[0],0),
                              //     // ],
                              //     /////////4
                              //     // children: ListView.builder(itemBuilder: (context, index) {
                              //     //   return SelectHour(HourList[index],index) ;
                              //     // },),
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
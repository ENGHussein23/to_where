import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/Controller/Getx_controllers/booking_controller.dart';
import 'package:to_where/View/Pages/reservation_confirmation_page.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
import 'package:to_where/View/Widgets/item_container.dart';
import 'package:to_where/View/Widgets/small_widgets.dart';

class BookingPage extends StatefulWidget{
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  double crossAxisSpacing = 0.0;
  // @override
  // void initState() {
  //   super.initState();
  //   getEventsDayes();
  // }

  // List<DateTime>
  getEventsDayes(){
    return bookingController.getEvents;
  }
  DateTime focusedDay = DateTime.now();
  // DateTime? selectedDay;
  final bookingController=Get.put(BookingController());
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    List<Map<String, List<String>>> workingHoursMap=args['working_hours'];
    var WorkingHours=args['working_hours'];
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: const EdgeInsets.only(right: 15,left: 15),
        decoration: const BoxDecoration(color: Color.fromARGB(34, 107, 107, 107)),
        child: SingleChildScrollView(
             child: Column(
               textDirection: TextDirection.rtl,
               crossAxisAlignment: CrossAxisAlignment.start,
               children:  [
                 space_V(25.0),
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
                 // GetBuilder<BookingController>(
                 //   init: BookingController(),
                 //     builder: (bookingController){
                 Obx(() {
                   focusedDay=bookingController.focusedDay.value;
                   // selectedDay= bookingController.selectedDay.value;
                   bookingController.counter.value++;
                   final List<String> workDayes = bookingController.getKeys(workingHoursMap);
                   return Column(
                     children: [
                       ItemContainerInnerWidget(
                           Container(
                             padding: EdgeInsets.only(top: 3, right: 15, left: 15, bottom: 10),
                             child: Column(
                               children: [
                                 ElevatedButton(onPressed:(){
                                   print( bookingController.dateMap.keys);

                                 }, child: Text('child')),
                                 Row(
                                   textDirection: TextDirection.rtl,
                                   children: [
                                     Icon(
                                       Icons.calendar_month,
                                       color: Colors.white,
                                       size: 30,
                                       shadows: [
                                         Shadow(
                                           color: Colors.black45,
                                           blurRadius: 10,
                                           offset: Offset(1, 1),
                                         ),
                                         Shadow(
                                           color: Colors.black45,
                                           blurRadius: 10,
                                           offset: Offset(-1, -1),
                                         ),
                                         Shadow(
                                           color: Colors.black45,
                                           blurRadius: 10,
                                           offset: Offset(-1, 1),
                                         ),
                                         Shadow(
                                           color: Colors.black45,
                                           blurRadius: 10,
                                           offset: Offset(1, -1),
                                         ),
                                       ],
                                     ),
                                     space_H(4.0),
                                     NormalCustomTextWithWeight(
                                       "اختر اليوم",
                                       Colors.black45,
                                       16.0,
                                       FontWeight.w600,
                                     ),
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
                                         focusedDay: focusedDay,
                                         firstDay: DateTime(2021),
                                         lastDay: DateTime(2080),
                                         calendarFormat: bookingController.calendarFormat.value,
                                         headerStyle: const HeaderStyle(
                                           titleCentered: true,
                                           formatButtonVisible: false,
                                         ),
                                         weekendDays: bookingController.getRemainingDays(workDayes),
                                         onFormatChanged: (format) {
                                           bookingController.calendarFormat.value = format;
                                         },
                                         selectedDayPredicate: (day) {
                                           return bookingController.selectedDay.value == day;
                                         },
                                         onDaySelected: (selectedDay, focusedDay) {
                                           bookingController.counter.value++;
                                           if (!bookingController.isWeekendDay(
                                             selectedDay.toString(),
                                             bookingController.getRemainingDays(workDayes),
                                           ))
                                           {
                                             bookingController.selectedDay.value = selectedDay;
                                             bookingController.focusedDay.value = focusedDay;
                                           }
                                           print("==================================");
                                           print("_selectedDay : ${bookingController.selectedDay.value}");
                                           print("selectedDay : $selectedDay");
                                           print("_focusedDay : ${bookingController.focusedDay.value}");
                                           print("focusedDay : $focusedDay");
                                           print("==================================");
                                         },
                                         eventLoader: bookingController.getEvents,
                                         calendarStyle: CalendarStyle(
                                           isTodayHighlighted: false,
                                           weekendDecoration: BoxDecoration(
                                             color: Color.fromARGB(50, 37, 52, 44),
                                             image: DecorationImage(
                                               image: AssetImage("assets/images/x.png"),
                                             ),
                                           ),
                                           defaultDecoration:
                                           BoxDecoration(color: Color.fromARGB(50, 37, 52, 44)),
                                           selectedDecoration:
                                           BoxDecoration(color: Color.fromARGB(150, 0, 255, 117)),
                                           markerDecoration: BoxDecoration(
                                             // color: Color.fromARGB(150, 255, 0, 0),
                                             shape: BoxShape.rectangle,
                                             image: DecorationImage(
                                               image: AssetImage("assets/images/Solid_red.png"),
                                               opacity: 0.4,
                                             ),
                                           ),
                                           todayDecoration:
                                           BoxDecoration(color: Color.fromARGB(255, 160, 245, 42)),
                                           todayTextStyle: TextStyle(color: Colors.black),
                                           selectedTextStyle: TextStyle(color: Colors.black),
                                           // markersAutoAligned: true,
                                           defaultTextStyle: TextStyle(color: Colors.black),
                                           markersOffset:
                                           PositionedOffset(start: 0, bottom: 0, end: 0, top: 0),
                                           cellMargin:
                                           EdgeInsets.only(top: 5, bottom: 9, left: 5, right: 5),
                                           markersAnchor: 1,
                                           markerSize: 38,
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
                                           Visibility(
                                               visible: true,
                                               child: SizedBox(
                                                 height: 0.0,
                                                 width: 0.0,
                                                 child: color_squer("${bookingController.counter.value}",Color.fromARGB(
                                                     97, 246, 8, 8),),
                                               ))
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
                       ItemContainerInnerWidget(
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
                                       runSpacing: -crossAxisSpacing * 5,
                                       children: List.generate(
                                         WorkingHours?.length ?? 0,
                                             (index) {
                                           return SizedBox(
                                             width: (MediaQuery.of(context).size.width - crossAxisSpacing * 7) / 7,
                                             child: color_squer_hour(
                                               WorkingHours[index]['open_hour'].toString(),
                                               index % 4,
                                             ),
                                           );
                                         },
                                       ),
                                     )
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
                           ,(){print("its worked fine");}),
                     ],
                   );
                 },),

               ],
             )
        )
      ),
    );
  }
}
import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/Controller/Constants/strings.dart';
import 'package:to_where/View/Pages/booking_page.dart';
import 'package:to_where/View/Pages/details_page.dart';
import 'package:to_where/View/Pages/service_loction_page.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
import 'package:to_where/View/Widgets/buttons.dart';
import 'package:to_where/View/Widgets/item_container.dart';

class ClassItemPage extends StatelessWidget{
  String days_string='';
  List<String> extractDays(jsonStr) {
    // var workingHours = jsonDecode(jsonStr);
    List<String> uniqueDays = [];
    print("========111======");
    days_string='';
    for (var wh in jsonStr) {
      print(wh['day']['name_ar'].toString());
      print("==============");
      uniqueDays.add(wh['day']['name_ar']);
    }
    List<String> listWithoutDuplicates = uniqueDays.toSet().toList();
    for (int i=0;i<listWithoutDuplicates.length-1;i++)
      days_string="$days_string${listWithoutDuplicates[i]} -";
    days_string=days_string+listWithoutDuplicates[listWithoutDuplicates.length-1];
    return listWithoutDuplicates.toList();
  }
  List<Map<String, List<String>>> getWorkingHoursMap(List<dynamic> workingHoursList) {
    List<String> days = [];
    List<Map<String, List<String>>> workingHoursMap = [];

    // First, get a list of unique days
    for (var i = 0; i < workingHoursList.length; i++) {
      if (!days.contains(workingHoursList[i]['day']['name_ar'])) {
        days.add(workingHoursList[i]['day']['name_ar']);
      }
    }

    // Create a map for each unique day
    for (var i = 0; i < days.length; i++) {
      List<String> hours = [];

      for (var j = 0; j < workingHoursList.length; j++) {
        if (workingHoursList[j]['day']['name_ar'] == days[i]) {
          hours.add(workingHoursList[j]['open_hour']);
        }
      }

      // Sort the hours in ascending order
      hours.sort((a, b) => a.compareTo(b));

      workingHoursMap.add({days[i]: hours});
    }

    return workingHoursMap;
  }
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = Get.arguments;
    var service = args["service"];
    var distance=args["distance"];
    print(service['working_hours'].toString());
    List<String> days = extractDays(service['working_hours']);
    print(' : $days');
    print("==================");
    print(days_string);
    print("==================");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
  return Scaffold(
    body: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: screenHeight,
        decoration: const BoxDecoration(color: Color.fromARGB(34, 107, 107, 107)),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            // Obx(
            //       () {
            //     if(service["images"]==null){
            //       return ItemContainer("Loading...", () { });
            //     }
            //     else{
            //       return
                    Container(
                      height: 150,
                      child:  PageView.builder(
                          itemCount:service["images"].length,
                          itemBuilder: (_,i){
                            return GestureDetector(
                                child: Container(
                                  height: 220,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(baseUrl2Images+service["images"][i]['image']),
                                        fit: BoxFit.cover, // make the image cover the entire area of the container
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                      color: i.isEven?const Color.fromARGB(100, 83, 109, 254):const Color.fromARGB(100, 0, 100, 136)
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child:     DotsIndicator(
                                      dotsCount: service["images"].length,
                                      position: i,
                                      decorator: DotsDecorator(
                                        color: Colors.white,
                                        activeColor: Colors.grey,
                                        size: const Size(8, 8),
                                        activeSize: const Size(12, 12),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: (){}
                            );
                          }),
                    ),
    // ;
    //             }
    //             return Container();
    //           },
    //         ),
    //         Image(image: NetworkImage(baseUrl2Images+service["images"][0]['image']), height: 150,width: screenWidth,fit: BoxFit.cover,),
            Container(
              margin: EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(15),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Directionality(textDirection: TextDirection.rtl, child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         RatingAndDistanceButton(service["average_rating"].toString(),Icons.star,Colors.amberAccent,(){print("hi 2");},false),
                         SizedBox(height: 2,),
                         RatingAndDistanceButton(distance+"كم",Icons.location_pin,Colors.black87,(){print("hi 1"); Get.to(
                             ServiceLoctionPage(double.parse(service["latitude"]),double.parse(service["longtude"]),service["title_ar"]));},true),
                       ],
                     ),),
                     Row(
                       textDirection: TextDirection.rtl,
                       children: [
                         Container(
                           height: 22,
                           width: 22,
                           decoration: BoxDecoration(
                             color: almost_bright_green,
                             borderRadius: BorderRadius.circular(100),
                             border: Border.all(
                               color: Colors.black,
                               width: 2
                             )
                           ),
                         ),
                         SizedBox(width: 6,),
                         Text(service["title_ar"],textDirection: TextDirection.rtl,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w700,fontSize: 20),)
                       ],
                     )
                   ],
                 ),
                  SizedBox(height: 10,),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      NormalCustomTextWithWeight("السعر : ",almost_bright_green,18.0,FontWeight.w400),
                      NormalCustomTextWithWeight(service['price'],Color.fromARGB(130, 50, 50, 50),17.0,FontWeight.w400),
                      NormalCustomTextWithWeight(" ريال",Color.fromARGB(157, 50, 50, 50),17.0,FontWeight.w400),
                  ],),
                  NormalCustomTextWithWeight("أيام العمل :",almost_bright_green,18.0,FontWeight.w400),
                  NormalCustomTextWithWeight(days_string,Color.fromARGB(157, 50, 50, 50),16.0,FontWeight.w400),
                  SizedBox(height: 20,),
                  NormalCustomTextWithWeight("الشروط و الأحكام للخدمة : ",almost_bright_green,18.0,FontWeight.w400),
                  // NormalCustomTextWithWeight("حجزك لهذه الخدمة تعني تأكيد موافقتك على كافة الأحكام و الشروط",Color.fromARGB(157, 50, 50, 50),16.0,FontWeight.w400),
                  NormalCustomTextWithWeight(service['terms_and_conditions_ar'],Color.fromARGB(157, 50, 50, 50),16.0,FontWeight.w400),
                  SizedBox(height: 20,),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      NormalCustomTextWithWeight("الحد المسموح لحجز الواحد : ",Colors.black,18.0,FontWeight.w400),
                      NormalCustomTextWithWeight(service['capacity'],Color.fromARGB(130, 50, 50, 50),17.0,FontWeight.w400),
                      NormalCustomTextWithWeight(" شخص",Color.fromARGB(157, 50, 50, 50),17.0,FontWeight.w400),
                    ],),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      NormalCustomTextWithWeight("العمر : ",Colors.black,18.0,FontWeight.w400),
                      NormalCustomTextWithWeight(service["min_reservation"],Color.fromARGB(130, 50, 50, 50),17.0,FontWeight.w400),
                      NormalCustomTextWithWeight(" الى ",Color.fromARGB(157, 50, 50, 50),17.0,FontWeight.w400),
                      NormalCustomTextWithWeight(service["max_reservation"],Color.fromARGB(130, 50, 50, 50),17.0,FontWeight.w400),
                      NormalCustomTextWithWeight(" سنة ",Color.fromARGB(157, 50, 50, 50),17.0,FontWeight.w400),
                    ],),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      NormalCustomTextWithWeight("الحجز و الإلغاء : ",Colors.black,18.0,FontWeight.w400),
                      NormalCustomTextWithWeight("الحجز غير قابل للإلغاء الاسترجاع",Color.fromARGB(157, 50, 50, 50),17.0,FontWeight.w400),
                    ],),
                  SizedBox(height: 10,),
                  NormalCustomTextWithWeight(service["description_ar"],almost_bright_green,18.0,FontWeight.w400),

                  SizedBox(height: 30,),
                  Center(
                    child: ItemContainerGridButton("اختيار",60.0,120.0,(){print("its worked here");
                    List<Map<String, List<String>>> workingHoursMap = getWorkingHoursMap(service["working_hours"]);
                    for(int i =0;i<workingHoursMap.length;i++){
                      print (i.toString()+workingHoursMap[i].keys.toString());
                    }
                    Get.to(DetailsPage(),arguments: {
                      "working_hours":workingHoursMap,
                      "service_id":service["id"].toString(),
                    });}),
                  )

                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
  }

}
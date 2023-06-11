import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_where/Controller/Constants/strings.dart';
import 'package:to_where/Controller/Getx_controllers/ClassificationPageController.dart';
import 'package:to_where/View/Pages/class_item_page.dart';
import 'package:to_where/View/Widgets/item_container.dart';

class ClassificationPageNew extends StatelessWidget{
  final classificationPageController = Get.put(ClassificationPageController());

   String calculateDistance(double lat1, double lon1,double lat2, double lon2) {
    print("lat1 : $lat1 \nlon1 : $lon1 \nlat2 : $lat2 \nlon2 : $lon2");
    const int earthRadius = 6371; // in km
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    print(distance.toString());
    String formattedNumber = distance.toStringAsFixed(2);
    print(formattedNumber);
    return formattedNumber;
  }

  double _toRadians(double degrees) {
    return degrees * pi / 180;
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40, right: 15, left: 15),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                ItemContainerRTL("جمعات", () {}),
                  SizedBox(height: 10),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Obx(() => TabButton(
                        "فنادق",
                        classificationPageController.selectedIndex.value == 1,
                            () {classificationPageController.selectTab(1);},)),
                      SizedBox(width: 10),
                      Obx(() => TabButton("استراحات", classificationPageController.selectedIndex.value == 5,
                            () {classificationPageController.selectTab(5);},)),
                      SizedBox(width: 10),
                      Obx(() => TabButton("شاليهات", classificationPageController.selectedIndex.value == 2,
                            () {classificationPageController.selectTab(2);},
                      )),
                      SizedBox(width: 10),
                      Obx(() => TabButton("مخيمات", classificationPageController.selectedIndex.value == 6,
                            () {classificationPageController.selectTab(6);},)),
                      SizedBox(width: 10),
                      Obx(() => TabButton("مزارع", classificationPageController.selectedIndex.value == 7,
                            () {classificationPageController.selectTab(7);},)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: screenHeight - 175,
                    child: Obx(() {
                      if (classificationPageController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if(classificationPageController.index_test.value!=0){

                          return ListView.builder(
                          shrinkWrap: true,
                          itemCount:classificationPageController.responsebody['data']['data'].length,
                          itemBuilder: (context, index) {
                            var service=classificationPageController.responsebody['data']['data'][index];
                            String Dis=calculateDistance(
                                classificationPageController.lat1,
                                classificationPageController.lon1,
                                double.parse(classificationPageController.responsebody['data']['data'][index]["latitude"]??"0.0"),
                                double.parse(classificationPageController.responsebody['data']['data'][index]["longtude"]??"0.0")).toString();
                          return Column(
                          children: [
                          ItemFromClass(
                          classificationPageController.responsebody['data']['data'][index]["title_ar"],
                          classificationPageController.responsebody['data']['data'][index]["description_ar"],
                          baseUrl2Images+classificationPageController.responsebody['data']['data'][index]["images"][0]['image'],
                            // "1514.81"+"كم",
                            "${calculateDistance(
                                classificationPageController.lat1,
                                classificationPageController.lon1,
                                double.parse(classificationPageController.responsebody['data']['data'][index]["latitude"]??"0.0"),
                                double.parse(classificationPageController.responsebody['data']['data'][index]["longtude"]??"0.0"))}كم",
                          classificationPageController.responsebody['data']['data'][index]["average_rating"].toString(),
                          () {
                          print("its work $index");
                          Get.to(ClassItemPage(),
                          arguments: {
                            'distance':Dis,
                            "service":service
                          });
                          },
                          ),
                          const SizedBox(height: 10),
                          ],
                          );
                          },
                          );
                          }
                      else{
                        return Center(child: Text("لا يوجد بيانات لهذا التصنيف"),);
                      }
                        }
                    ),
                  ),
                ]
            ),
          )
        ),
      ),
    );
  }
}
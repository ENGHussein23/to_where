import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/View/Pages/class_item_page.dart';
import 'package:to_where/View/Widgets/buttons.dart';
import 'package:to_where/View/Widgets/item_container.dart';
import 'package:to_where/Controller/Getx_controllers/ClassificationController.dart';

class ClassificationPage extends StatelessWidget {
  final classificationController = Get.put(ClassificationController());

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
                      classificationController.selectedIndex.value == 0,
                          () {
                        classificationController.selectTab(0);
                      },
                    )),
                    Obx(() => TabButton(
                      "استراحات",
                      classificationController.selectedIndex.value == 0,
                          () {
                        classificationController.selectTab(0);
                      },
                    )),
                    SizedBox(width: 10),
                    Obx(() => TabButton(
                      "شاليهات",
                      classificationController.selectedIndex.value == 1,
                          () {
                        classificationController.selectTab(1);
                      },
                    )),
                    SizedBox(width: 10),
                    Obx(() => TabButton(
                      "مخيمات",
                      classificationController.selectedIndex.value == 2,
                          () {
                        classificationController.selectTab(2);
                      },
                    )),
                    SizedBox(width: 10),
                    Obx(() => TabButton(
                      "مزارع",
                      classificationController.selectedIndex.value == 3,
                          () {
                        classificationController.selectTab(3);
                      },
                    )),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: screenHeight - 175,
                  child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount://10,
                    classificationController.selectedItems.length,
                    itemBuilder: (context, index) {
                      final item =
                      classificationController.selectedItems[0];
                      return Column(
                        children: [
                          ItemFromClass(
                            item["title"],
                            item["subtitle"],
                            item["image"],
                            item["distance"],
                            item["rating"],
                                () {
                              print("its work $index");
                              Get.to(ClassItemPage());
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
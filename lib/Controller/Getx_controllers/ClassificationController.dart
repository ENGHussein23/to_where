import 'package:get/get.dart';

class ClassificationController extends GetxController {
  var selectedIndex = 0.obs;

  var items = [
    {
      "title": "استراحة النور",
      "subtitle": "سويت كامل",
      "image": "assets/images/Tourist break.jpg",
      "distance": "135 كم",
      "rating": "4.0",
    },
    {
      "title": "شاليه على البحر",
      "subtitle": "بركة صالتين غرفة",
      "image": "assets/images/chalet.jpg",
      "distance": "5.34 كم",
      "rating": "4.8",
    },
    {
      "title": "مخيم الرمال",
      "subtitle": "خيمة مطبخ غرفة ",
      "image": "assets/images/camp.jpg",
      "distance": "55.35 كم",
      "rating": "4.5",
    },
    {
      "title": "مزارع الرمال",
      "subtitle": "فيلا طابقين",
      "image": "assets/images/own farm.jpg",
      "distance": "80.34 كم",
      "rating": "3.5",
    },
  ].obs;

  void selectTab(int index) {
    selectedIndex.value = index;
  }

  List<Map<String, dynamic>> get selectedItems {
    switch (selectedIndex.value) {
      case 0:
        return [items[0]];
      case 1:
        return [items[1]];
      case 2:
        return [items[2]];
      case 3:
        return [items[3]];
      default:
        return [items[0]];
    }
  }
}
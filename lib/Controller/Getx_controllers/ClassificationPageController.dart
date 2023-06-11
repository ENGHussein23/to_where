import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_where/Model/customer_service_model.dart';

import '../Constants/strings.dart';

class ClassificationPageController extends GetxController {
  var selectedIndex = 1.obs;
  var responsebody;
  double lat1=0.0;
  double lon1=0.0;
  RxInt index_test=0.obs;
  var isLoading = false.obs;
  // var customerService=CustomerService().obs;
  @override
  void onInit() {
    selectTab(1);
    super.onInit();
  }

  void selectTab(int index) async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString('access_token') ?? '';
    lat1=prefs.getDouble('latitude')!;
    lon1=prefs.getDouble('longitude')!;
    selectedIndex.value = index;
try{

  var response = await http.get(Uri.parse('$CustomerServiceIndex$index'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $access_token'
      });
  print("==========1111111111==========");
  if (response.statusCode == 200) {
    print("==========2222222222==========");
    responsebody=json.decode(response.body);
    index_test.value=(responsebody['data']['data'].length);
    print(responsebody['data']['data'].length);
    isLoading.value = false;
    print("==========2222222222==========");
    // CustomerService Service=CustomerService.fromJson(json.decode(response.body));
    // customerService.value=Service;
    print("===========333333333333=========");
    // print(customerService.value.data.data[0].images.toString());
  } else {
    isLoading.value = false;
    // Handle error
    print('Error fetching items: ${response.statusCode}');
  }
  isLoading.value = false;
}catch(e){
  print("this is what happen : $e");
  isLoading.value = false;
}
  }
}
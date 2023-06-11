// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:to_where/Controller/Constants/strings.dart';
// import 'package:to_where/View/Pages/main_screen.dart';
//
// class AuthController extends GetxController {
//   var isLoading = false.obs;
//
//   Future<void> login(String phone, String password) async {
//     isLoading.value = true;
//
//     try {
//       final headers = {'Accept': 'application/json'};
//       final body = {'phone': phone, 'password': password};
//
//       final response = await http.post(
//         Uri.parse(CustomerLoginUrl),
//         headers: headers,
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         final responseBody = response.body;
//         final jsonData = jsonDecode(responseBody);
//         print("status is 200 \n handle successful login response \n$jsonData");
//         // TODO: handle successful login response
//         Get.snackbar(
//           'تم تسجيل الدخول بنجاح',
//           '',
//           backgroundColor: Color.fromARGB(150, 0, 250, 50),
//           colorText: Color.fromARGB(200, 240, 240, 240),
//           icon: Icon(Icons.gpp_good, color: Colors.white),
//         );
//         Get.to(MainScreen());
//       } else {
//         final responseBody = response.body;
//         final jsonData = jsonDecode(responseBody);
//
//         print(
//             "handle unsuccessful login response \n$jsonData \nphone $phone\npassword $password \n=====================");
//         // TODO: handle unsuccessful login response
//         Get.snackbar(
//           'حدث خطأ في تسجيل الدخول',
//           '${jsonData['message'] ?? "Unauthorized"}',
//           backgroundColor: Color.fromARGB(150, 240, 20, 20),
//           colorText: Color.fromARGB(200, 240, 240, 240),
//           icon: Icon(Icons.gpp_bad, color: Colors.white),
//         );
//       }
//     } on SocketException catch (e) {
//       print("handle network error \n$e");
//       // TODO: handle network error
//       Get.snackbar(
//         'حدث خطأ في تسجيل الدخول',
//         'يوجد خطأ في الشبكة'
//             '\n $e',
//         backgroundColor: Color.fromARGB(123, 20, 20, 20),
//         colorText: Color.fromARGB(200, 240, 240, 240),
//         icon: Icon(Icons.gpp_bad_outlined, color: Colors.white),
//       );
//     } catch (e) {
//       print("handle error \n$e");
//       // TODO: handle other errors
//       Get.snackbar(
//         'حدث خطأ في تسجيل الدخول',
//         'حدث خطأ غير متوقع',
//         backgroundColor: Color.fromARGB(123, 20, 20, 20),
//         colorText: Color.fromARGB(200, 240, 240, 240),
//         icon: Icon(Icons.gpp_bad_outlined, color: Colors.white),
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_where/Controller/Constants/strings.dart';
import 'package:to_where/View/Pages/main_screen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  RxString errorMessage=''.obs ;
  Future<void> login(String phone, String password) async {
    isLoading.value = true;

    var headers = {
      'Accept': 'application/json',
    };

    // var client = HttpClient()
    //   ..badCertificateCallback =
    //   ((X509Certificate cert, String host, int port) => true);
    // var request = await client.postUrl(Uri.parse(CustomerLoginUrl));
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(CustomerLoginUrl),
    );
    request.fields.addAll({
      'phone': phone,
      'password': password,
    });
    // request.write({
    //   'phone': phone,
    //   'password': password,
    // });
    // request.headers.add('Accept', 'application/json');
    request.headers.addAll(headers);
    try {
      final response = await request.send();
      // final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        // final responseBody = await response.transform(utf8.decoder).join();
        final jsonData = jsonDecode(responseBody);
        print("status is 200 \n handle successful login response \n$jsonData");
        // TODO: handle successful login response
        Get.snackbar(
          'تم تسجيل الدخول بنجاح',
          '',
          backgroundColor: Color.fromARGB(150, 0, 250, 50),
          colorText: Color.fromARGB(200, 240, 240, 240),
          icon:Icon(Icons.gpp_good,color: Colors.white,),
          duration: const Duration(seconds: 1),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token',  jsonData['access_token'] );
        Get.to(MainScreen());
      } else {
        final responseBody = await response.stream.bytesToString();
        // final responseBody = await response.transform(utf8.decoder).join();
        final jsonData = jsonDecode(responseBody);

        print("handle unsuccessful login response \n$jsonData \nphone $phone\npasswprd $password \n=====================");
        // TODO: handle unsuccessful login response
        errorMessage.value=jsonData['message'];
        print("===="+jsonData['message']+"====");
        Get.snackbar(
          'حدث خطأ في تسجيل الدخول',
          '${jsonData['message']??"Unauthorized"}',
          backgroundColor: Color.fromARGB(150, 240, 20, 20),
          colorText: Color.fromARGB(200, 240, 240, 240),
          icon:Icon(Icons.gpp_bad,color: Colors.white,),
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      if(e!="Connection timed out")
      errorMessage.value="Unauthorized";
      else
        errorMessage.value="";
      print("handle network error \n$e");
      // TODO: handle network error
      Get.snackbar(
        'حدث خطأ في تسجيل الدخول',
        e=="Connection timed out"?'يوجد خطأ في الشبكة':'يرجى التأكد من البيانات المدخلة',
        backgroundColor: Color.fromARGB(123, 20, 20, 20),
        colorText: Color.fromARGB(200, 240, 240, 240),
        icon:Icon(Icons.gpp_bad_outlined,color: Colors.white,),
        duration: const Duration(seconds: 1),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
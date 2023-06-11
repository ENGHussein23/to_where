import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:to_where/Controller/Constants/strings.dart';
import 'package:to_where/View/Pages/verification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RegisterController extends GetxController {
  var isLoading = false.obs;
RxString errorMessage=''.obs;
  // var JsonTest={};
  String getPossibilities(json) {
    if(json["errors"]==null||json["errors"].length==0){
      return "";
    }
    bool hasName = json["errors"].containsKey("name")??false;
    bool hasPhone = json["errors"].containsKey("phone")??false;
    bool hasPassword = json["errors"].containsKey("password")??false;

      if (hasName && hasPhone && hasPassword) {
      print("======0.1 hasName && hasPhone && hasPassword.======");
      return "a";
    } else if (hasName && hasPhone) {
      print("======0.1 hasName && hasPhon======");
      return "b";
    } else if (hasName && hasPassword) {
      print("======0.1 hasName && hasPassword======");
      return "c";
    } else if (hasPhone && hasPassword) {
      print("======0.1 hasPhone && hasPassword======");
      return "d";
    } else if (hasName) {
      print("======0.1 hasName======");
      return "e";
    } else if (hasPhone) {
      print("======0.1 hasPhone======");
      return "f";
    } else if (hasPassword) {
      print("======0.1 hasPassword======");
      return "g";
    } else {
      print("======0.1 no error here======");
      return ""; // No errors found
    }
  }
  Future<void> register(String phone, String name, String password, String confirmPassword) async {
    isLoading.value = true;

    if (password != confirmPassword) {
      errorMessage.value="Passwords do not match";
      Get.snackbar('Error', 'Passwords do not match',duration: const Duration(seconds: 1),);
      isLoading.value = false;
      return;
    }
    var headers = {
      'Accept': 'application/json',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(CustomerRegisterUrl),
    );
    request.fields.addAll({
      'phone': phone,
      'name': name,
      'password': password,
      'password_confirmation': confirmPassword,
    });
    print(request.fields);
    request.headers.addAll(headers);
    try {
      print("===========1==========");
      final response = await request.send();
      if (response.statusCode == 200) {
        print("===========2==========");
        final responseBody = await response.stream.bytesToString();
        print("===========3==========");
        final jsonData = jsonDecode(responseBody);
        print("===========4==========");
        // JsonTest=jsonData;
        print(jsonData);
        errorMessage.value= getPossibilities(jsonData );
        print("status is 200 \n handle successful registration responsee \n$jsonData");
        // TODO: handle successful registration response
        Get.snackbar(
          // 'اهلا و سهلا',
          '','',
            // 'تمت عملية انشاء الحساب بنجاح',
          titleText: Text(
            'أهلا و سهلا',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromARGB(150, 0, 250, 50),
          colorText: Color.fromARGB(200, 240, 240, 240),
          icon:Icon(Icons.gpp_good,color: Colors.white,),
            messageText: const Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تمت عملية انشاء الحساب بنجاح',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),),
          duration: const Duration(seconds: 1),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token',  jsonData['access_token'] );
        Get.to(VerificationPage());
      } else {
        print("===========5==========");
        final responseBody = await response.stream.bytesToString();
        print("===========6==========");
        final jsonData = jsonDecode(responseBody);
        print("===========7==========");
        // JsonTest=jsonData;
        print("===========8==========");
        print('jsonData :$jsonData');
        print("===========9==========");

        // TODO: handle unsuccessful registration response
        Get.snackbar('حدث خطأ في انشاء الحساب', jsonData['message'] ?? 'Registration failed',
          backgroundColor: Color.fromARGB(150, 240, 20, 20),
          colorText: Color.fromARGB(200, 240, 240, 240),
          icon:Icon(Icons.gpp_bad,color: Colors.white,),
        animationDuration: Duration(seconds: 1));
        errorMessage.value= getPossibilities(jsonData );
        print("===========10==========");
      }
    } catch (e) {
      // if(e!="Connection timed out"|| e=="Failed host lookup: '3la-ween.nourcheaito.com'")
      //   errorMessage.value="h"; //JsonTest=jsonData;
      //
      // else

        // if(e=="Connection timed out"|| e=="Failed host lookup: '3la-ween.nourcheaito.com'")
        //   errorMessage.value="h";
        // else if(e=="type '_Map<String, dynamic>' is not a subtype of type 'String'")
        //   errorMessage.value="";
        if(password==''&&confirmPassword==''&&name==''&&phone=='')
          errorMessage.value="a";
        else if(e!="Connection timed out")
          errorMessage.value="";
      else
        errorMessage.value="";
      // TODO: handle network error
      print("handle network error \n /$e/");
      Get.snackbar(
        // 'حدث خطأ في انشاء الحساب',
        '',  '',
        // '',
        titleText: const Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'حدث خطأ في انشاء الحساب',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),),
        messageText:  Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            errorMessage.value=='h'?"يوجد خطأ في الاتصال":'يمكن أن يكون الخطأ من الشبكة أو بسبب عدم تعبئة الخانات بشكل صحيح',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),),
        // (e=="Connection timed out"|| e=="Failed host lookup: '3la-ween.nourcheaito.com'")?'يوجد خطأ في الشبكة':"يرجى التأكد من تعبئة الخانات بشكل صحيح",
        backgroundColor: Color.fromARGB(123, 20, 20, 20),
        colorText: Color.fromARGB(200, 240, 240, 240),
        icon:Icon(Icons.gpp_bad_outlined,color: Colors.white,),
      );
    }

    isLoading.value = false;
  }
}
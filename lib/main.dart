import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_where/Controller/Getx_controllers/AuthController.dart';
import 'package:to_where/Controller/Getx_controllers/RegisterController.dart';
import 'package:to_where/View/Pages/register_page.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  Get.put(AuthController());
  Get.put(RegisterController());
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'على وين',
      theme: ThemeData(
        fontFamily: 'Vazirmatn',
        primarySwatch: Colors.teal,
      ),
      home: RegisterPage(),
    );
  }
}

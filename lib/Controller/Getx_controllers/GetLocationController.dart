import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLocationController extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);

  @override
  void onInit() {
    super.onInit();
    checkLocationPermission();
  }

  void checkLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      getCurrentLocation();
    }
  }

  void getCurrentLocation() async {
    try {
      final currentPositionData = await Geolocator.getCurrentPosition();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('longitude', currentPositionData.longitude);
      await prefs.setDouble('latitude', currentPositionData.latitude);
      print('\nlongitude : ${prefs.getDouble('longitude')} \nlatitude : ${prefs.getDouble('latitude')} ');
      currentPosition.value = currentPositionData;
    } catch (e) {
      print("this is why it doesnt work $e");
    }
  }
}
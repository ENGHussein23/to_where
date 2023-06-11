import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_where/Controller/Constants/strings.dart';
class DetailsPageController extends GetxController{
  var isDayLoading = false.obs;
  RxInt testCounter=0.obs;
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay= DateTime.now();
  // bool isTheSameDay = false;
  List<String> HourList = ['7:00 am', '8:00 am','9:00 am','10:00 am','11:00 am','12:00 pm',
    '1:00 pm','2:00 pm','3:00 pm','4:00 pm','5:00 pm', '6:00 pm',
    '7:00 pm','8:00 pm','9:00 pm','10:00 pm','11:00 pm'];

  void selectDay(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
      update();
    }
  }
// selectedDayPredicate(day) {
//   return isSameDay(selectedDay, day);
//   }
}
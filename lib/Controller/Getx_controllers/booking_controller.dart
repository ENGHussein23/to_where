import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_where/Controller/Constants/strings.dart';
import 'package:to_where/Model/month_year_model.dart';
import 'package:to_where/View/Widgets/item_container.dart';
class BookingController extends GetxController {
  var counter =0.obs;
  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  Rx<DateTime>  focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay= DateTime.now().obs;
  List<MonthYear> monthYear3=[];
  List<MonthYear> monthYearMax=[];
  // var dateHours = <String, List<MonthYear>>{};
  Map<DateTime, List<MonthYear>> dateMap = {};
  @override
  void onInit() {
    super.onInit();
    print("it requested");
    testapi(focusedDay.value,2);
  }

  Map<int, List<String>> createOpenHoursMap( workingHoursList) {
    // Map to store the open hours for each day
    Map<int, List<String>> openHoursMap = {};

    // Loop through the working hours list
    for (Map<String, dynamic> workingHours in workingHoursList) {
      // Get the day ID from the "day" object
      int dayId = workingHours["day"]["id"];

      // Adjust the day ID to start from 1, where Monday is 1 and Sunday is 7
      dayId = dayId % 7 + 1;

      // Get the open hour from the "open_hour" property
      String openHour = workingHours["open_hour"];

      // Convert the open hour to 24-hour format
      DateTime openHourTime = DateFormat.jm().parse(openHour);
      openHour = DateFormat.H().format(openHourTime);

      // Add the open hour to the list for the corresponding day ID
      if (openHoursMap.containsKey(dayId)) {
        openHoursMap[dayId]!.add(openHour);
      } else {
        openHoursMap[dayId] = [openHour];
      }
    }

    return openHoursMap;
  }
  testapi( DateTime day,int max_hours)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString('access_token') ?? '';
    // the api url CustomerMonthYear
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(CustomerMonthYear),
    );
    request.fields.addAll({
      'year': day.year.toString(),
      'month':day.month.toString(),
      'service_id':'19'
    });
    request.headers.addAll(headers);
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final jsonData3 = jsonDecode(responseBody);
    monthYear3=[];
    monthYear3 = jsonData3.map<MonthYear>((item) => MonthYear.fromJson(item)).toList();
    var dateCounts = <String, int>{};
    for (int i=0;i<monthYear3.length;i++) {
      var date = monthYear3[i].date;
      dateCounts[date] = (dateCounts[date]??0) + 1;
    }
    monthYearMax=[];
    for(int i=0;i<monthYear3.length;i++){
      if(dateCounts[monthYear3[i].date]==max_hours) {
        bool foundIt=false;
        for(int j=0;j<monthYearMax.length;j++){
          if(monthYearMax[j].date == monthYear3[i].date){
            foundIt=true;
            break;
          }
        }
        if(!foundIt){
          monthYearMax.add(monthYear3[i]);
        }
      }
    }

    dateMap = {};
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    for (int i = 0; i < monthYear3.length; i++) {
      DateTime date = dateFormat.parse(monthYear3[i].date);
      if (dateMap.containsKey(date)) {
        dateMap[date]?.add(monthYear3[i]);
      } else {
        dateMap[date] = [monthYear3[i]];
      }
    }
}
  List<DateTime> getEvents(DateTime day)  {
    List<DateTime> eventDates = [];
    // Fetch data from the API
    testapi(day,2);
    // Check for marked dates
    for (int i = 0; i < monthYearMax.length; i++) {
      try {
        DateTime date = DateFormat("yyyy-MM-dd").parse(monthYearMax[i].date);
        if (date.day == day.day && date.month == day.month && date.year == day.year) {
          eventDates.add(date);
          print("Marked date: ${date.day}-${date.month}-${date.year}");
        }
      } catch (e) {print("Error parsing date: $e");}
    }
    if (eventDates.isNotEmpty) {
      return eventDates;
    }
    // If no events are found, return an empty list
    print("No events found for ${day.day}-${day.month}-${day.year}");
    return eventDates;
  }
  bool isWeekendDay(String dateString, List<int> weekendDays) {
    DateTime date = DateTime.parse(dateString);
    int weekday = date.weekday;
    return weekendDays.contains(weekday);
  }
  bool isDateMarked(String dateString, List<DateTime> markedDates) {
    DateTime dateToCheck = DateTime.parse(dateString);
    for (DateTime markedDate in markedDates) {
      if (markedDate.year == dateToCheck.year &&
          markedDate.month == dateToCheck.month &&
          markedDate.day == dateToCheck.day) {
        return true;
      }
    }
    return false;
  }
  bool showTimes=false;
  List<String> HourList =
  ['7:00 am', '8:00 am','9:00 am','10:00 am','11:00 am','12:00 pm', '1:00 pm','2:00 pm','3:00 pm','4:00 pm','5:00 pm', '6:00 pm', '7:00 pm','8:00 pm','9:00 pm','10:00 pm','11:00 pm'];
  ShowHours(List,from,where){
    for(int i=from;i<where;i++){
      SelectHour(HourList[i],i%3);
    }
  }
  List<String> getKeys(List<Map<String, List<String>>> inputList) {
    List<String> outputList = [];
    for (var map in inputList) {outputList.addAll(map.keys);}
    return outputList;
  }
  List<int> getRemainingDays(List<String> workingDays) {
    List<String> allDays = ["الأحد", "الاثنين", "الثلاثاء", "الأربعاء", "الخميس", "الجمعة", "السبت"];
    List<int> remainingDays = [];
    for (var i = 0; i <allDays.length; i++) {
      if (!workingDays.contains(allDays[i])) {
        if(i==0)
        {remainingDays.add(7);}
        else remainingDays.add(i);}}
    return remainingDays;
  }
}
// class ListMonthYear{
//   late List<MonthYear> monthYear;
//
//   ListMonthYear.FromJson(Map<String,dynamic> json){
//     monthYear=[];
//     if (json != null) {
//       monthYear = (json as List)
//           .map<MonthYear>((item) => MonthYear.fromJson(item))
//           .toList();
//     } else {
//       monthYear = [];
//     }
//   }
//
// }

class MonthYear{
  late String service_id;
  late String day_id;
  late String hour;
  late String date;
  late String total_count;
  MonthYear.fromJson(Map<String,dynamic> json){
    service_id=json['service_id'];
    day_id=json['day_id'];
    hour=json['hour'];
    date=json['date'];
    total_count=json['total_count'];
  }
}
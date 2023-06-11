import 'package:to_where/Controller/Constants/strings.dart';

class BannerCategoryMain{
  late List<BannerData> Data;
  late String message;
  late int status;
  BannerCategoryMain();
BannerCategoryMain.fromJson(Map<String,dynamic> json){
  message=json['message'];
  status=json['status'];
  Data = [];
  if (json["data"] != null) {
    Data = (json["data"] as List)
        .map((item) => BannerData.fromJson(item))
        .toList();
  } else {
    Data = [];
  }
  }
}

class BannerData{
  late int id;
  late String image;
  late String banner_name;
  late String number;
  BannerData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    image=baseUrl2Images+json['image'];
    banner_name=json['banner_name'];
    number=json['number'];
  }
}
import 'package:flutter/foundation.dart';
import 'package:to_where/Controller/Constants/strings.dart';

class CustomerService{
  late String message;
  late int status;
  late DataCustomerService data;
  CustomerService();
  CustomerService.fromJson(Map<String,dynamic> json){
    message=json['message'];
    status=json['status'];
    data=DataCustomerService.fromJson(json['data']);

  }
}
class DataCustomerService{
  late int current_page;
  late List<ServiceData> data;
  late String first_page_url;
  late int from;
  late int last_page;
  late String last_page_url;
  late List<Link> links;
  late String next_page_url;
  late String path;
  late int per_page;
  late String prev_page_url;
  late int to;
  late int total;
  DataCustomerService.fromJson(Map<String,dynamic> json){
    current_page=json['current_page'];
    data=[];
    if (json["data"] != null) {
      data = (json["data"] as List)
          .map((item) => ServiceData.fromJson(item))
          .toList();
    } else {
      data = [];
    }
    first_page_url=json['first_page_url'];
    from=json['from'];
    last_page=json['last_page'];
    last_page_url=json['last_page_url'];
    links=[];
    if (json["links"] != null) {
      links = (json["links"] as List)
          .map((item) => Link.fromJson(item))
          .toList();
    } else {
      links = [];
    }
    next_page_url=json['next_page_url']??"";
    path=json['path'];
    per_page=json['per_page'];
    prev_page_url=json['prev_page_url']??"";
    to=json['to'];
    total=json['total'];
  }

}
class Link{
  late String url;
  late String lable;
  late String active;
  Link.fromJson(Map<String,dynamic> json){
    url=json["url"]??'';
    lable=json["lable"]??'';
    active=json["active"]??'';
  }
}
class ServiceData{
  late int id;
  late SubCategory sub_category;
  late ServiceProvider service_provider;
  late List <Hour> working_hours;
  late String target_group;
  late String latitude;
  late String longtude;
  late String title_ar;
  late String address_en;
  late String description_ar;
  late String description_en;
  late String terms_and_conditions_ar;
  late String terms_and_conditions_en;
  late List<ImageSevice> images;
  late String min_reservation;
  late String max_reservation;
  late String capacity;
  late String price;
  late String accept;
  late String type;
  late List <int> ratings;
  late int average_rating;
  ServiceData.fromJson(Map<String,dynamic> json){
    id=json["id="];
    sub_category=json["sub_category"];
    service_provider=json["service_provider"];
    working_hours=json["working_hours"];
    target_group=json["target_group"];
    latitude=json["latitude"];
    longtude=json["longtude"];
    title_ar=json["title_ar"];
    address_en=json["address_en"];
    description_ar=json["description_ar"];
    description_en=json["description_en"];
    terms_and_conditions_ar=json["terms_and_conditions_ar"];
    terms_and_conditions_en=json["terms_and_conditions_en"];
    images=[];
    if (json["images"] != null) {
      images = (json["images"] as List)
          .map((item) => ImageSevice.fromJson(item))
          .toList();
    } else {
      images = [];
    }
    min_reservation=json["min_reservation"];
    max_reservation=json["max_reservation"];
    capacity=json["capacity"];
     price=json["price"];
    accept=json["accept"];
    type=json["type"];
    ratings=[];
    ratings=List<int>.from(json['ratings']);
     average_rating=json["average_rating"];
  }
}
class ImageSevice{
  late int id;
  late String service_id;
  late String image;
  ImageSevice.fromJson(Map<String,dynamic> json){
    id=json["id"];
    service_id=json["service_id"];
    image=baseUrl2Images+json["image"];
  }
}
class Hour{
  late int id;
  late String service_id;
  late String open_hour;
  late Day day;
  Hour.fromJson(Map<String,dynamic> json){
    id=json["id"];
    service_id=json["service_id"];
    open_hour=json["open_hour"];
    day=Day.fromJson(json["day"]);
  }
}
class Day{
  late int id;
  late String name_ar;
  late String name_en;
  Day.fromJson(Map<String,dynamic> json){
    id=json["id"];
    name_ar=json["name_ar"];
    name_en=json["name_en"];
  }
}
class SubCategory {
  late int id;
  late String title_ar;
  late String title_en;
  late String category_id;
  SubCategory.fromJson(Map<String,dynamic> json){
    id=json["id"];
    title_ar=json["title_ar"];
    title_en=json["title_en"];
    category_id=json["category_id"];
  }
}
class ServiceProvider{
  late int id;
  late String name;
  late String phone;
  late CategoryServiceProvider category;
  late String sub_category_id;
  late String accept;
  ServiceProvider.fromJson(Map<String,dynamic> json){
    id=json["id"];
    name=json["name"];
    phone=json["phone"];
    category=CategoryServiceProvider.fromJson(json["category"]);
    sub_category_id=json["sub_category_id"];
    accept=json["accept"];
  }
}
class CategoryServiceProvider{
  late int id;
  late String title_ar;
  late String title_en;
  CategoryServiceProvider.fromJson(Map<String,dynamic> json){
    id=json["id"];
    title_ar=json["title_ar"];
    title_en=json["title_en"];
  }
}

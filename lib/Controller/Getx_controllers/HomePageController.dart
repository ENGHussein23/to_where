import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_where/Controller/Constants/strings.dart';
import 'package:to_where/Model/banners_main_category_model.dart';
import 'package:http/http.dart' as http;


class HomePageController extends GetxController {
  var bannerData = BannerCategoryMain().obs;
  var categoryData = BannerCategoryMain().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchBannerData();
    super.onInit();
  }

  void fetchBannerData() async {
    isLoading(true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String access_token = prefs.getString('access_token') ?? '';
      var response_main = await http.get(Uri.parse(CustomerBannerMain), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $access_token'
      });
      var category_main = await http.get(Uri.parse(CustomerBannerCategory), headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $access_token'
          });
      if (response_main.statusCode == 200 && category_main.statusCode == 200) {
        BannerCategoryMain bannerMain = BannerCategoryMain.fromJson(json.decode(response_main.body));
        bannerData.value = bannerMain;
        BannerCategoryMain bannerCategory = BannerCategoryMain.fromJson(json.decode(category_main.body));
        categoryData.value = bannerCategory;
        print("image from category ${categoryData.value.Data[0].image}");
      }
    } finally {
      isLoading(false);
    }
  }
}


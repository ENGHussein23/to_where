import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/Controller/Constants/strings.dart';
import 'package:to_where/Controller/Getx_controllers/HomePageController.dart';
import 'package:to_where/View/Pages/classification_page.dart';
import 'package:to_where/View/Pages/classification_page_new.dart';
import 'package:to_where/View/Pages/my_location_page.dart';
import 'package:to_where/View/Widgets/LinearGradient.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
import 'package:to_where/View/Widgets/buttons.dart';
import 'package:to_where/View/Widgets/item_container.dart';
import 'package:to_where/View/Widgets/my_text_form_field.dart';

class HomePage extends StatelessWidget{
  final bannerController = Get.put(HomePageController());
  List Titels=['جمعات',"ترفيه","استرخاء واستجمام","مغامرة و استكشاف"];
  TextEditingController SearchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        // padding: EdgeInsets.only(top: 0,bottom: 0,left: 10,right: 10),
        decoration: LinarGradientBox(almost_light_blue,almost_green),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(padding: EdgeInsets.only(top: 0,bottom: 0,left: 10,right: 10),alignment: Alignment.topRight,
                child: NormalCustomText("على وين ؟",almost_dark_blue,20.0),),
              Obx(
                () {
                  if(bannerController.isLoading.isTrue){
                    return ItemContainer("Loading...", () { });
                  }
                  else{
                    return
                      Container(
                      height: 150,
                      child:  PageView.builder(
                          itemCount:bannerController.bannerData.value.Data.length,
                          itemBuilder: (_,i){
                            return GestureDetector(
                                child: Container(
                                  height: 220,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(bannerController.bannerData.value.Data[i].image),
                                        fit: BoxFit.cover, // make the image cover the entire area of the container
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                      color: i.isEven?const Color.fromARGB(100, 83, 109, 254):const Color.fromARGB(100, 0, 100, 136)
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child:     DotsIndicator(
                                      dotsCount: bannerController.bannerData.value.Data.length,
                                      position: i,
                                      decorator: DotsDecorator(
                                        color: Colors.white,
                                        activeColor: Colors.grey,
                                        size: const Size(8, 8),
                                        activeSize: const Size(12, 12),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: (){}
                            );
                          }),
                    );
                  }
                  return Container();
                },
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.only(top: 20,bottom: 0,left: 10,right: 10),
                child:Column(
                    children: [
                      Obx(() {
                        if(bannerController.isLoading.isTrue)
                          return ItemContainer("Loading",(){print("Hi");});
                        else {
                          return
                            Container(
                              height: 100,
                              child:  PageView.builder(
                                  itemCount:bannerController.categoryData.value.Data.length,
                                  itemBuilder: (_,i){
                                    return Stack(
                                      children: [
                                    ItemBannerContainer(bannerController.categoryData.value.Data[i].image,(){print("worked");}),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child:     DotsIndicator(
                                            dotsCount: bannerController.bannerData.value.Data.length,
                                            position: i,
                                            decorator: DotsDecorator(
                                              color: Colors.white,
                                              activeColor: Colors.grey,
                                              size: const Size(8, 8),
                                              activeSize: const Size(12, 12),
                                            ),
                                          ),
                                        ),
                                    ],
                                    );


                                  }),
                            );

                        }
                        return Container();
                      }),
                      const SizedBox(height: 20,),
                      MySearchField(SearchController,"ابحث عن..."),
                      const SizedBox(height: 20,),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Expanded(child: ItemContainerGrid(Titels[0],(){print(Titels[0]);

                          Get.to(ClassificationPageNew(),arguments: {
                            "classification":Titels[0].toString(),
                          });}),),
                          SizedBox(width: 20,),
                          Expanded(child: ItemContainerGrid(Titels[1],(){print(Titels[1]);}),)
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Expanded(child: ItemContainerGrid(Titels[2],(){print(Titels[2]);}),),
                          SizedBox(width: 20,),
                          Expanded(child: ItemContainerGrid(Titels[3],(){print(Titels[3]);}),),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      WideButton((){print("حدد الموقع على الخريطة");
                        Get.to(GetLocation());},"حدد الموقع على الخريطة"),
                      const SizedBox(height: 20,),
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/View/Pages/confirmation_page.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
import 'package:to_where/View/Widgets/item_container.dart';
import 'package:to_where/View/Widgets/small_widgets.dart';

class ReservationConfirmationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:Stack(
      children: [
        Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(color: Color.fromARGB(34, 107, 107, 107)),
        padding: EdgeInsets.only(top: 25,right: 15,left: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Center(child: NormalCustomTextWithWeight("مراجعة الحجز",Colors.black54,25.0,FontWeight.w800),),
              NormalCustomTextWithWeight("تفاصيل الحجز",Colors.black54,25.0,FontWeight.w800),
              space_V(10.0),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NormalCustomTextWithWeight("X5",Colors.black,20.0,FontWeight.w900),
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              NormalCustomTextWithWeight("150",Colors.black,20.0,FontWeight.w900),
                              NormalCustomTextWithWeight(" ريال",Colors.black54,20.0,FontWeight.w900),
                            ],)
                        ],),
                      space_V(10.0),
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          NormalCustomTextWithWeight("الخدمة : ",Colors.black54,18.0,FontWeight.w700),
                          NormalCustomTextWithWeight("اسم مزود الخدمة",almost_bright_green,18.0,FontWeight.w700),

                        ],
                      ),
                      NormalCustomTextWithWeight("يوم الزيارة 03-07-2022 ",Colors.black54,18.0,FontWeight.w700),
                      NormalCustomTextWithWeight("وقت الزيارة 8:00 pm",Colors.black54,18.0,FontWeight.w700),

                    ],
                  )
              ),
              space_V(15.0),
              NormalCustomTextWithWeight("طريقة الدفع",Colors.black54,25.0,FontWeight.w800),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                              color: almost_bright_green,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2
                              )
                          ),
                        ),
                        space_H(5.0),
                        NormalCustomTextWithWeight("Apple Pay",Colors.black,18.0,FontWeight.w700),
                      ],),
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row( textDirection: TextDirection.rtl,
                          children: [
                            Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 2
                                  )
                              ),
                            ),
                            space_H(5.0),
                            NormalCustomTextWithWeight("Visa",Colors.indigo,18.0,FontWeight.w800),
                            space_H(5.0),
                            NormalCustomTextWithWeight("xxxxxx1234",Colors.black54,16.0,FontWeight.w700),
                          ],),
                        ItemContainerInnerWidget(NormalCustomTextWithWeight("تغيير البطاقة",Colors.black54,18.0,FontWeight.w800),(){print("its worked perfect");}),
                      ],),
                  ],
                ),
              ),
              space_V(15.0),
              RichText(
                text: const TextSpan(
                  text: 'بتنفيذ الحجز فانك توافق على',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                  children: [
                    TextSpan(
                      text: 'الشروط و الاحكام للتطبيق',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),),
        Positioned(child:  Row(children: [
          Expanded(child:
          ItemContainerInnerWidget(Center(child: NormalCustomTextWithWeight("ادفع",Colors.black54,18.0,FontWeight.w800),),(){print("its worked perfect"); Get.to(ConfirmationPage());}),)
        ],),
          bottom: 40.0,
          right: 10.0,
        left: 10.0,)
      ],
      ),
    );
  }

}
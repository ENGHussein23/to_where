import 'package:flutter/material.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
import 'package:to_where/View/Widgets/small_widgets.dart';

class ConfirmationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.only(top: 25,right: 15,left: 15),
        decoration: const BoxDecoration(color: Color.fromARGB(34, 107, 107, 107)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: NormalCustomTextWithWeight("تم تأكيد الحجز",Colors.black,25.0,FontWeight.w800),),
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
                      space_V(20.0),
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          NormalCustomTextWithWeight("رقم الحجز : ",almost_bright_green,18.0,FontWeight.w700),
                          NormalCustomTextWithWeight("123456789",Colors.black,18.0,FontWeight.w700),

                        ],
                      ),
                      space_V(20.0),
                      Image(image: AssetImage("assets/images/QR.PNG"),fit: BoxFit.cover, width: 150,height: 150,)
                      
                    ],
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }

}
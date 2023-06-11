import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/View/Pages/main_screen.dart';
import 'package:to_where/View/Widgets/LinearGradient.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
import 'package:to_where/View/Widgets/my_text_form_field.dart';
import 'package:to_where/View/Widgets/buttons.dart';
import 'package:pinput/pinput.dart';
class VerificationPage extends StatelessWidget{
  TextEditingController VerificationTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
   return Scaffold(
     body: Container(
       height: screenHeight,
       width: screenWidth,
       decoration: LinarGradientBox(almost_light_blue,almost_green),
       padding: EdgeInsets.only(top: 0,right: 30,left: 30,bottom: 20),
       child:SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             SizedBox(height: 100),
             Center(
               child: Text("على وين",style: TextStyle(
                   fontSize: 70,
                   color: Colors.white,
                   fontWeight: FontWeight.w900
               ),),
             ),
             SizedBox(height: 40,),
             Container(
               alignment: Alignment.center,
               padding: EdgeInsets.only(left: 30,right: 30),
               child:Text("الرجاء ادخال رمز التحقق في الرسالة النصية للرقم المدخل XXXXXXXXXX",
                 textDirection: TextDirection.rtl,
                 textAlign: TextAlign.center,
                 style: TextStyle( color: Colors.white,fontSize: 18,fontWeight: FontWeight.w800),
               ),
             ),
             SizedBox(height: 10,),

            Center(
              child:  Container(
                padding: EdgeInsets.all(10),
                height: 50,
                width: 130,

                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Pinput(
                length: 4,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                controller:VerificationTextController ,
                defaultPinTheme: PinTheme(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black))
                  )
                ),
              ),),
            ),
             SizedBox(height: 50,),
             Center(
               child: WhiteButton(()
               {
                 Get.to(MainScreen());
               }, "تحقق"),
             ),
             const SizedBox(height: 50,),
            Center(child:  NormalWhiteTextWithUnderLine("أرسل رمز التحقق من جديد"),),
             Center(child: NormalWhiteText("2:00"),),
           ],
         ),
       )
     ),
   );
  }
}
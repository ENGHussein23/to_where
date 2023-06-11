import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/Controller/Getx_controllers/AuthController.dart';
import 'package:to_where/View/Pages/main_screen.dart';
import 'package:to_where/View/Pages/register_page.dart';
import 'package:to_where/View/Widgets/LinearGradient.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
import 'package:to_where/View/Widgets/buttons.dart';
import 'package:to_where/View/Widgets/my_text_form_field.dart';
import 'package:to_where/View/Widgets/small_widgets.dart';

class LoginPage extends StatelessWidget{
  TextEditingController MobileController =TextEditingController();
  TextEditingController PasswordController =TextEditingController();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.only(top: 60,bottom: 0,left: 25,right: 25),
        decoration: LinarGradientBox(almost_light_blue,almost_green),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Center(
                child: Text("على وين",style: TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontWeight: FontWeight.w900
                ),),
              ),
              space_V(20.0),
              // NormalWhiteText("تسجيل الدخول :"),
              space_V(30.0),
              Obx((){
                if(authController.errorMessage.value=='')
                  return MyTextFormField(MobileController,"رقم الهاتف");
                else if (authController.errorMessage.value=='Unauthorized')
                  return MyTextFormField(MobileController,"رقم الهاتف",errorText:"الرقم غير موجود أو كلمة السر خاطئة" ,);
                else if (authController.errorMessage.value=='The phone field is required. (and 1 more error)')
                  return MyTextFormField(MobileController,"رقم الهاتف",errorText:"حقل الهاتف يجب تعبئته",);
                else if (authController.errorMessage.value=='The phone field is required.')
                  return MyTextFormField(MobileController,"رقم الهاتف",errorText:"حقل الهاتف يجب تعبئته",);
                else
                  return MyTextFormField(MobileController,"رقم الهاتف");
              }),
              SizedBox(height: 15,),
              Obx((){
                if(authController.errorMessage.value=='')
                  return MyPassFormField(PasswordController,"كلمة السر");
                else if (authController.errorMessage.value=='Unauthorized')
                  return MyPassFormField(PasswordController,"كلمة السر",errorText:"الرقم غير موجود أو كلمة السر خاطئة",);
                else if (authController.errorMessage.value=='The password field is required.')
                  return  MyPassFormField(PasswordController,"كلمة السر",errorText:"يجب تعبئة حقل كلمة السر" ,);
                else if (authController.errorMessage.value=='The phone field is required. (and 1 more error)')
                  return MyPassFormField(PasswordController,"كلمة السر",errorText:"يجب تعبئة حقل كلمة السر",);
                else
                  return MyPassFormField(PasswordController,"كلمة السر");
              }),

              SizedBox(height: 40,),
              Center(
                child: Obx((){

                  if(authController.isLoading.value==false){
                    return WhiteButton(() async {
                      // final authController = Get.find<AuthController>();
                      await authController.login(
                        MobileController.text,
                        PasswordController.text,
                      );
                  }, "تسجيل الدخول");
                }
                  else {
                    return  CircularProgressIndicator();
    }}
                  ),
              ),
              SizedBox(height: 30,),
              TextWtihUnderLineButton("انشاء حساب جديد؟",(){print("its good!"); Get.to(RegisterPage());}),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
  
}
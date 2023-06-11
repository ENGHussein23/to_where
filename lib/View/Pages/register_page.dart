import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/Controller/Getx_controllers/AuthController.dart';
import 'package:to_where/Controller/Getx_controllers/RegisterController.dart';
import 'package:to_where/View/Pages/login_page.dart';
import 'package:to_where/View/Pages/verification_page.dart';
import 'package:to_where/View/Widgets/LinearGradient.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
import 'package:to_where/View/Widgets/my_text_form_field.dart';
import '../Widgets/buttons.dart';
class RegisterPage extends StatefulWidget{
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authController = Get.find<RegisterController>();
  TextEditingController NumberController=TextEditingController();
  TextEditingController NameController=TextEditingController();
  TextEditingController PasswordController=TextEditingController();
  TextEditingController ConfPasswordController=TextEditingController();
  Country _selectedCountry = Country("KSA","KSA","+966","+966");
  void _showCountryPicker() async{
    final country = await showCountryPickerDialog(context);
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
   return Scaffold(

     body: Container(
       padding: const EdgeInsets.only(top: 0,bottom: 0,left: 10,right: 10),
       decoration: LinarGradientBox(almost_light_blue,almost_green),
       height: screenHeight,
       width: screenWidth,
       child:SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             const SizedBox(height:70,),
             const Center(
               child: Text("على وين",style: TextStyle(
                   fontSize: 70,
                   color: Colors.white,
                   fontWeight: FontWeight.w900
               ),),
             ),
             const SizedBox(height: 40,),

             Container(
               alignment: Alignment.center,
               padding: EdgeInsets.only(left: 30,right: 30),
               child:const Text("++++ يساعدك على البحث و حجز أفضل الأماكن لل++++",
                 textDirection: TextDirection.rtl,
                 textAlign: TextAlign.center,
                 style: TextStyle( color: Colors.white,fontSize: 18,fontWeight: FontWeight.w800),
               ),
             ),
             Container(
               margin: const EdgeInsets.all(30),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                 NormalWhiteText("ادخل رقم الجوال لانشاء حساب او لتسجيل الدخول:"),



                 Obx(()=>
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                       Container(
                         height: (authController.errorMessage.value=='a'||authController.errorMessage.value=='b'||authController.errorMessage.value=='d'||authController.errorMessage.value=='f')?
                         (NumberController.text=='')?41.5:41.5
                             :40,
                         // height: 42,
                         padding: const EdgeInsets.only(left: 20),
                         decoration: BoxDecoration(
                           color: almost_white,
                           border: (authController.errorMessage.value=='a'||authController.errorMessage.value=='b'||authController.errorMessage.value=='d'||authController.errorMessage.value=='f')?
                           Border.all(color: Colors.red, width: 1.0):
                           Border.all(color: almost_white, width: 0.0),
                           borderRadius: const BorderRadius.all(Radius.circular(15.0)),),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,

                           children: [
                             GestureDetector(
                               child: Row(children: [

                                 Text(_selectedCountry.name,style: TextStyle(color: Colors.black54,fontSize: 15,),),
                                 Icon(Icons.arrow_drop_down_sharp,color: Colors.black54,size: 40,),
                                 Text(_selectedCountry.callingCode,style: TextStyle(color: Colors.black54,fontSize: 15,),),
                               ],),
                             ),
                             Expanded(flex: 6,child: TextFormField(
                               controller: NumberController,
                               textAlignVertical: TextAlignVertical.bottom,

                               style: const TextStyle(color: Colors.black54,fontSize: 15,),
                               textDirection: TextDirection.ltr,
                               decoration: InputDecoration(
                                   labelStyle: const TextStyle(color: Colors.black54,fontSize: 15,),
                                   hintStyle: const TextStyle(color: Colors.black54),
                                   enabledBorder:outlineInputBorderRad15,
                                   focusedBorder:outlineInputBorderRad15,
                                   border: outlineInputBorderRad15,
                                   errorBorder: outlineInputBorderRad15,
                                   focusedErrorBorder: outlineInputBorderRad15,
                                   hintText: "5X XXX XXXX",
                                   fillColor: almost_white,
                                   // errorText: (authController.errorMessage.value=='a'||authController.errorMessage.value=='b'||authController.errorMessage.value=='d'||authController.errorMessage.value=='f')?
                                   // (NumberController.text=='')?"يرجى تعبئة حق الرقم":"هذا الرقم مستخدم مسبقا"
                                   //     :"",
                                   filled: true,
                                   contentPadding: const EdgeInsets.only(left: 0,bottom:14)),

                             ))
                           ],),
                       ),

                      Padding(padding: EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          (authController.errorMessage.value=='a'||authController.errorMessage.value=='b'||authController.errorMessage.value=='d'||authController.errorMessage.value=='f')?
                          (NumberController.text=='')?
                          Text("يرجى تعبئة حقل الرقم",style: TextStyle(color: Colors.red,fontSize: 14),):
                          (authController.errorMessage.value=='f')?
                          Text("هذا الرقم مستخدم مسبقا",style: TextStyle(color: Colors.red,fontSize: 14),):
                          Text("يرجى التأكد من صحة حقل الرقم",style: TextStyle(color: Colors.red,fontSize: 14),)
                              :Container()
                        ],
                      ),)
                     ],)),
                   const SizedBox(height: 12,),
                   Obx(
                       (){
                       //   MyTextFormField(NameController,"الإسم"),
                         if(authController.errorMessage.value=='')
                           return MyTextFormField(NameController,"الإسم");
                         else if(authController.errorMessage.value=='a'||authController.errorMessage.value=='b'||authController.errorMessage.value=='c'||authController.errorMessage.value=='e')
                           return MyTextFormField(NameController,"الإسم",errorText: "يرجى التأكد من تعبئة حقل الإسم بشكل صحيح",);
                         else
                           return MyTextFormField(NameController,"الإسم");

                       }
                   ),
                  const SizedBox(height: 12,),
                 Obx(() {
                   //MyPassFormField(PasswordController,"كلمة السر"),
                   if(authController.errorMessage.value=='')
                     return MyPassFormField(PasswordController,"كلمة السر");
                   else if(authController.errorMessage.value=="Passwords do not match"){
                     return MyPassFormField(PasswordController,"كلمة السر",errorText: "كلمة السر و تأكيد كلمة السر غير متطابقين");
                   }
                   else if(authController.errorMessage.value=='a'||authController.errorMessage.value=='c'||authController.errorMessage.value=='d'||authController.errorMessage.value=='g'){
                     return MyPassFormField(PasswordController,"كلمة السر",errorText: "يرجى التحقق من مطابقة كلمة السر للشروط الموضوعة");
                   }
                   else
                    return MyPassFormField(PasswordController,"كلمة السر");

                 }),
                 const SizedBox(height:12,),
                 Obx(() {
                   //MyPassFormField(ConfPasswordController, "تأكيد كلمة السر")
                   if(authController.errorMessage.value=='')
                     return MyPassFormField(ConfPasswordController, "تأكيد كلمة السر");
                   else if(authController.errorMessage.value=="Passwords do not match"){
                     return MyPassFormField(ConfPasswordController, "تأكيد كلمة السر",errorText: "كلمة السر و تأكيد كلمة السر غير متطابقين");
                   }
                   else if(authController.errorMessage.value=='a'||authController.errorMessage.value=='c'||authController.errorMessage.value=='d'||authController.errorMessage.value=='g'){
                     return MyPassFormField(ConfPasswordController, "تأكيد كلمة السر",errorText: "يرجى التحقق من مطابقة كلمة السر للشروط الموضوعة");
                   }
                   else
                     return MyPassFormField(ConfPasswordController, "تأكيد كلمة السر");
                 }),



                 SizedBox(height: 18,),
                 Center(
                   child: Obx((){
                     if(authController.isLoading.value==false) {
                       return WhiteButton(()
                       async {
                         await authController.register(NumberController.text, NameController.text,PasswordController.text, ConfPasswordController.text);
                         // Get.to(VerificationPage());
                       }, "تأكيد");
                     } else {
                       return CircularProgressIndicator();
                     }
                   }),
                 ),
               ],),
             ),
             const SizedBox(height: 10,),
             NormalWhiteText("سنقوم بارسال رسالة نصية الى الرقم المدخل تحتوي على كود للمتابعة"),
             const SizedBox(height: 10,),
             TextWtihUnderLineButton("هل لديك حساب مسبقا؟",(){print("its good!"); Get.to(()=>LoginPage());}),
             const SizedBox(height: 50,),
           ],
         ),
       )
     ),
   );
  }
}
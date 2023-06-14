import 'package:flutter/material.dart';
import 'package:to_where/View/Widgets/buttons.dart';
import 'package:to_where/View/Widgets/small_widgets.dart';

import '../../Controller/Constants/my_colors.dart';
import 'MyTexts.dart';

class ItemContainer extends StatelessWidget{
  String lable;
  final VoidCallback onPressed;
  ItemContainer(this.lable,this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 100,
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [
              almost_green,
              almost_yellow,
            ],
          ),
        ),
        child: Center(
          child: NormalCustomText(lable, almost_dark_blue, 25.0),
        ),
      ),
       onTap: onPressed,
    );
  }

}

class ItemBannerContainer extends StatelessWidget{
  String Image;
  final VoidCallback onPressed;
  ItemBannerContainer(this.Image,this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 100,
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(Image),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [
              almost_green,
              almost_yellow,
            ],
          ),
        ),
        // child: Center(
        //   child: NormalCustomText(lable, almost_dark_blue, 25.0),
        // ),
      ),
    );
  }

}

class ItemContainerRTL extends StatelessWidget{
  String lable;
  final VoidCallback onPressed;
  ItemContainerRTL(this.lable,this.onPressed);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(right: 10),
        width: screenWidth-30,
        height: 100,
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [
              almost_green,
              almost_yellow,
            ],
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NormalCustomText(lable, almost_dark_blue, 25.0)
            ],
          ),
        ),
      ),
    );
  }

}

class ItemContainerGrid extends StatelessWidget{
  String lable;
  final VoidCallback onPressed;
  ItemContainerGrid(this.lable,this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // alignment: Alignment.center,
        height: 100,
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              almost_yellow,
              almost_green,
            ],
          ),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(lable,textDirection: TextDirection.rtl,style: TextStyle( color: almost_dark_blue,fontSize: 22,fontWeight: FontWeight.w900),),
          ],
        )
      ),
    );
  }

}

class ItemContainerGridButton extends StatelessWidget{
  String lable;
  double h;
  double w;
  final VoidCallback onPressed;


  ItemContainerGridButton(this.lable, this.h, this.w, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // alignment: Alignment.center,
          height: h,
          width: w,
          decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                almost_yellow,
                almost_green,
              ],
            ),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(lable,textDirection: TextDirection.rtl,style: TextStyle( color: almost_dark_blue,fontSize: 22,fontWeight: FontWeight.w900),),
            ],
          )
      ),
    );
  }

}

class ItemContainerInnerWidget extends StatelessWidget{
  var innerWidget;
  final VoidCallback onPressed;
  ItemContainerInnerWidget(this.innerWidget, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              almost_yellow,
              almost_green,
            ],
          ),
        ),
        child: innerWidget,
      ),
    );
  }

}

class TabButton extends StatelessWidget{
  bool isChosen;
  String Title;
  final VoidCallback onPressed;
  TabButton(this.Title,this.isChosen, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return    Expanded(child: GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: isChosen
              ? LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [
              almost_yellow,
              almost_green,
            ],
          )
              : LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromARGB(100, 224, 224, 224),
              Color.fromARGB(100, 224, 224, 224),
            ],
          ),
        ),
        child: Center(
          child: Text(Title),
        ),
      ),
    ))  ;
  }
}

class ItemFromClass extends StatelessWidget{
String title;
String sub_title;
String image;
String distance;
String rate;
final VoidCallback onPressed;


ItemFromClass(this.title, this.sub_title, this.image, this.distance,
      this.rate, this.onPressed);

  @override
  Widget build(BuildContext context) {
   return  GestureDetector(
     onTap: onPressed,
     child: Container(
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(12),
           border: Border.all(
               color:  Color.fromARGB(250, 224, 224, 224),
               width: 1
           )
       ),
       padding: EdgeInsets.all(15),
       height: 100,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Row(
             children: [
               ClipRRect(
                 borderRadius: BorderRadius.circular(12),
                 child: Image(
                   image: NetworkImage(image),
                   height: 70,
                   width: 70,
                   fit: BoxFit.cover,
                 ),
               ),
               const SizedBox(width: 10,),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(title,style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w700),),
                   Text(sub_title,style: TextStyle(color: Colors.black45,fontSize: 14),),
                 ],
               ),],
           ),

           Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [

               RatingAndDistanceButton(distance,Icons.location_pin,Colors.black87,(){print("hi 1");},false),
               SizedBox(height: 2,),
               RatingAndDistanceButton(rate,Icons.star,Colors.amberAccent,(){print("hi 2");},false),
             ],
           ),

         ],
       ),
     ),
   );
  }

}

class SelectHour extends StatelessWidget{
  int type;
  String Hour;


  SelectHour( this.Hour,this.type);

  WhatColor(a){
    if(a==2)
      return Color.fromARGB(127, 246, 8, 8);
    else if (a==1)
      return Color.fromARGB(197, 8, 246, 103);
    return Colors.black12;
  }
  @override
  Widget build(BuildContext context) {
  return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(2),
      // height: 30,
      width: 60,
      color: WhatColor(type),
    child:  GestureDetector(

      child: FittedBox(child: Text(Hour)),
    ),
  );
  }

}


color_squer_hour(a,b){
  WhatColor(a){
    if(a==1)
      return Color.fromARGB(147, 246, 8, 8);
    else if (a==2)
      return Color.fromARGB(197, 8, 246, 103);
    return Colors.black12;
  }
  return
    GestureDetector(child: Container(
        margin: EdgeInsets.all(3),
        height: 30,
        width: 80,
        color: WhatColor(b),
        child: Center(child: FittedBox(child: Text(a,style: TextStyle(color: Colors.black54,),),))),
    onTap: (){print(a);},);
}
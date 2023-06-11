import 'package:flutter/material.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/View/Widgets/MyTexts.dart';
class WhiteButton extends StatelessWidget{
  final VoidCallback onPressed;
  final String label;


  WhiteButton(this.onPressed, this.label);

  @override
  Widget build(BuildContext context) {
  return ElevatedButton(onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      child: Text(label,style: TextStyle(color: almost_light_blue,fontWeight: FontWeight.w800,fontSize: 22),));
  }

}

class WideButton extends StatelessWidget{
  final VoidCallback onPressed;
  final String label;


  WideButton(this.onPressed, this.label);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(Size(300, 40)),
          backgroundColor: MaterialStateProperty.all<Color>(almost_light_green_on_blue),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        child: Text(label,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w800,fontSize: 20),));
  }

}

class RatingAndDistanceButton extends StatelessWidget{
  String Label;
  var icon;
  final VoidCallback onPressed;
  var icon_color;
  bool expanded;

  RatingAndDistanceButton(
      this.Label,
      this.icon,
      this.icon_color,
      this.onPressed,
    this.expanded,

  );

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child:Container(
        padding: const EdgeInsets.only(top: 1,bottom: 1,left: 2,right: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(250, 240, 240, 240),
            border: Border.all(
                color: const Color.fromARGB(0, 240, 240, 240),
                width: 0
            )
        ),

          child:  Row(
            children: [
              expanded?Text("مشاهدة الموقع",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700,color:almost_bright_green),):Container(),
              Icon(icon,color: icon_color,),
               Text(Label,style: const TextStyle(color: Colors.black87,fontSize: 12),),

            ],
          ),
        ),
    );
  }
}

class TextWtihUnderLineButton extends StatelessWidget{
  String lable;
  final VoidCallback onPressed;


  TextWtihUnderLineButton(this.lable, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: NormalWhiteTextWithUnderLine(lable),
      onTap:  onPressed,
    ) ;
  }

}
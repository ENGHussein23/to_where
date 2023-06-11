import 'package:flutter/material.dart';

NormalWhiteText(a){
  return Text(a.toString(),textDirection: TextDirection.rtl,style: TextStyle( color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800),);
}

NormalWhiteTextWithUnderLine(a){
  return Text(a.toString(),textDirection: TextDirection.rtl,style: TextStyle( color: Colors.white,fontSize: 18,decoration: TextDecoration.underline),);
}

NormalCustomText(a,b,c){
  return Text(a.toString(),textDirection: TextDirection.rtl,style: TextStyle( color: b,fontSize: c,fontWeight: FontWeight.w900),);
}

NormalCustomTextWithWeight(a,b,c,d){
  return Text(a.toString(),textDirection: TextDirection.rtl,style: TextStyle( color: b,fontSize: c,fontWeight: d),);
}
import 'package:flutter/material.dart';

space_V(a){
  return SizedBox(height: a,);
}

space_H(a){
  return SizedBox(width: a,);
}

color_squer(a,b){
  return Container(
    height: 30,
    width: 40,
    color: b,
    child: Center(child: Text(a,style: TextStyle(color: Colors.black54),),));
}
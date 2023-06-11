import 'package:flutter/material.dart';

LinarGradientBox(a,b){
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,

      colors: [
        a,
        b,
      ],
    ),
  );
}
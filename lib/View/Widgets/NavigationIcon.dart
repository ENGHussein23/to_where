import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget{
  var icon;

  CircleIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1.0,
          ),
        ),
        child: icon,
      );
  }


}
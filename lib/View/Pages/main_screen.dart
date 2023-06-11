import 'package:flutter/material.dart';
import 'package:to_where/View/Pages/Homepage.dart';
import 'package:to_where/View/Pages/classification_page.dart';
import 'package:to_where/View/Widgets/NavigationIcon.dart';
class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    bottomNavigationBar: Directionality(
      textDirection: TextDirection.rtl,
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: CircleIcon(Icon(Icons.home)), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: CircleIcon(Icon(Icons.bookmarks_outlined)), label: 'حجوزاتي'),
          BottomNavigationBarItem(icon: CircleIcon(Icon(Icons.percent)), label: 'العروض'),
          BottomNavigationBarItem(icon: CircleIcon(Icon(Icons.person_outline_outlined)), label: 'حسابي'),
        ],
        showUnselectedLabels: true,
        elevation: 15,
        selectedItemColor: Colors.black54,
        selectedIconTheme: IconThemeData(color: Colors.lightBlue),
        selectedLabelStyle: TextStyle(color:Colors.black54,fontWeight: FontWeight.w700),
        unselectedLabelStyle: TextStyle(color:Colors.black12,fontWeight: FontWeight.w700),
        selectedFontSize: 15,
        unselectedFontSize: 10,
        unselectedItemColor: Colors.grey,
      ),
    ),
    body: HomePage(),
  );
  }


}
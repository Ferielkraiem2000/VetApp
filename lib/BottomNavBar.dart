import 'package:finalprojet/searchvetScreen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'Menu.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 70.0,
      items: const <Widget>[
        Icon(
          Icons.home,
          size: 35,
          color: Colors.black,
        ),

        Icon(
          Icons.wechat,
          size: 35,
          color: Colors.black,
        ),
        Icon(
          Icons.location_on,
          size: 35,
          color: Colors.black,
        ),

      ],
      color:  Color(0xFFF7924A),
      buttonBackgroundColor:Color(0xFFF7924A),

      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        if(index==0){Navigator.pushReplacement(context,MaterialPageRoute (
            builder: (BuildContext context) => Menu(items: [],name: '',email:'',items_adop: [],) ));}
        if(index==1){Navigator.pushReplacement(context,MaterialPageRoute (
            builder: (BuildContext context) => Menu(items: [],name: '',email:'',items_adop: [],) ));}
        if(index==2){Navigator.pushReplacement(context,MaterialPageRoute (
            builder: (BuildContext context) => SearchVet() ));}
      },
      letIndexChange: (index) => true,
    );
  }
}

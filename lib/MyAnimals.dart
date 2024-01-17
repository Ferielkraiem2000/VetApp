import 'package:finalprojet/vaccin.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAnimals extends StatefulWidget {
  List< String> item;
  MyAnimals({super.key, required this.item});

  @override
  State<MyAnimals> createState() => _MyAnimalsState();
}

class _MyAnimalsState extends State<MyAnimals> {


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.item.length,
        itemBuilder: (BuildContext ctxt, int index) {
          // ignore: prefer_const_constructors
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute (
                    builder: (BuildContext context) => VaccineTableScreen(url:widget.item[index],)));
              },

              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.item[index]!) ,
                radius: 30.0, // rayon du cercle
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:finalprojet/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class circularMenu extends StatefulWidget {
  const circularMenu({super.key});

  @override
  _circularMenuState createState() => _circularMenuState();
}

class _circularMenuState extends State<circularMenu> {
  late double _rating;
  @override
  Widget build(BuildContext context) {
    return CircularMenu(
      toggleButtonSize: 30,
      alignment: Alignment.topLeft,
      radius: 87,
      toggleButtonColor: Color.fromARGB(255, 0, 0, 0),
      items: [
        CircularMenuItem(
            badgeLabel: 'déconnexion',
            badgeRadius: 25,
            badgeTopOffet: 10,
            badgeLeftOffet: 45,
            enableBadge: true,
            badgeColor: Colors.white.withOpacity(0),
            badgeTextStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            margin: 0,
            iconSize: 25,
            icon: Icons.logout,
            color: Colors.orange,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute (
                  builder: (BuildContext context) => LoginScreen()));
            }),
        CircularMenuItem(
            badgeLabel: 'demo',
            badgeRadius: 40,
            badgeTopOffet: 0,
            badgeLeftOffet: 42,
            enableBadge: true,
            badgeColor: Colors.white.withOpacity(0),
            badgeTextStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
            margin: 0,
            iconSize: 25,
            icon: Icons.archive,
            color: Color.fromARGB(176, 94, 226, 215),
            onTap: () {}),
        CircularMenuItem(
            badgeLabel: 'avis',
            padding: 11,
            badgeRadius: 41,
            badgeTopOffet: -5,
            badgeLeftOffet: 18,
            enableBadge: true,
            badgeColor: Colors.white.withOpacity(0),
            badgeTextStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
            margin: 0,
            iconSize: 22,
            icon: Icons.star,
            color: Color.fromARGB(175, 222, 112, 242),
            onTap: () {

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(actions: [
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        unratedColor: Colors.amber.withAlpha(50),
                        itemCount: 5,
                        itemSize: 47.0,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                           Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                        updateOnDrag: true,
                      ),
                    ]);
                  },
                );
              },
            )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'videosVideoPlayer.dart';
import 'package:swipe/swipe.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  int i = 0;
  var cards = [
    const MyVideoPlayer(url: 'assets/videos/video1.mp4'),
    Container(
      child: MyVideoPlayer(url: 'assets/videos/video2.mp4'),
    ),
    MyVideoPlayer(url: 'assets/videos/video3.mp4')
  ];
  void nextVideo() {
    i == 2
        ? setState(() {
            i = 0;
          })
        : setState(() {
            i++;
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swipe(

        onSwipeLeft: nextVideo,
        onSwipeRight: nextVideo,
        child: Container(
          color: Colors.teal,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: cards[i],
        ),
      ),
    );
  }
}

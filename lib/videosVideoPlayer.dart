import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({super.key, required this.url});
  final String url;
  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          duration = _controller.value.duration.inSeconds.toDouble();
        });
        _controller.pause();
        setState(() {
          isPlaying = false;
        });
      });
  }

  bool isPlaying = false;
  double position = 0;
  double duration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 100/50,
                child: VideoPlayer(_controller),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  IconButton(

                      iconSize: 50,
                      onPressed: () {
                        if (isPlaying) {
                          _controller.pause();
                          setState(() {
                            isPlaying = false;
                          });
                        } else {
                          _controller.play();
                          setState(() {
                            isPlaying = true;
                          });
                        }
                      },
                      icon: FloatingActionButton(
                          backgroundColor:Colors.transparent,

                        onPressed: () {
                          if (isPlaying) {
                            _controller.pause();
                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            _controller.play();
                            setState(() {
                              isPlaying = true;
                            });
                          }
                        },
                        child: Icon(
                          color:Colors.black,
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 40,
                        ),
                      )),
                  Expanded(
                    child: Slider(
                      activeColor:Colors.orange,
                      inactiveColor: Colors.grey,
                      value: position,
                      min: 0,
                      max: duration,
                      onChanged: (value) {
                        setState(() {
                          position = value;
                        });
                        _controller.seekTo(Duration(seconds: value.toInt()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

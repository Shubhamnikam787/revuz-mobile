import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';



class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://rewardz-app.herokuapp.com/upload/video-1597400363498-image_picker2963289209076122836.mp4')
      ..initialize().then((_) {
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Video Player",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
        body: Center(
          child: _controller.value.initialized 
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : CircularProgressIndicator(),
        ),
        
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
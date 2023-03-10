// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


/// Stateful widget to fetch and then display video content.
class VideoMediaPlayer extends StatefulWidget {
  final String videoUrl;
  final String videoViews;
  const VideoMediaPlayer({
    Key? key,
    required this.videoUrl,
    required this.videoViews,
  }) : super(key: key);

  @override
  _VideoMediaPlayerState createState() => _VideoMediaPlayerState();
}

class _VideoMediaPlayerState extends State<VideoMediaPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    print(widget.videoUrl);
    _controller = VideoPlayerController.network(
      widget.videoUrl.toString(),
    )..initialize().then(
          (_) {
        setState(() {});
      },
    );
  }

  void initVideo() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50)

                  ),
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 48,
                    color: Colors.white,

                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Row(
            children: [
              Text(
                'Views',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              Icon(
                Icons.playlist_add,
                color: Colors.white,
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

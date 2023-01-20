import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';

class YoutubeVideo extends StatefulWidget {
  String youtubeUrl;

  YoutubeVideo(this.youtubeUrl);

  @override
  _YoutubeVideoState createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  bool _isPlayerReady = false;
  late String videoId;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    onEnded:
    (data) {};
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {}
    setState(() {
      _playerState = _controller.value.playerState;
      _videoMetaData = _controller.metadata;
      var testduration = _controller.value.metaData.duration.inSeconds;
      var currentpostion = _controller.value.position.inSeconds;
      print('duration is $testduration');
      print('Current Position is $currentpostion');
      if (testduration == currentpostion) {
        setState(() {
          print("Video Completed");
        });
      } else {
        print("Video not Completed");
      }
    });
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.blue,
      child: VisibilityDetector(
        key: const Key("unique key"),
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 0) {
            _controller.pause();
          } else {
            _controller.value.isPlaying
                ? _controller.play()
                : _controller.pause();
          }
        },
        child: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            topActions: <Widget>[
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  _controller.metadata.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
            onReady: () {
              _controller.addListener(listener);
            },
            onEnded: (data) {
              //      _controller
              //     .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
              // _showSnackBar('Next Video Started!');
            },
          ),
          builder: (context, player) => Scaffold(
            key: _scaffoldKey,
            body: ListView(
              children: [
                player,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({Key? key}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerValue _playerTool;
  late VideoPlayerController _playerCtrl;

  @override
  void initState() {
    super.initState();

    //网络连接
     _playerCtrl = VideoPlayerController.network("https://www.bilibili.com/video/BV18D4y167Av/");

    //初始化
    _playerCtrl
        .initialize()
        .whenComplete(() => setState(() {}));

    _playerTool = _playerCtrl.value;

    if(_playerTool.isInitialized) {
      if(_playerTool.isPlaying) {
        _playerCtrl.pause();
      } else {
        _playerCtrl.play();
      }
      setState(() {});
    } else {
      _playerCtrl.initialize().then((value) {
        _playerCtrl.play();
        setState(() { });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _playerCtrl.value.aspectRatio,
      child: VideoPlayer(_playerCtrl),
    );
  }
}

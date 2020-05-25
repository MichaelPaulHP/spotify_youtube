import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class YouTubeVideoPlayer extends StatelessWidget {
  final String _videoId;
  final  YoutubePlayerController _controller;
  YouTubeVideoPlayer({String videoId})
      : _videoId = videoId,_controller=getController(videoId);




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _buildYoutubePlayer();

  }
  Widget _buildYoutubePlayer(){
    return YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false,

        onReady: (){
          print("ON READY");

        },
        onEnded: (YoutubeMetaData metaData){
          print("ON ENDED");
        },
      );
  }
  static YoutubePlayerController getController(String videoId){
    YoutubePlayerController controller=YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
    ),
    );
    return controller;


  }
}

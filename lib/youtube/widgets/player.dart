import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_event.dart';
import 'package:loginfirebaseapp/player/bloc/player_state.dart' as MyPlayerSate;
import 'package:lottie/lottie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class YouTubeVideoPlayer extends StatefulWidget {
  @override
  _YouTubeVideoPlayerFulState createState() => _YouTubeVideoPlayerFulState();
}

class _YouTubeVideoPlayerFulState extends State<YouTubeVideoPlayer> {


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  bool _hasVideo =false;


  void setHasVideo(bool hasVideo){
    setState(() {
      _hasVideo=hasVideo;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(_hasVideo){
      return _buildWithListener(_buildBody());
    }
    else{
      return _buildWithListener(_buildImageDefault());
    }
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
    super.dispose();
  }



  Widget _buildWithListener(Widget child){
    return BlocListener<PlayerBloc, MyPlayerSate.PlayerState>(
      listener: (BuildContext context,MyPlayerSate.PlayerState state) {
        if(state is MyPlayerSate.PlayerVideoStartLoad){
          onPlayerVideoStartLoad(state.video.id);
        }
        if(state is MyPlayerSate.PlayerVideoPaused ){
          _controller.pause();
        }
        if(state is MyPlayerSate.PlayerVideoPlaying){
          _controller.play();
        }
      },
      child: child,
    );
  }

  void onPlayerVideoStartLoad(String videoId){
    print("LOAD A NEW VIDEOS $videoId");
    if(_hasVideo){
      _controller.load(videoId);
    }else{
      _initStates(videoId);
      setHasVideo(true);
    }

  }

  Widget _buildBody(){
    return _buildYoutubePlayer();
  }

  Widget _buildYoutubePlayer(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        YoutubePlayer(

          controller: _controller,
          showVideoProgressIndicator: false,
          onReady: () {
            _isPlayerReady = true;
            BlocProvider.of<PlayerBloc>(context).add(PlayerVideoPlay());
          },
          onEnded: (data) {
            BlocProvider.of<PlayerBloc>(context).add(PlayerVideoEnded());
          },
        ),
        Text(
         " ${ _controller.metadata.title} ",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
  Widget _buildImageDefault(){
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              'assets/lottie/video-icon.json',
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
            Text("please select a video ☹")
          ],
        ),
      ),
    );
  }
  void _initStates(String videoId){
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,

      ),
    )
      ..addListener(listener);
  }
  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {

      setState(() {
      });
    }

  }
}

class YouTubeVideoPlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      child: BlocBuilder<PlayerBloc, MyPlayerSate.PlayerState>(
        condition: (previousState,state){
          if(state is MyPlayerSate.PlayerVideoPaused ||state is MyPlayerSate.PlayerVideoPlaying){
            return true;
          }
          return false;
        },
        builder: (BuildContext context,MyPlayerSate.PlayerState state) {
          if(state is MyPlayerSate.PlayerVideoPaused ){
            return IconButton(
              icon: Icon(
                Icons.play_arrow,
                size:40 ,
              ),
              onPressed: ()=>playVideo(context)
            );
          }
          if(state is MyPlayerSate.PlayerVideoPlaying){
            return IconButton(
                icon: Icon(
                    Icons.pause,
                  size:40 ,
                ),
                onPressed: ()=>pauseVideo(context)
            );
          }
          return Container();
        }
      ),
    );
  }
  void pauseVideo(context){
    BlocProvider.of<PlayerBloc>(context).add(PlayerVideoPause());
  }
  void playVideo(context){
    BlocProvider.of<PlayerBloc>(context).add(PlayerVideoPlay());
  }
}


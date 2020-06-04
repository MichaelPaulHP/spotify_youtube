import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_state.dart';
import 'package:loginfirebaseapp/player/models/History.dart';
import 'package:loginfirebaseapp/youtube/widgets/modal_videos.dart';
import 'package:loginfirebaseapp/youtube/widgets/player.dart';
import 'package:lottie/lottie.dart';

class PanelPlayer extends StatelessWidget {
  final ScrollController _sc;

  PanelPlayer(this._sc);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle("Videos"),
          _buildListVideoContainer(),
          _buildVideoContainer(),
          _buildMyHistory(context)
        ],
      ),
      controller: _sc,
    );
  }

  Widget _buildTitle(String text) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
          child: Text(text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ))),
    );
  }

  Widget _buildMyHistory(context) {
    History history =BlocProvider.of<PlayerBloc>(context).history;

    return BlocBuilder<PlayerBloc, PlayerState>(
        condition: (previousState, state) {
      if (state is PlayerVideoStartLoad) {
        return true;
      }
      return false;
    }, builder: (BuildContext context, PlayerState state) {

      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle("History: ${history.getLength()}"),
            ListViewVideos(videos: history.getVideos())
          ],
        ),
      );
    });
  }

  Widget _buildListVideoContainer() {
    return BlocBuilder<PlayerBloc, PlayerState>(
        condition: (previousState, state) {
      if (state is PlayerVideosLoaded) {
        return true;
      }
      return false;
    }, builder: (BuildContext context, PlayerState state) {
      if (state is PlayerVideosLoaded) {
        return ListViewVideos(videos: state.videos);
      }
      return _buildDefaultListVideoContainer();
    });
  }

  Widget _buildDefaultListVideoContainer() {
    return Container(
      child: Center(
        child: Text("Please select a track to watch"),
      ),
    );
  }

  Widget _buildVideoContainer() {
    return YouTubeVideoPlayer();
    /*return BlocBuilder<PlayerBloc, PlayerState>(
        condition: (previousState, state) {
      if (state is PlayerVideoStartLoad) {
        return true;
      }
      return false;
    }, builder: (BuildContext context, PlayerState state) {
      if (state is PlayerVideoStartLoad) {
        return YouTubeVideoPlayer(
          videoId: state.video.id,
        );
      }
      return _buildDefaultVideo();
    });*/

  }

  Widget _buildDefaultVideo() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            'assets/lottie/video-icon.json',
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
          Text("please select a video ☹")
        ],
      ),
    );
  }

  BorderRadiusGeometry _getBorderRadius() {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return radius;
  }
}

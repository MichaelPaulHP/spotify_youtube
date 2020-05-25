import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_state.dart';
import 'package:loginfirebaseapp/youtube/widgets/modal_videos.dart';
import 'package:loginfirebaseapp/youtube/widgets/player.dart';

class PanelPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          BlocBuilder<PlayerBloc, PlayerState>(
              condition: (previousState, state) {
            if (state is PlayerVideosLoaded) {
              return true;
            }
            return false;
          }, builder: (BuildContext context, PlayerState state) {
            if (state is PlayerVideosLoaded) {
              return ListViewVideos(videos: state.videos);
            }
            return Text("Please select a track to watch");
          }),
          BlocBuilder<PlayerBloc, PlayerState>(
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
            return Text("Please select a Video to watch");
          })
        ],
      ),
    );
  }

  Widget _buildListViewOfVideos(PlayerState state) {
    if (state is PlayerVideosLoaded) {
      return ListViewVideos(videos: state.videos);
    } else {
      return Text("Please select a track to find in YouTube ");
    }
  }
}

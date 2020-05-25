import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_state.dart';
import 'package:loginfirebaseapp/youtube/widgets/modal_videos.dart';
import 'package:lottie/lottie.dart';

class CollapsedPlayer extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.orange,
          borderRadius: getBorderRadius(),
      ),
      child: BlocBuilder<PlayerBloc, PlayerState>(
        condition: (previousState,state){
          if(state.history.isEmpty ||
              state is PlayerVideosLoading ||
              state is PlayerStarted ||
              state is PlayerVideosLoaded){
            return true;
          }

          return false;
        },
        builder: (BuildContext context,PlayerState state) {
           if(state is PlayerStarted){
             return Center(child: _buildClollapsedWhenStart());
           }
           if(state.history.isEmpty){
             return Center(child: _buildClollapsedWhenStart());
           }
           if(state is PlayerVideosLoading){
             return Center(child: _buildLoading());
           }
           if(state is PlayerVideosLoaded){
             return Text("Videos");
           }
           return Container();
        }
      ),
    );
  }

  BorderRadiusGeometry getBorderRadius(){
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return radius;
  }
  Widget _buildClollapsedWhenStart(){
    return  Lottie.asset(
      'assets/gifs/1446-bikingiscool.json',
      width: 60,
      height: 60,
      fit: BoxFit.fill,
    );
  }
  Widget _buildLoading(){
    return  Lottie.asset(
      'assets/gifs/22896-loading-animation.json',
      width: 60,
      height: 60,
      fit: BoxFit.fill,
    );
  }


}

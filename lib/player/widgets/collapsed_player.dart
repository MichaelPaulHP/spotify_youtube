import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_state.dart';
import 'package:loginfirebaseapp/youtube/widgets/player.dart';
import 'package:lottie/lottie.dart';

class CollapsedPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
        condition: (previousState, state) {

      if (state is PlayerVideosLoading || state is PlayerVideosLoaded || state is PlayerVideoPlaying||state is PlayerVideoPaused ) {
        return true;
      }
      return false;

    }, builder: (BuildContext _, PlayerState state) {

      if (state is PlayerVideosLoading) {
        return  _buildLoading(context);
      }
      else{
        return _buildBaseCollapsed(context,state);
      }
      /*if (state is PlayerVideosLoaded) {
        return _buildCollapsedWhenVideoLoad(context);
      }
      return _buildCollapsedWhenStart(context,state);*/
    });
  }

  BorderRadiusGeometry getBorderRadius() {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return radius;
  }

  Widget _buildCollapsedWhenVideoLoad(context){
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: getBorderRadius(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("You have Five Videos"),
            Lottie.asset(
              'assets/lottie/swipe.json',
              width: 60,
              height: 60,
              fit: BoxFit.fill,
            ),
          ],
        )
    );
  }

  Widget _buildCollapsedWhenStart(context,PlayerState state) {
    int cant = BlocProvider.of<PlayerBloc>(context).history.getLength();
    String img='assets/lottie/happy.json';
    if( cant==0){
      img="assets/lottie/sad.json";
    }
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: getBorderRadius(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text("You saw $cant videos"),
            ),
            Lottie.asset(
              img,
              width: 60,
              height: 60,
            ),
          ],
        )
    );
  }

  Widget _buildBaseCollapsed(context,PlayerState state){
    int cant = BlocProvider.of<PlayerBloc>(context).history.getLength();
    String img='assets/lottie/happy.json';
    if( cant==0){
      img="assets/lottie/sad.json";
    }

    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: getBorderRadius(),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text("You saw $cant videos"),
            ),
            /*Lottie.asset(
              img,
              width: 60,
              height: 60,
            ),*/
            YouTubeVideoPlayerControls(),
          ],
        )
    );
  }


  Widget _buildLoading(context) {
    return Container(
        decoration: BoxDecoration(
          color:Theme.of(context).backgroundColor,
          borderRadius: getBorderRadius(),

        ),
        height: 120,
        child: Lottie.asset(
          'assets/lottie/51-preloader.json',

        )
    );
  }
}

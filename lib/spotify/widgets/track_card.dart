
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/google/google_button.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_event.dart';
import 'package:loginfirebaseapp/spotify/tdo/track.dart';
import 'package:loginfirebaseapp/spotify/widgets/SpotifyButton.dart';


const double  _WIDTH=130;
const double _HEIGHT=50;
class TrackCard extends StatelessWidget   {
  final Track _track;


  TrackCard({Track track})
  :_track=track;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: ()=>_onTap(context),
      child: Container(
          height: _HEIGHT,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.audiotrack,
                size:15,
              ),
              Expanded(
                child:infoTrack() ,
              ),
              options(),
            ],
          )

      ),
    );
  }

  Widget infoTrack(){
    return Container(
      height: _HEIGHT,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text(
              "  ${_track.name}",
              textAlign: TextAlign.left,
              maxLines: 1,
              style: TextStyle(
                fontSize: 15.0,
              )
          ),
          Text(
            "   ${_track.artists} - ${_track.album} ",
            maxLines: 1,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget options(){
    return Container(
      height: _HEIGHT,
      width: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SpotifyButton(_track.uri),
          GoogleButton("${_track.name} ${_track.artists}"),
        ],
      ),
    );
  }

  void _onTap(context){
      BlocProvider.of<PlayerBloc>(context).add(PlayerVideoRequested(_track));
  }
}

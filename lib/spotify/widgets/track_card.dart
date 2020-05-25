import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_event.dart';
import 'package:loginfirebaseapp/spotify/playlist_bloc/playlist_bloc.dart';
import 'package:loginfirebaseapp/spotify/playlist_bloc/playlist_event.dart';
import 'package:loginfirebaseapp/spotify/tdo/track.dart';


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
              _track.name,
              textAlign: TextAlign.left,
              maxLines: 1,
              style: TextStyle(
                fontSize: 15.0,
              )
          ),
          Text(
            " ${_track.artists} - ${_track.album} ",
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
      width: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: ()=>{},
            icon: Icon( Icons.cast),
          ),
          IconButton(
            onPressed: ()=>{},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }

  void _onTap(context){
      BlocProvider.of<PlayerBloc>(context).add(PlayerVideoRequested(_track));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_event.dart';
import 'package:loginfirebaseapp/youtube/model/video.dart';
import 'package:url_launcher/url_launcher.dart';

const double _WIDTH = 130;
const double _HEIGHT = 150;

class VideoCard extends StatelessWidget {
  final Video _video;

  VideoCard({@required Video video}) : _video = video;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: ()=>{showVideo(context)},
      child: Container(
          height: _HEIGHT,
          width: _WIDTH,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                height: _HEIGHT - 40,
                width: _WIDTH,
                placeholder:
                    AssetImage("e"),
                image: CachedNetworkImageProvider(_video.thumbnail),
              ),
              InkWell(
                onTap: openYoutube,
                child:_buildVideoInfo(),
              )

            ],
          )),
    );
  }

  void showVideo(context){
    BlocProvider.of<PlayerBloc>(context).add(PlayerVideoSelected(video: _video));
  }

  void openYoutube()async{
    String url='https://www.youtube.com/watch?v=${_video.id}';
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }

  Widget _buildVideoInfo() {
    return Container(
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _video.title,
            textAlign: TextAlign.left,
            maxLines: 1,
          ),
          Text(
            _video.channelTitle?? "",
            maxLines: 1,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}

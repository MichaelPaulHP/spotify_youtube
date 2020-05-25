import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:loginfirebaseapp/spotify/widgets/playlist_card.dart';

class PlaylistListView extends StatelessWidget {
  final String _title;
  final List<Playlist> _playlists;

  PlaylistListView({@required String title,@required List<Playlist> playlists})
      : _title = title,
        _playlists = playlists;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          this.getTitle(),
          Container(
            height: 150,
            child: getListView(),
          )
        ],
      ),
    );
  }

  Widget getTitle() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 10),
        child: Text(this._title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            )));
  }

  Widget getListView() {

    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _playlists.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
            width: 20,
          );
        },
        itemBuilder: (context, index) {

          Playlist playlist = _playlists[index];
          return PlayListCard(playlist: playlist);
        });
  }
}

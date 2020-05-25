import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:loginfirebaseapp/spotify/tdo/track.dart';
import 'package:loginfirebaseapp/youtube/model/video.dart';

class PlaylistState {
  final Playlist _playlist;

  PlaylistState(this._playlist);

  Playlist get playlist => _playlist;
}

class PlaylistIsLoading extends PlaylistState{
  PlaylistIsLoading(Playlist playlist) : super(playlist);

}

class PlaylistLoaded extends PlaylistState{
  final List<Track> tracks;

  PlaylistLoaded(Playlist playlist,List<Track> tracks )
      :this.tracks=tracks,
        super(playlist);

}

class PlaylistNotLoaded extends PlaylistState{
  String error;
  PlaylistNotLoaded(Playlist playlist, this.error) : super(playlist);

}

class PlaylistTrackLoading extends PlaylistState {
  PlaylistTrackLoading(Playlist playlist) : super(playlist);

}
class PlaylistTrackLoaded extends PlaylistState{
  final List<Video> _videos;

  PlaylistTrackLoaded(Playlist playlist, this._videos) : super(playlist);

  List<Video> get videos => _videos;
}
class PlaylistTrackNotLoaded extends PlaylistState {
  final String error;
  PlaylistTrackNotLoaded(Playlist playlist,this.error) : super(playlist);

}
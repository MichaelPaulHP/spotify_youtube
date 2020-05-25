import 'package:loginfirebaseapp/spotify/repository/tokens_repository.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:loginfirebaseapp/spotify/tdo/tokens.dart';

class SpotifyState {}

class SpotifyInitial extends SpotifyState {}

class SpotifyTokenRequesting extends SpotifyState {}

class SpotifyTokenFound extends SpotifyState {}

class SpotifyTokenRequested extends SpotifyState {
  final Tokens _tokens;

  SpotifyTokenRequested({Tokens tokens}) : _tokens = tokens;
}

class SpotifyHasTokenExpired extends SpotifyState {}

class SpotifyHasError extends SpotifyState {
  final String errorMessage;

  SpotifyHasError(this.errorMessage);
}

class PlaylistsLoading extends SpotifyState{}

class PlaylistsLoaded extends SpotifyState{
  final List<Playlist> playlists;

  PlaylistsLoaded({this.playlists=const []});

  @override
  String toString() {
    return 'PlaylistsLoaded{playlists: $playlists}';
  }

}
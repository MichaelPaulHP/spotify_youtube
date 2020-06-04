import 'package:loginfirebaseapp/spotify/repository/tokens_repository.dart';
import 'package:loginfirebaseapp/spotify/tdo/tokens.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class SpotifyEvent{

}

class SpotifyStarted extends SpotifyEvent{

}

class SpotifyTokenRefreshed extends SpotifyEvent{

}

class SpotifyPlaylistsLoad extends SpotifyEvent{

}
class GotoPage extends SpotifyEvent{
  final int _page;

  GotoPage(this._page);

  int get page => _page;
}
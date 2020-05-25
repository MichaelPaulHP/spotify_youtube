import 'package:loginfirebaseapp/spotify/tdo/track.dart';

class PlaylistEvent {



}
class PlaylistStarted extends PlaylistEvent{

}


class PlaylistUpdated extends PlaylistEvent{

}

class PlaylistTrackTrap extends PlaylistEvent{
  final Track _track;

  PlaylistTrackTrap(this._track);

  Track get track => _track;
}

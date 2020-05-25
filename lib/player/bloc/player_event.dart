import 'package:loginfirebaseapp/spotify/tdo/track.dart';
import 'package:loginfirebaseapp/youtube/model/video.dart';

class PlayerEvent{

}

class PlayerVideoRequested extends PlayerEvent{
    final Track _track;

    PlayerVideoRequested(this._track);

    Track get track => _track;
}

class PlayerVideoSelected extends PlayerEvent{
    final Video _video;

    PlayerVideoSelected({Video video}):_video=video;

    Video get video => _video;
}

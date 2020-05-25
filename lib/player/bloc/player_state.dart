import 'package:loginfirebaseapp/youtube/model/video.dart';

class PlayerState{
  List<Video> history=List<Video>();

  void addVideoPlayed(Video video){
    this.history.add(video);
  }

}
class PlayerStarted extends PlayerState{}
class PlayerVideosLoading extends PlayerState{

}

class PlayerVideosLoaded extends PlayerState{
  final List<Video> _videos;

  PlayerVideosLoaded(this._videos);

  List<Video> get videos => _videos;
}

class PlayerVideosNotLoaded extends PlayerState {
  final String error;
  PlayerVideosNotLoaded(this.error);

}

class PlayerVideoStartLoad extends PlayerState{
  final Video _video;

  PlayerVideoStartLoad(this._video);

  Video get video => _video;
}
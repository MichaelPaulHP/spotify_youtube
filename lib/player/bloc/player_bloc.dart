import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_event.dart';
import 'package:loginfirebaseapp/player/bloc/player_state.dart';
import 'package:loginfirebaseapp/spotify/tdo/track.dart';
import 'package:loginfirebaseapp/youtube/model/video.dart';
import 'package:loginfirebaseapp/youtube/repository/youtube_repository.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  @override
  PlayerState get initialState {
    return PlayerStarted();
  }

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    if (event is PlayerVideoRequested) {
      yield* _mapPlayerVideoRequested(event);
    }
    if (event is PlayerVideoSelected) {
      yield* _mapPlayerVideoSelected(event);
    }
  }

  Stream<PlayerState> _mapPlayerVideoRequested(
      PlayerVideoRequested event) async* {
    try {
      //Playlist playlist = this.state.playlist;
      yield PlayerVideosLoading();
      Track track = event.track;
      String query = "${track.name} ${track.artists}";
      List<Video> videos = await YoutubeRepository.searchVideos(query);
      yield PlayerVideosLoaded(videos);
    } catch (e) {
      yield PlayerVideosNotLoaded(e.toString());
    }
  }

  Stream<PlayerState> _mapPlayerVideoSelected(
      PlayerVideoSelected event) async* {
    try {
      Video video = event.video;
      this.state.addVideoPlayed(video);
      yield PlayerVideoStartLoad(video);
    } catch (e) {
      yield PlayerVideosNotLoaded(e.toString());
    }
  }
}

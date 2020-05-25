import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/spotify/playlist_bloc/playlist_event.dart';
import 'package:loginfirebaseapp/spotify/playlist_bloc/playlist_state.dart';
import 'package:loginfirebaseapp/spotify/repository/tokens_repository.dart';
import 'package:loginfirebaseapp/spotify/services/playlists.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:loginfirebaseapp/spotify/tdo/track.dart';
import 'package:loginfirebaseapp/youtube/model/video.dart';
import 'package:loginfirebaseapp/youtube/repository/youtube_repository.dart';

class PlaylistBloc extends Bloc<PlaylistEvent,PlaylistState> {

  final Playlist _playlist;


  PlaylistBloc(this._playlist);

  @override
  PlaylistState get initialState {
    return PlaylistIsLoading(_playlist);
  }

  @override
  Stream<PlaylistState> mapEventToState(PlaylistEvent event) async* {

    if( event is PlaylistStarted){
      yield* _mapPlaylistStarted();
    }
    if(event is PlaylistTrackTrap){
      yield* _mapPlaylistTrackTrap(event);
    }
  }

  Stream <PlaylistState> _mapPlaylistTrackTrap(PlaylistTrackTrap event)async*{
    try{
      //Playlist playlist = this.state.playlist;
      yield PlaylistTrackLoading(null);
      Track track=event.track;
      String query="${track.name} ${track.artists}";
      List<Video> videos= await YoutubeRepository.searchVideos(query);
      yield PlaylistTrackLoaded(null,videos);

    }catch(e){
      yield PlaylistTrackNotLoaded(null,e.toString());
    }
  }

  Stream<PlaylistState> _mapPlaylistStarted()async*{
    try{

      Playlist playlist = this.state.playlist;

      yield PlaylistIsLoading(playlist);
      String accessToken= await TokensRepository.getAccessToken();

      if(playlist is MyTracksSaved ){
        List<Track> tracks=await Playlists.getMyTracksSaved(accessToken);
        yield PlaylistLoaded(playlist,tracks);
      }
      else{
        if(playlist is RecentlyPlayed ){
          List<Track> tracks=await Playlists.getMyRecentlyPlayed(accessToken);
          yield PlaylistLoaded(playlist,tracks);
        }
        else{
          List<Track> tracks=await Playlists.getTracksFromPlaylist(playlist.id,accessToken);
          yield PlaylistLoaded(playlist,tracks);
        }
      }
    }catch(e){
      yield PlaylistNotLoaded(null,e.toString());
    }
  }
}
import 'package:bloc/bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_event.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_state.dart';
import 'package:loginfirebaseapp/spotify/repository/tokens_repository.dart';
import 'package:loginfirebaseapp/spotify/services/exceptions.dart';
import 'package:loginfirebaseapp/spotify/services/playlists.dart';
import 'package:loginfirebaseapp/spotify/services/token/tokens.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:loginfirebaseapp/spotify/tdo/tokens.dart';
import 'package:loginfirebaseapp/spotify_authorization/repository/code_repository.dart';


import 'bloc.dart';

class SpotifyBloc extends Bloc<SpotifyEvent, SpotifyState> {


  @override
  SpotifyState get initialState {
    return SpotifyTokenRequesting();
  }

  @override
  Stream<SpotifyState> mapEventToState(SpotifyEvent event) async* {
    if (event is SpotifyStarted) {
      yield* _mapSpotifyStarted();
    }
    if(event is SpotifyTokenRefreshed){
      yield* _mapSpotifyTokenRefreshed();
    }
    if(event is SpotifyPlaylistsLoad){
      yield* _mapSpotifyPlaylistsLoadedToState();
    }
    if(event is GotoPage){
      yield* _mapGotoPage(event);
    }
  }

  Stream<SpotifyState> _mapGotoPage(GotoPage event)async*{

      yield PlayListInPageTwo(event.page);


  }
  Stream<SpotifyState> _mapSpotifyStarted() async* {
    // check if has tokens

    try{
      yield PlaylistsLoading();
      if (await TokensRepository.hasAccessToken()) {
        yield SpotifyTokenFound();
      }
      else{
        String authorizationCode = await CodeRepository.getCode();
        if(authorizationCode==null)
          throw (" Authorization code not found");
        yield SpotifyTokenRequesting();
        Tokens tokens = await TokensRequester
            .requestTokens(
            authorizationCode: authorizationCode
        );

        await TokensRepository.saveTokens(tokens);
        yield  SpotifyTokenRequested(tokens: tokens);
      }
      add(SpotifyPlaylistsLoad());

    }catch(e){
      print("error _mapSpotifyStarted:");
      print(e);
      yield SpotifyHasError(e.toString());
    }
  }

  Stream<SpotifyState> _mapSpotifyTokenRefreshed()async*{
    yield SpotifyTokenRequesting();
    try{
      String refreshRefresh=await TokensRepository.getRefreshToken();

      Tokens tokens = await TokensRequester.refreshToken(refreshToken:refreshRefresh );

      await TokensRepository.saveTokens(tokens);
      yield SpotifyTokenRequested(tokens: tokens);

    }catch(e){
      print("error _mapSpotifyTokenRefreshed:");
      print(e);
      yield SpotifyHasError(e.toString());
    }
  }

  Stream<SpotifyState> _mapSpotifyPlaylistsLoadedToState()async*{
    yield PlaylistsLoading();
    try{
      String accessToken= await TokensRepository.getAccessToken();
      List<Playlist> playlists=await  Playlists.getMyPlayLists(accessToken);
      yield PlaylistsLoaded(playlists:playlists );
    }catch(e){
      if( e is AccessTokenExpired) {
        add(SpotifyTokenRefreshed());
        add(SpotifyPlaylistsLoad());
      }
      else{
        print("error getMyPlayLists:");
        print(e);
        yield SpotifyHasError(e.toString());
      }


    }

  }

}
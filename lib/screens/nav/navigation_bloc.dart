import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:palette_generator/palette_generator.dart';

class NavigationState {
  final int numPage;
  NavigationState(this.numPage);
}

class NavInPlaylistDetail extends NavigationState {
  PaletteGenerator palette;
  Playlist playlist;
  NavInPlaylistDetail(this.palette, this.playlist) :super(2);
}

class NavInHome extends NavigationState {
  NavInHome() :super(1);
}

class NavEvent{}
class NavGoHome extends NavEvent{}
class NavGoToPlaylistDetail extends NavEvent{
  final PaletteGenerator palette;
  final Playlist playlist;
  NavGoToPlaylistDetail(this.palette, this.playlist);

}

class NavigationBloc extends Bloc<NavEvent,NavigationState>{

  @override
  NavigationState get initialState {
    return NavInHome();
  }

  @override
  Stream<NavigationState> mapEventToState(NavEvent event)async* {
    if(event is NavGoHome){
      yield* _mapNavGoHome();
    }
    if(event is NavGoToPlaylistDetail){
      yield* _mapNavGoToPlaylistDetail(event);
    }
  }
  Stream<NavigationState> _mapNavGoHome()async*{
    yield NavInHome();
  }
  Stream<NavigationState> _mapNavGoToPlaylistDetail(NavGoToPlaylistDetail event)async*{
    yield NavInPlaylistDetail(event.palette,event.playlist);
  }
}
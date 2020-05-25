import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/auth_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_state.dart';
import 'package:loginfirebaseapp/player/widgets/collapsed_player.dart';
import 'package:loginfirebaseapp/player/widgets/panel_player.dart';
import 'package:loginfirebaseapp/splash/splash_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_event.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_state.dart';
import 'package:loginfirebaseapp/spotify/repository/tokens_repository.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:loginfirebaseapp/spotify/widgets/modal_listener.dart';
import 'package:loginfirebaseapp/spotify/widgets/playlist_list_view.dart';
import 'package:loginfirebaseapp/spotify/widgets/user_card.dart';
import 'package:loginfirebaseapp/spotify_authorization/repository/code_repository.dart';
import 'package:loginfirebaseapp/theme/switch_theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatelessWidget {
  final PanelController _pc = new PanelController();

  @override
  Widget build(BuildContext context) {

    //BlocProvider.of<SpotifyBloc>(context).add(SpotifyStarted());

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed:()=>clearCode(context),
            icon: Icon(Icons.remove_circle),
          ),
          ModalListener(),
          SwitchTheme(),
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthUserLoggedOut());
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SlidingUpPanel(
        controller: _pc,
        minHeight: 60,
        collapsed: CollapsedPlayer(),
        panel: PanelPlayer(),
        body: BlocBuilder<SpotifyBloc, SpotifyState>(
            builder: (BuildContext context,SpotifyState state) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  myPlayLists(state),
                  getOwnPlaylist(),
                  BlocListener<PlayerBloc, PlayerState>(
                    listener: (BuildContext context,PlayerState state) {
                      if(state is PlayerVideosLoaded){
                        _pc.panelPosition = 0.5;
                      }
                    },
                    child: Container(),
                  )
                ],
              );



            }
        ),
      )
    );
  }

Widget myPlayLists(SpotifyState state){

    if(state is PlaylistsLoaded){
      return PlaylistListView(title: "My Playlists",playlists: state.playlists);
    }
    else{
      return Text("loading ...");
    }
}
Widget getOwnPlaylist(){
    MyTracksSaved myTracksSaved=MyTracksSaved();
    RecentlyPlayed recentlyPlayed=RecentlyPlayed();
    List<Playlist> playlists= List<Playlist>();
    playlists.add(myTracksSaved);
    playlists.add(recentlyPlayed);

    return PlaylistListView( title: "100% me",playlists: playlists);

}


  Future<void> clearCode(context)async{
    await CodeRepository.clearCode();
    String code = await CodeRepository.getCode();
    print("CODEE");
    print(code);
  }

}

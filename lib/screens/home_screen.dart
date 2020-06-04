import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/auth_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_state.dart';
import 'package:loginfirebaseapp/player/widgets/collapsed_player.dart';
import 'package:loginfirebaseapp/player/widgets/panel_player.dart';
import 'package:loginfirebaseapp/screens/nav/navigation_bloc.dart';
import 'package:loginfirebaseapp/splash/splash_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_event.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_state.dart';
import 'package:loginfirebaseapp/spotify/repository/tokens_repository.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:loginfirebaseapp/spotify/widgets/modal_listener.dart';
import 'package:loginfirebaseapp/spotify/widgets/playlist_detail.dart';
import 'package:loginfirebaseapp/spotify/widgets/playlist_list_view.dart';
import 'package:loginfirebaseapp/spotify/widgets/user_card.dart';
import 'package:loginfirebaseapp/spotify_authorization/repository/code_repository.dart';
import 'package:loginfirebaseapp/theme/switch_theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatelessWidget {
  final PanelController _pc = new PanelController();

  @override
  Widget build(BuildContext homeContext) {
    //BlocProvider.of<SpotifyBloc>(context).add(SpotifyStarted());

    return Scaffold(
        body: _buildListenerPlayer(child: _buildSlidingUpPanel(homeContext)));
  }
  Widget _buildSlidingUpPanel(homeContext){
    Size size= MediaQuery.of(homeContext).size;
    return SlidingUpPanel(
        controller: _pc,
        panelBuilder: (ScrollController sc) => PanelPlayer(sc),
        minHeight: 60,
        maxHeight: size.height*0.6,
        collapsed: CollapsedPlayer(),
        borderRadius: _getBorderRadius(),
        color: Theme.of(homeContext).backgroundColor,
        body: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (BuildContext context, NavigationState state) {
              if (state is NavInPlaylistDetail) {
                PlaylistDetail screen = PlaylistDetail(
                  playlist: state.playlist,
                  paletteGenerator: state.palette,
                );
                return screen;
              }
              return _buildHome(homeContext);
            }));
  }

  Widget _buildAppBar(context) {
    return AppBar(
      title: Text("Home"),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        ModalListener(),
        SwitchTheme(),
        IconButton(
          onPressed: () => _showModalWithUser(context),
          icon: Icon(Icons.perm_identity),
        )
      ],
    );
  }

  void _showModalWithUser(context) {
    //showDialog(context: context, child: UserCard());
    showAboutDialog(context: context,children: [ UserCard()]);
  }

  Widget _buildHome(homeContext) {
    return BlocBuilder<SpotifyBloc, SpotifyState>(
        builder: (BuildContext context, SpotifyState state) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildAppBar(homeContext),
          myPlayLists(state),
          getOwnPlaylist(),
        ],
      );
    });
  }

  Widget _buildListenerPlayer({Widget child}) {
    return BlocListener<PlayerBloc, PlayerState>(
      listener: (BuildContext context, PlayerState state) {
        if (state is PlayerVideosLoaded) {
          print("OPENNNNNNNNNNNNNN");
          _pc.open();
        }
      },
      child: child,
    );
  }

  Widget myPlayLists(SpotifyState state) {
    if (state is PlaylistsLoaded) {
      return PlaylistListView(
          title: "My Playlists", playlists: state.playlists);
    } else {
      return Text("loading ...");
    }
  }

  Widget getOwnPlaylist() {
    MyTracksSaved myTracksSaved = MyTracksSaved();
    RecentlyPlayed recentlyPlayed = RecentlyPlayed();
    List<Playlist> playlists = List<Playlist>();
    playlists.add(myTracksSaved);
    playlists.add(recentlyPlayed);

    return PlaylistListView(title: "Uniquely yours", playlists: playlists);
  }

  Future<void> clearCode(context) async {
    await CodeRepository.clearCode();
    String code = await CodeRepository.getCode();
    print("CODEE");
    print(code);
  }

  BorderRadiusGeometry _getBorderRadius() {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return radius;
  }
}

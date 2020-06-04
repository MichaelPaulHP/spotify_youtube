import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/repository/user_repository.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_event.dart';
import 'package:loginfirebaseapp/screens/home_screen.dart';
import 'package:loginfirebaseapp/screens/nav/navigation_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_event.dart';
import 'package:loginfirebaseapp/spotify_authorization/bloc/spotify_authorization_bloc.dart';
import 'package:loginfirebaseapp/spotify_authorization/repository/authorize_constants.dart';
import 'package:lottie/lottie.dart';


import 'package:url_launcher/url_launcher.dart';

class SpotifyAuthScreen extends StatelessWidget {


  final UserRepository _userRepository;

  SpotifyAuthScreen({UserRepository userRepository})
      : this._userRepository = userRepository;

  /*appBar: AppBar(
              title: Text("Spotify Authorization"),
  * */
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotifyAuthorizationBloc,
                SpotifyAuthorizationState>(
              builder: (BuildContext c, SpotifyAuthorizationState state) {
                if (state is SpotifyAuthorizationIsDenied) {

                  return Scaffold(
                    appBar:  AppBar(
                      title: Text("Spotify Authorization"),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          _buildTitle("Spotify Authorization Scopes."),
                          SizedBox(
                            height: 10,
                          ),
                          Text("We need your authorization to:"),
                          Text("- Read access to user’s email address."),
                          Text("- Read access to a user’s recently played tracks."),
                          Text("- Read access to user's playlists."),
                          SizedBox(
                            height: 20,
                          ),
                          FlatButton(
                            color: const Color(0xff0065CC),
                            textColor: Color(0xffECF0BC),
                            onPressed: () => {goFormSpotifyAuth(c)},
                            child: Text("Click here to go authorize"),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is SpotifyAuthorizationIsUndefined) {

                  BlocProvider.of<SpotifyAuthorizationBloc>(context)
                      .add(SpotifyAuthorizationChecked());
                  return Scaffold(body: Center(child: _builProgressIndicator()));
                }

                if (state is SpotifyAuthorizationIsSuccess) {
                  // home Screen
                  //return Center(child: Text("SpotifyAuthorizationIsSuccess"));
                  return MultiBlocProvider(
                        providers:[
                          BlocProvider<SpotifyBloc>(
                            create: (BuildContext context) => SpotifyBloc()..add(SpotifyStarted()),
                          ),
                          BlocProvider<PlayerBloc>(
                            create: (BuildContext context) => PlayerBloc()..add(PlayerHistoryLoad()),
                          ),
                          BlocProvider<NavigationBloc>(
                            create: (BuildContext context) => NavigationBloc(),
                          ),
                        ],
                        child:HomeScreen()
                        );

                }

                if (state is SpotifyAuthorizationIsInProgress){
                  return Scaffold(
                    appBar:  AppBar(
                      title: Text("Spotify Authorization"),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Waiting for your authorization"),
                          SizedBox(
                            height: 10,
                          ),
                          _builProgressIndicator()
                        ],
                      ),
                    ),
                  );
                }
                return Text("GG");
              },
            );
  }
  Widget _builProgressIndicator(){
    return Container(
        height: 120,
        child: Lottie.asset(
          'assets/lottie/51-preloader.json',
          height: 120,
          width: 120,
        )
    );
  }
  Widget _buildTitle(String text) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
          child: Text(text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ))),
    );
  }
  void goFormSpotifyAuth(BuildContext context) async {
    String userId= await _userRepository.getUser();
    String url = AuthorizeConstants.getUrlWithState(userId);
    if (await canLaunch(url)) {
      await launch(url);
      BlocProvider.of<SpotifyAuthorizationBloc>(context)
          .add(SpotifyAuthorizationStarted(userId: userId));
    } else {
      throw 'Could not launch $url';
    }

    /*Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SpotifyAuthorizationForm();
    }));*/
  }
}

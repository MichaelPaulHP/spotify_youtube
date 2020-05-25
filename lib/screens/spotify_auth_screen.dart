import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/repository/user_repository.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/screens/home_screen.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_event.dart';
import 'package:loginfirebaseapp/spotify_authorization/bloc/spotify_authorization_bloc.dart';
import 'package:loginfirebaseapp/spotify_authorization/repository/authorize_constants.dart';


import 'package:url_launcher/url_launcher.dart';

class SpotifyAuthScreen extends StatelessWidget {


  final UserRepository _userRepository;

  SpotifyAuthScreen({UserRepository userRepository})
      : this._userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text("Spotify Authorization"),
            ),
            body: BlocBuilder<SpotifyAuthorizationBloc,
                SpotifyAuthorizationState>(
              builder: (BuildContext c, SpotifyAuthorizationState state) {
                if (state is SpotifyAuthorizationIsDenied) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Text("Spotify Authorization si required"),
                        FlatButton(
                          onPressed: () => {goFormSpotifyAuth(c)},
                          child: Text("Click here"),
                        )
                      ],
                    ),
                  );
                }
                if (state is SpotifyAuthorizationIsUndefined) {

                  BlocProvider.of<SpotifyAuthorizationBloc>(context)
                      .add(SpotifyAuthorizationChecked());
                  return Center(child: CircularProgressIndicator());
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
                            create: (BuildContext context) => PlayerBloc(),
                          ),
                        ],
                        child:HomeScreen()
                        );
                  /*return BlocProvider<SpotifyBloc>(
                      create: (context) => SpotifyBloc()..add(SpotifyStarted()),
                      child: HomeScreen()
                  );*/
                }

                if (state is SpotifyAuthorizationIsInProgress){
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Text("Waiting Spotify Authorization"),
                        CircularProgressIndicator()
                      ],
                    ),
                  );
                }
                return Text("GG");
              },
            ));
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

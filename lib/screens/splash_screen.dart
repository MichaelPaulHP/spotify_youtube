import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/auth_bloc.dart';
import 'package:loginfirebaseapp/auth/repository/user_repository.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/screens/auth_method_screen.dart';
import 'package:loginfirebaseapp/screens/home_screen.dart';
import 'package:loginfirebaseapp/screens/spotify_auth_screen.dart';
import 'package:loginfirebaseapp/splash/splash.dart';
import 'package:loginfirebaseapp/splash/splash_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_event.dart';
import 'package:loginfirebaseapp/spotify_authorization/bloc/spotify_authorization_bloc.dart';

class SplashScreen extends StatelessWidget {
  final UserRepository _userRepository;

  SplashScreen({UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, splashState>(
        builder: (BuildContext context, splashState state) {

      switch (state) {
        case splashState.isInProgress:
          return Splash();

        case splashState.signedInNotFound:
          return AuthMethodScreen(
                  userRepository: _userRepository,
          );

        case splashState.authorizationSuccess:
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
              child: HomeScreen());*/

        case splashState.authorizationNotFound:
          return BlocProvider<SpotifyAuthorizationBloc>(
              create: (context) => SpotifyAuthorizationBloc(),
              child: SpotifyAuthScreen(userRepository: _userRepository));
      }
      return Container();
    });
  }
}

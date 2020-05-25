import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/auth_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginfirebaseapp/simple_bloc_delegate.dart';
import 'package:loginfirebaseapp/screens/splash_screen.dart';
import 'package:loginfirebaseapp/splash/splash_bloc.dart';

import 'package:loginfirebaseapp/theme/theme_bloc.dart';

import 'auth/repository/user_repository.dart';
import 'screens/spotify_auth_screen.dart';
import 'spotify_authorization/bloc/spotify_authorization_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (c) => ThemeBloc(),
      ),
      BlocProvider<AuthBloc>(
        create: (c)=>AuthBloc(userRepository),
      )
    ],
    child: MyApp(userRepository),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp(this._userRepository);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {

        return MaterialApp(
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (BuildContext context,AuthState  state) {

                if(state is UserIsUnauthenticated || state is UserIsUninitialized){
                  return  BlocProvider<SplashBloc>(
                    create: (BuildContext context) =>
                    SplashBloc(userRepository: _userRepository)..add(splash.started),
                    child: SplashScreen(userRepository: _userRepository),
                  );
                }

                if(state is UserIsAuthenticated){
                  return BlocProvider<SpotifyAuthorizationBloc>(
                      create: (context) => SpotifyAuthorizationBloc(),//..add(SpotifyAuthorizationChecked()),
                      child: SpotifyAuthScreen(userRepository: _userRepository));
                }
                return Container();
              }
            ),
            theme: state.themeData.copyWith(
                textTheme:GoogleFonts.lektonTextTheme(Theme.of(context).textTheme,)
            )
        );
      },
    );
  }
}

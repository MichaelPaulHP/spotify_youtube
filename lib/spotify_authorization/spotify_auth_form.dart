import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/spotify_authorization/bloc/spotify_authorization_bloc.dart';

class SpotifyAuthorizationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SpotifyAuthorizationBloc, SpotifyAuthorizationState>(
      listener: (BuildContext c, SpotifyAuthorizationState state){
        if(state is SpotifyAuthorizationIsInProgress){

        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("form"),
        ),
        body: BlocListener<SpotifyAuthorizationBloc, SpotifyAuthorizationState>(
          listener: (BuildContext c, SpotifyAuthorizationState state){
            if(state is SpotifyAuthorizationIsInProgress){

            }
          } ,
          child: Container() ,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_bloc.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_event.dart';
import 'package:loginfirebaseapp/spotify/bloc/spotify_state.dart';

class ModalListener extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpotifyBloc,SpotifyState>(
      listener: (BuildContext context,SpotifyState state) {
        if(state is SpotifyHasError){
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.errorMessage),
                  ],
                ),
              ),
            );
        }
        if(state is SpotifyTokenRequesting){
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SpotifyTokenRequesting ..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if(state is SpotifyTokenRequested){
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SpotifyTokenRequested"),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if(state is SpotifyHasTokenExpired){
          BlocProvider.of<SpotifyBloc>(context).add(SpotifyTokenRefreshed());
        }
      },
      child: Container(),
    ) ;
  }
}

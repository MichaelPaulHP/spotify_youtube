part of './spotify_authorization_bloc.dart';

class SpotifyAuthorizationEvent {}

class SpotifyAuthorizationChecked extends SpotifyAuthorizationEvent {}

class SpotifyAuthorizationStarted extends SpotifyAuthorizationEvent {
  final String userId;

  SpotifyAuthorizationStarted({ String  userId})
      :this.userId=userId;

}

class SpotifyAuthorizationCompleted extends SpotifyAuthorizationEvent {}

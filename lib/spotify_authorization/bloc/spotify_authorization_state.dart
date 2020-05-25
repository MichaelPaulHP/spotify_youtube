part of './spotify_authorization_bloc.dart';

class SpotifyAuthorizationState {
  const SpotifyAuthorizationState();
}

class SpotifyAuthorizationIsUndefined extends SpotifyAuthorizationState {}

class SpotifyAuthorizationIsSuccess extends SpotifyAuthorizationState {}

class SpotifyAuthorizationIsDenied extends SpotifyAuthorizationState {}

class SpotifyAuthorizationIsInProgress extends SpotifyAuthorizationState {}

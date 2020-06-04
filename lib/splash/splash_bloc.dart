import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/repository/user_repository.dart';
import 'package:loginfirebaseapp/spotify_authorization/repository/code_repository.dart';

enum splashState {
  isInProgress,
  signedInNotFound,
  authorizationSuccess,
  authorizationNotFound,
}
enum splash {
  started,
  signOut
}

class SplashBloc extends Bloc<splash, splashState> {
  final UserRepository _userRepository;

  SplashBloc({UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  splashState get initialState {
    return splashState.isInProgress;
  }

  @override
  Stream<splashState> mapEventToState(splash event) async* {
    switch (event) {
      case splash.started:
        yield* _mapSplashStarted();
        break;
      case splash.signOut:
        yield* _mapSignOut();
        break;
    }
  }

  Stream<splashState> _mapSplashStarted() async* {
    await _userRepository.signInAnonymously();
    if (await _userRepository.isSignedIn()) {
      bool hasAuthSpotify = await CodeRepository.getCode() != null;

      if (hasAuthSpotify) {
        yield splashState.authorizationSuccess;
      } else {
        yield splashState.authorizationNotFound;
      }
    } else {
      yield splashState.signedInNotFound;
    }
  }
  Stream<splashState> _mapSignOut() async*{
    yield splashState.isInProgress;
    await this._userRepository.signOut();
    yield splashState.signedInNotFound;

  }
}

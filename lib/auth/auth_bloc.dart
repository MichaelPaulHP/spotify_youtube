import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/repository/user_repository.dart';

part 'authentication_bloc/auth_state.dart';

part 'authentication_bloc/auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc(this._userRepository);

  @override
  AuthState get initialState{
    return UserIsUninitialized();
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthUserAppStarted) {
       yield* _mapAuthUserAppStartedToEvent();
    }
    if (event is AuthUserLoggedIn) {
      yield* _mapAuthUserLoggedIn();
    }
    if (event is AuthUserLoggedOut) {
      yield* _mapAuthUserLoggedOut();
    }
  }

  Stream<AuthState> _mapAuthUserAppStartedToEvent() async* {
    if (await _userRepository.isSignedIn()) {
      final user = await _userRepository.getUser();
      yield UserIsAuthenticated(user);
    } else {
      yield UserIsUnauthenticated();
    }
  }

  Stream<AuthState> _mapAuthUserLoggedIn() async* {
    final user = await _userRepository.getUser();
    yield UserIsAuthenticated(user);
  }

  Stream<AuthState> _mapAuthUserLoggedOut() async* {
    yield UserIsUninitialized();
    _userRepository.signOut();
  }
}

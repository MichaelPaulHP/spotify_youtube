part of '../auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props {
    return [];
  }
}

class UserIsUninitialized extends AuthState {}

class UserIsAuthenticated extends AuthState {
  final String displayName;

  const UserIsAuthenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'UserIsAuthenticated { displayName: $displayName }';
}

class UserIsUnauthenticated extends AuthState {}

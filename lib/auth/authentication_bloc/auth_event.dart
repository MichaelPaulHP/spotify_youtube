
part of '../auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthUserAppStarted extends AuthEvent {}

class AuthUserLoggedIn extends AuthEvent {}

class AuthUserLoggedOut extends AuthEvent {}

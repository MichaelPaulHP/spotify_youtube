import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/theme/dark.dart';

class ThemeState {
  ThemeType type;
  ThemeData themeData;

  ThemeState(this.type, this.themeData);
}
enum ThemeType { DARK, LIGHT, TOGGLE }

class ThemeBloc extends Bloc<ThemeType, ThemeState> {
  @override
  ThemeState get initialState {
    return ThemeState(ThemeType.DARK, darkTheme);
  }

  @override
  Stream<ThemeState> mapEventToState(ThemeType themeType) async* {
    switch (themeType) {
      case ThemeType.DARK:
        yield ThemeState(ThemeType.DARK, darkTheme);
        break;
      case ThemeType.LIGHT:
        yield ThemeState(ThemeType.LIGHT, ThemeData.light());
        break;
      case ThemeType.TOGGLE:
        yield toggleTheme();
        break;
    }
  }

  ThemeState toggleTheme() {
    switch (this.state.type) {
      case ThemeType.LIGHT:
        return ThemeState(ThemeType.DARK, ThemeData.dark());
        break;
      case ThemeType.DARK:
        return ThemeState(ThemeType.LIGHT, ThemeData.light());
        break;
      case ThemeType.TOGGLE:
        break;
    }

  }
}



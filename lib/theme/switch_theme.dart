import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_bloc.dart';





class SwitchTheme extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final ThemeBloc themeBloc = context.bloc<ThemeBloc>();

    return Switch(
        value: themeBloc.state.type==ThemeType.DARK,
        onChanged: (bool isDark){
          if(isDark)
            themeBloc.add(ThemeType.DARK);
          else
            themeBloc.add(ThemeType.LIGHT);
        } ,

      );

  }

}
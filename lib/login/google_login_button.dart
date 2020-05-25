import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/auth_bloc.dart';
import 'package:loginfirebaseapp/login/bloc/bloc.dart';

import 'bloc/login_bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc,LoginState>(
      listener: (_,LoginState state){
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(AuthUserLoggedIn());
        }
      },
      child: RaisedButton.icon(
          onPressed: ()=> this._onPressed(context),
          icon: Icon(Icons.category),
          label: Text("")
      ),
    );

  }

  void _onPressed(context) {
    BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
  }
}

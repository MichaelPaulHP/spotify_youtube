import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/repository/user_repository.dart';
import 'package:loginfirebaseapp/login/bloc/bloc.dart';
import 'package:loginfirebaseapp/login/create_account_button.dart';
import 'package:loginfirebaseapp/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Email'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepository: _userRepository),
          child: LoginForm(userRepository: _userRepository),
        ),
      ),
    );
  }
}
/*BlocProvider<LoginBloc>(
                    create: (context) =>
                        LoginBloc(userRepository: _userRepository),
                    child: LoginForm(userRepository: _userRepository),
                  ),*/

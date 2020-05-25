import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/auth_bloc.dart';
import 'package:loginfirebaseapp/auth/repository/user_repository.dart';
import 'package:loginfirebaseapp/login/bloc/bloc.dart';
import 'package:loginfirebaseapp/login/create_account_button.dart';
import 'package:loginfirebaseapp/login/google_login_button.dart';

import 'package:loginfirebaseapp/screens/login_screen.dart';

class AuthMethodScreen extends StatelessWidget {
  final UserRepository _userRepository;

  AuthMethodScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print("close app");
            },
            child: Icon(Icons.close),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
            child: Text(
              "HOW DO YOU WANT TO LOG IN ?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(userRepository: _userRepository),
                child: option(widgets: [GoogleLoginButton()]),
              ),
              option(widgets: [
                FlatButton(
                  onPressed: () => this.onPressed(context),
                  child: Icon(
                    Icons.mail,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
                Text("EMAIL", textAlign: TextAlign.center)
              ]),
            ],
          ),
          CreateAccountButton(userRepository: _userRepository)
        ],
      ),
    );
  }

  void onPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginScreen(userRepository: _userRepository);
    }));
    /*Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginScreen(userRepository: _userRepository);
    }));*/
  }

  Widget option({List<Widget> widgets}) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }

}

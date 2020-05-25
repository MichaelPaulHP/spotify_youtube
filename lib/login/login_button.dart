import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget{

  final VoidCallback _onPressed;

  LoginButton(this._onPressed);


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this._onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: Text("Login"),
    );
  }
}
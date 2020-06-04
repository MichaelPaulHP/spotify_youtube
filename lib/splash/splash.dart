import 'package:flutter/material.dart';

class Splash extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildTitle("H H . . ."),
          SizedBox(
            height: 10,
          ),
          _buildTitle("____     ")
        ],
      ),
    );
  }
  Widget _buildTitle(String text) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ));
  }
}

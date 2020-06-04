import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleButton extends StatelessWidget  {
  final String q;


  GoogleButton(this.q);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:goGoogle ,
      child: Icon(
        Icons.search
      ),
    );
  }
  void goGoogle() async {
    String go="https://www.google.com/search?&q=$q";
    if (await canLaunch(go)) {
      await launch(go);
    } else {
      throw 'Could not launch $go';
    }
  }
}

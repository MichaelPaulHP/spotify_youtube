import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotifyButton extends StatelessWidget  {
  final String uri;


  SpotifyButton(this.uri);

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap:goSpotify ,
      child: Image(
        width: 24,
        height: 24,
        image:AssetImage("assets/images/spotify_logo.png"),
      ),
    );
  }
  void goSpotify() async {
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

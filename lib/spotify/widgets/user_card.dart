import 'package:flutter/material.dart';
import 'package:loginfirebaseapp/spotify/repository/tokens_repository.dart';
import 'package:loginfirebaseapp/spotify/services/user/profile.dart';
import 'package:loginfirebaseapp/spotify/tdo/User.dart';

class UserCard extends StatefulWidget {

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String user="user";
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: requestUser,
      child: Text(this.user),
    );
  }

  void requestUser() async {
    String at =await TokensRepository.getAccessToken();
    User userRes= await Profile().getMe(accessToken:at );
    this.setState(() {
      this.user=userRes.toString();
    });

  }

}

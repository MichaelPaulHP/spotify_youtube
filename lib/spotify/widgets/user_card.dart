import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/auth/auth_bloc.dart';
import 'package:loginfirebaseapp/spotify/repository/tokens_repository.dart';
import 'package:loginfirebaseapp/spotify/services/user/profile.dart';
import 'package:loginfirebaseapp/spotify/tdo/User.dart';
import 'package:loginfirebaseapp/spotify/widgets/SpotifyButton.dart';
import 'package:lottie/lottie.dart';

class UserCard extends StatefulWidget {

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  User _user;
  String userText="user";
  @override
  Widget build(BuildContext context) {
    if(_user==null){
      requestUser();
      return _onLoading();
    }
    else{
      return _buildBody(context);
    }
  }

  Widget _buildBody(context){
    return Container(
      height: 200,
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          FadeInImage(
            height: 100,
            width: 100,
            placeholder:AssetImage("assets/gifs/loading_line.gif"),
            //AssetImage("assets/images/spotifyLogoTransparent.png"),
            image: CachedNetworkImageProvider(_user.imageUrl),
            fit: BoxFit.cover,
          ),
          Text(_user.displayName),
          Text(_user.email),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(_user.country),
              Text(" ${_user.followers} "),
              SpotifyButton(_user.uri),
            ],
          ),

        ],
      ),
    );

  }

  Widget _onLoading(){
    return Container(
        height: 120,
        child: Lottie.asset(
          'assets/lottie/51-preloader.json',
          height: 120,
          width: 120,
        )
    );
  }

  void requestUser() async {
    String at =await TokensRepository.getAccessToken();
    User userRes= await Profile().getMe(accessToken:at );
    this.setState(() {
      this._user=userRes;
    });

  }

}

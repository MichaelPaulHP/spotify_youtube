import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebaseapp/auth/repository/user_repository.dart';
import 'package:loginfirebaseapp/screens/register_screen.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : this._userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have a _ account ?",
            style: TextStyle(
                color: Theme.of(context).unselectedWidgetColor
            ),
          ),
          FlatButton(
            child: Text("Create a Account"),
            onPressed: () => this.onPressed(context),
          )
        ],
      ),
    );
  }

  void onPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RegisterScreen(userRepository: _userRepository);
    }));
  }


}

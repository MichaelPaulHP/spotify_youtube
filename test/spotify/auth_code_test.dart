import 'package:loginfirebaseapp/spotify_authorization/repository/authorize_constants.dart';
import 'package:test/test.dart';

void main (){
  group("get code of autentification",(){

    String autorizeUrl=AuthorizeConstants.getUrlWithState("testUser");
    print ("open url for get authorization code");
    print(autorizeUrl);

  });

}
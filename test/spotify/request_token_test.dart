
import 'package:loginfirebaseapp/spotify/services/token/tokens.dart';
import 'package:loginfirebaseapp/spotify/services/user/profile.dart';
import 'package:loginfirebaseapp/spotify/tdo/User.dart';
import 'package:loginfirebaseapp/spotify/tdo/tokens.dart';

import 'package:test/test.dart';

void main() {
  group("token Resquest",(){
    Tokens tokens;

    test("test should return  a token",()async{


      String authCode="AQDRhjkNqbuV-PMtJYNQaRyAGJ4K2Vwj1LjWtmMfp1JvfBThK36eFDMy5i5IuIbw4KJ9MTLNH5TUbtk5wnkJuOiMV55VM9Q5LaCfY7x6TTBiT-SJm0OglazA_DCZvh9gJMSyHjZQhMFtuz43PGKaZruxc-th5NDNImkKzdJBwIkHdEryzSov1E5G_KFarN_XCfk-5ZHCnA4TdYiFHkLxB4yvOFxGgZwybPpFQD3FFNSL2OmpzQTsurHgkr4JleSy8uNSmnb0OT1ofNm1rJNoqfVI-LD2j7RBceYIpv49saOOx-3G8iJboNRvH48FuV3ri5q4F97gLJs0BAwLx-aUcTeObTKHD5lpnubbuRJYXvOrfw";
      tokens =await TokensRequester.requestTokens(authorizationCode: authCode);
      print(tokens.toString());
      expect(tokens, const TypeMatcher<Tokens>());
    });
    test("should restu a new ",()async {

      expect(tokens.accessToken,TypeMatcher<String>());
      expect(tokens.refreshToken,TypeMatcher<String>());
      print (tokens.expiresIn.toString());

      Tokens newToken=await TokensRequester.refreshToken(refreshToken: tokens.refreshToken);
      print("token refresh");
      print(newToken);
      expect(newToken, TypeMatcher<Tokens>());
    });
    test("show retured a user",()async {

      User user =  await Profile().getMe(accessToken: tokens.accessToken);
      print(user);
      expect(user, TypeMatcher<User>());
    });
  });

}
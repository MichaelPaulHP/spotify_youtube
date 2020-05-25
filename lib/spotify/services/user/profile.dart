import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:loginfirebaseapp/spotify/repository/tokens_repository.dart';
import 'package:loginfirebaseapp/spotify/services/service_constants.dart';
import 'package:loginfirebaseapp/spotify/tdo/User.dart';

class Profile {
  Future<User> getMe({String accessToken}) async {

    try{
      Map<String, String> header = {"Authorization": "Bearer " + accessToken};
      http.Response res = await http.get(SpotifyServiceConstants.CURRENT_PROFILE,
          headers: header);
      if(res.statusCode==200){
        print("BODY");
        print(res.body);
        print("END BODY");
        var json = convert.jsonDecode(res.body);
        return User.getFromJson(json);
      }
      throw Exception("status: ${res.statusCode}  ${res.body}");
      }catch(e){
        throw e;
    }

  }
}

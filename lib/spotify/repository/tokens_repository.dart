import 'package:loginfirebaseapp/spotify/tdo/tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokensRepository{
  
  static Future<void>  saveTokens(Tokens tokens) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("spotify_access_token", tokens.accessToken);
    prefs.setString("spotify_token_type", tokens.tokenType);
    prefs.setString("spotify_scope", tokens.scope);
    prefs.setInt("spotify_expires_in", tokens.expiresIn);
    // when request refresh token, the response don't have refresh token.
    if(tokens.refreshToken !=null && tokens.refreshToken.isNotEmpty)
      prefs.setString("spotify_refresh_token", tokens.refreshToken);
  }

  static Future<String> getRefreshToken() async {
    return _get("spotify_refresh_token");
  }
  static Future<String>  getAccessToken() async  {
    return  _get("spotify_access_token");
  }

  static Future<bool> hasAccessToken()async {
    print("get accestoken");
    String at=await _get("spotify_access_token");
    print(at);
    return at!=null;
  }
  static Future<String> _get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String token =  prefs.getString(key)?? null;
    return token;
  }
}
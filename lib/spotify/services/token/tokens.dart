import 'dart:convert';

import 'package:loginfirebaseapp/spotify/tdo/tokens.dart';

import 'package:loginfirebaseapp/spotify_authorization/repository/authorize_constants.dart';

import 'package:http/http.dart' as http ;

import '../client_constants.dart';

class TokensRequester {
  static String _URL = "https://accounts.spotify.com/api/token";

  static Future<Tokens> requestTokens({String authorizationCode}) async {
    const redirectUrl = AuthorizeConstants.redirectUrl;
    String code = authorizationCode;
    Map<String, String> body = {
      "grant_type": "authorization_code",
      "code": code,
      "redirect_uri": redirectUrl,
      "client_id": ClientConstants.ID,
      "client_secret": ClientConstants.SECRET
    };
    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    try {
      return await _request(body, header);
    } catch (e) {
      throw e;
    }
  }

  static Future<Tokens> refreshToken({String refreshToken}) async {
    String clientId = ClientConstants.ID;
    String clientSecret = ClientConstants.SECRET;
    List encodeText = utf8.encode(clientId + ":" + clientSecret);
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));
    String encode = base64.encode(encodeText);

    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization":  basicAuth
    };

    Map<String, String> body = {
      "grant_type": "refresh_token",
      "refresh_token": refreshToken,
    };

    try {
      return await _request(body, header);
    } catch (e) {
       throw e;
    }
  }

  static Future<Tokens> _request(Map<String, String> body,
      Map<String, String> header) async {
    try {
      http.Response res = await http.post(_URL, body: body, headers: header);
      int status = res.statusCode;
      if(status==200){
        var json = jsonDecode(res.body);
        return Tokens.fromJson(json);
      }
      print("RESPOINSEESS");
      print(res.statusCode);
      print("\n");
      print(res.body);
      //throw Exception( [res.statusCode,res.body]);
      throw Exception( res.body);
      /*print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');*/

    } catch (e) {
      throw e;
    }
  }

}
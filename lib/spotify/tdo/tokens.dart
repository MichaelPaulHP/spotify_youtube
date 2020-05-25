
class Tokens{
  final String accessToken;
  final String tokenType;
  final String scope;
  final int expiresIn;
  final String refreshToken;

  Tokens({this.accessToken,this.tokenType,this.scope,this.expiresIn,this.refreshToken});

  factory Tokens.fromJson(Map<String, dynamic> json) =>
      _$InitCredentialFromJson(json);

  @override
  String toString() {
    return 'Tokens{accessToken: $accessToken, tokenType: $tokenType, scope: $scope, expiresIn: $expiresIn, refreshToken: $refreshToken}';
  }


}

Tokens _$InitCredentialFromJson(Map<String, dynamic> json) {
  return Tokens(
    accessToken: json['access_token'] as String,
    tokenType: json['token_type'] as String,
    scope: json["scope"] as String,
    expiresIn: json["expires_in"] as int,
    refreshToken: json["refresh_token"] as String,
  );

}
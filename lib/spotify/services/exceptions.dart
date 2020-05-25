class AccessTokenExpired implements Exception{

  final message ="The access token expired";

  @override
  String toString() {
    return message;
  }
  const AccessTokenExpired();
}
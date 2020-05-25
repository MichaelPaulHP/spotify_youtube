class AuthorizeConstants {

  static const  redirectUrl="https://us-central1-myauthflutter.cloudfunctions.net/listenigSpotify";
  static const scopes = 'user-read-private'
      ' user-read-email'
      ' playlist-read-collaborative'
      ' playlist-read-private'
      ' user-read-recently-played'
      ' user-library-read';

  static String getURL() {
    const myCliendId="faa6a7d064024d18b2c365da30d1fabc";


    String url='https://accounts.spotify.com/authorize' +
        '?response_type=code' +
        '&client_id=' + myCliendId +
        '&scope=' + Uri.encodeComponent(scopes) +
        '&redirect_uri=' + Uri.encodeComponent(redirectUrl);

    return url;
  }
  static String getUrlWithState(String state){
    return AuthorizeConstants.getURL() +'&state='+Uri.encodeComponent(state);
  }
}

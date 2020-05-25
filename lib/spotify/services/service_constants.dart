class SpotifyServiceConstants {

  static const String URL_BASE = "https://api.spotify.com/v1";

  static const String CURRENT_PROFILE = URL_BASE+ "/me";
  static const String LIST_OF_CURRENT_USER_PLAYLIST = URL_BASE+ "/me/playlists";
  static String GET_PLAYLIST_COVER_IMAGE (String playlistId)=>URL_BASE+ "/playlists/$playlistId/images";
  static String GET_A_PLAYLIST(String playlistId)=>URL_BASE+ "/playlists/$playlistId";
  static String GET_PLAYLIST_ITEMS(String playlistId)=>URL_BASE+ "/playlists/$playlistId/tracks";

  static const String GET_TRACKS_SAVED = URL_BASE+ "/me/tracks";
  // user-read-recently-played scope
  static const String GET_RECENTLY_PLAYED=URL_BASE+ "/me/player/recently-played";
}

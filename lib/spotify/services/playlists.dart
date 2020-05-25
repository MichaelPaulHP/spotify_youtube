import 'package:loginfirebaseapp/spotify/services/exceptions.dart';
import 'package:loginfirebaseapp/spotify/services/service_constants.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:loginfirebaseapp/spotify/tdo/track.dart';

class Playlists{

  static Future<List<Playlist>>  getMyPlayLists(String accessToken)async {
    try{
      Map<String, String> header = {"Authorization": "Bearer " + accessToken};
      http.Response res=await  http.get(SpotifyServiceConstants.LIST_OF_CURRENT_USER_PLAYLIST,headers:header );
      if(res.statusCode==200){
        List<Playlist> playlists=List<Playlist>();

        var json = convert.jsonDecode(res.body);
        List<dynamic> items=json["items"];
        items.forEach((element) {

          Playlist playlist =Playlist.fromJson(element);

          playlists.add(playlist);
        });
        return playlists;
      }
      if(res.statusCode==401)
        throw AccessTokenExpired();
      throw Exception(res.body);

    }catch(e){
      throw e;
    }
  }

  static Future<List<Track>> getMyRecentlyPlayed(String accessToken)async {
    try{
      Map<String, String> header = {"Authorization": "Bearer " + accessToken};
      http.Response res=await  http.get(SpotifyServiceConstants.GET_RECENTLY_PLAYED,headers:header );

      if(res.statusCode==200){
        List<Track> tracks=List<Track>();

        var json = convert.jsonDecode(res.body);
        List<dynamic> items=json["items"];

        items.forEach((element) {
          Track track =Track.fromJson(element["track"]);
          tracks.add(track);
        });
        return tracks;
      }

      if(res.statusCode==401)
        throw AccessTokenExpired();
      throw Exception(res.body);

    }catch(e){
      throw e;
    }
  }

  static Future<List<Track>> getMyTracksSaved(String accessToken)async{

    try{

      Map<String, String> header = {"Authorization": "Bearer " + accessToken};
      http.Response res= await  http.get(SpotifyServiceConstants.GET_TRACKS_SAVED,headers:header );

      if(res.statusCode==200){
        List<Track> tracks=List<Track>();

        var json = convert.jsonDecode(res.body);
        List<dynamic> items=json["items"];

        items.forEach((element) {
          Track track =Track.fromJson(element["track"]);
          tracks.add(track);
        });
        return tracks;
      }

      if(res.statusCode==401)
        throw AccessTokenExpired();
      throw Exception(res.body);

    }catch(e){
      throw e;
    }
  }

  static Future<List<Track>> getTracksFromPlaylist(String playlistId,String accessToken)async{

    try{

      Map<String, String> header = {"Authorization": "Bearer " + accessToken};
      http.Response res= await  http.get(SpotifyServiceConstants.GET_PLAYLIST_ITEMS(playlistId),headers:header );

      if(res.statusCode==200){
        List<Track> tracks=List<Track>();

        var json = convert.jsonDecode(res.body);
        List<dynamic> items=json["items"];

        items.forEach((element) {
          Track track =Track.fromJson(element["track"]);
          tracks.add(track);
        });
        return tracks;
      }

      if(res.statusCode==401)
        throw AccessTokenExpired();
      throw Exception(res.body);

    }catch(e){
      throw e;
    }
  }
}
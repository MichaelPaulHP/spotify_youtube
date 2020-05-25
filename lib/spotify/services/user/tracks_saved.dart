import 'package:loginfirebaseapp/spotify/services/service_constants.dart';
import 'package:loginfirebaseapp/spotify/tdo/track.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TracksSaved{

  static Future<List<Track>> getMyTracksSaved(String accessToken)async{
      try{
        Map<String, String> header = {"Authorization": "Bearer " + accessToken};
        http.Response res = await http.get(SpotifyServiceConstants.GET_TRACKS_SAVED,
            headers: header);
        if(res.statusCode==200){
          var json = convert.jsonDecode(res.body);
          List<dynamic> items =json["items"];
          List<Track> tracks=List<Track>();
          items.forEach((element) {
            tracks.add(Track.fromJson(element));
          });
          return tracks;
        }
        throw Exception("status: ${res.statusCode}  ${res.body}");
      }catch(e){
        throw e;
      }
  }
}
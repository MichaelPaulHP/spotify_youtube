import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:loginfirebaseapp/youtube/model/video.dart';
import 'package:loginfirebaseapp/youtube/services/constants.dart';


class YoutubeRepository{

  static Future<List<Video>> searchVideos(String query) async {
    try{
      String urlRaw=YouTubeConstants.SEARCH_VIDEOS+"&q=$query";
      final urlEncoded = Uri.encodeFull(urlRaw);
      http.Response res=await  http.get(urlEncoded);
      if(res.statusCode==200){
        List<Video> videos = List<Video>();
        var json = convert.jsonDecode(res.body);
        List<dynamic> items=json["items"];
        items.forEach((element) {
          Video video= Video.fromJson(element);
          videos.add(video);

        });
        return videos;
      }
      throw Exception(res.body);


    }catch(e){
      throw e;
    }

  }

}
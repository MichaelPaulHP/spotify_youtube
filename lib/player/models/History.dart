import 'package:loginfirebaseapp/youtube/model/video.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History {
  List<Video> _history=List<Video>();
  List<String> _videosId=List<String>();

  void addVideoPlayed(Video video){

    if(!this._history.contains(video)){
      this._history.add(video);
      _videosId.add(video.toString());
      saveVideosId();
    }
  }

  int getLength(){
    return this._history.length;
  }
  List<Video> getVideos(){
    return _history;
  }
  Future<void> saveVideosId()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("MyHistory", _videosId);
  }
  Future<void> addVideosFromPrefs()async{
    List<Video> videos= await _getVideosFromPrefs();
    videos.forEach((element) {
      _history.add(element);
    });
  }
  Future<List<Video>> _getVideosFromPrefs()async{
    final prefs = await SharedPreferences.getInstance();
    List<String> videosString=prefs.getStringList("MyHistory");
    List<Video> videos = List<Video>();
    if(videosString==null) return videos;
    videosString.forEach((element) {
      Video video= _getVideoFromString(element);
      if(video!=null)
        videos.add(video);
    });
    return videos;
  }

  Video _getVideoFromString(String videoString){
    try{
      List<String> videos= videoString.split("|");
      String id=videos.elementAt(0);
      String title=videos.elementAt(1);
      String thumbnail=videos.elementAt(2);
      return Video(id: id,title: title,thumbnail: thumbnail);
    }catch(e){
      return null;
    }

  }
}
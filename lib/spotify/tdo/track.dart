class Track{
  final String album;
  final String artists;
  final String href;
  final String id;
  final String name;
  final String uri;
  final String image;


  Track({this.album, this.artists, this.href, this.id, this.name, this.uri,this.image});

  static Track fromJson(Map<String,dynamic> json){
    return Track(
      album: json["album"]["name"]?? "",
      artists: _getArtist( json["artists"]),
      href: json["href"] as String ,
      id: json["id"] as String ,
      name: json["name"] as String ,
        uri: json["uri"] as String ,
    );
  }
  static String _getArtist(List<dynamic> artists){
    String arts="";
    artists.forEach((element) {
      arts=arts+element["name"]+",";
    });
    return arts;
  }
}
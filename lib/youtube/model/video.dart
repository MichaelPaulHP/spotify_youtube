class Video {
  final String id;
  final String title;
  final String thumbnail;
  final String channelTitle;

  Video({this.id,this.title, this.thumbnail, this.channelTitle});

  static Video fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"]["videoId"] as String,
      title: json["snippet"]["title"] as String,
      thumbnail: json["snippet"]["thumbnails"]["medium"]["url"] as String,
      channelTitle: json["snippet"]["channelTitle"] as String,
    );
  }
}
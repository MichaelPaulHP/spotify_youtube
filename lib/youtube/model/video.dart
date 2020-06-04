import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String id;
  final String title;
  final String thumbnail;
  final String channelTitle;

  Video({this.id,this.title, this.thumbnail, this.channelTitle});

  static Video fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"]["videoId"] as String,
      title: json["snippet"]["title"] as String,
      thumbnail: json["snippet"]["thumbnails"]["default"]["url"] as String,
      channelTitle: json["snippet"]["channelTitle"] as String,
    );
  }

  @override
  List<Object> get props =>[id,title,thumbnail,channelTitle];

  @override
  String toString() {
    return "$id|$title|$thumbnail";
  }
}
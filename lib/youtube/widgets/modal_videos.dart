import 'package:flutter/material.dart';
import 'package:loginfirebaseapp/youtube/model/video.dart';
import 'package:loginfirebaseapp/youtube/widgets/video_card.dart';

class ListViewVideos extends StatelessWidget {
  final List<Video> _videos;

  ListViewVideos({List<Video> videos}) : _videos = videos;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Center(
        child: _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return VideoCard(video: _videos.elementAt(index));
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 1,
            width: 10,
          );
        },
        itemCount: _videos.length);
  }
}

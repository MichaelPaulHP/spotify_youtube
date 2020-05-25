import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:loginfirebaseapp/spotify/widgets/playlist_detail.dart';
import 'package:lottie/lottie.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

const double _WIDTH = 130;
const double _HEIGHT = 150;

class PlayListCard extends StatelessWidget {
  final Playlist _playlist;

  PlayListCard({@required Playlist playlist}) : _playlist = playlist;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => _onTap(context),
      child: Container(
          height: _HEIGHT,
          width: _WIDTH,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FadeInImage(
                height: _HEIGHT - 25,
                width: _WIDTH,
                placeholder:AssetImage("assets/gifs/loading_line.gif"),
                    //AssetImage("assets/images/spotifyLogoTransparent.png"),
                image: CachedNetworkImageProvider(_playlist.imagesUrls[0]),
                fit: BoxFit.cover,
              ),
              Center(
                child: Text(_playlist.name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //color: Colors.white,
                      fontSize: 15.0,
                    )),
              )
            ],
          )),
    );
  }
  Widget _buildLottiePlaceholder(){
    return Lottie.asset(
      'assets/LottieLogo1.json',
      width: 200,
      height: 200,
      fit: BoxFit.fill,
    );
  }



  void goUri() async {
    String url = _playlist.uri;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showModal() {}

  void _onTap(context) async {


    PaletteGenerator palette =
        await _generatePalette(_playlist.imagesUrls[0]);


    Navigator.push(
        context,
        MaterialPageRoute(builder: (c) {

      PlaylistDetail screen = PlaylistDetail(
        playlist: _playlist,
        paletteGenerator: palette,

        ///playerBloc: BlocProvider.of<PlayerBloc>(context),
      );
      return BlocProvider.value(
        value: BlocProvider.of<PlayerBloc>(context),
        child: screen,
      );
    }));

  }

  Future<PaletteGenerator> _generatePalette(String imageUrl) async {
    PaletteGenerator _paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            CachedNetworkImageProvider(imageUrl),
            size: Size(130, 150),
            maximumColorCount: 5);
    return _paletteGenerator;
  }
}

class PlaylistCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    scaffoldBackgroundColor = scaffoldBackgroundColor.withOpacity(0.1);

    Widget card = Container(
        height: _HEIGHT,
        width: _WIDTH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: _HEIGHT - 40,
              width: _WIDTH,
              color: scaffoldBackgroundColor,
            ),
            Center(
              child: Container(
                  width: (2 * _WIDTH) / 3, color: scaffoldBackgroundColor),
            )
          ],
        ));

    return Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        child: card,
        baseColor: Colors.black38,
        highlightColor: Colors.black87);
  }
}

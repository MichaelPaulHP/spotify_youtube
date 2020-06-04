import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/screens/nav/navigation_bloc.dart';
import 'package:loginfirebaseapp/spotify/playlist_bloc/playlist_bloc.dart';
import 'package:loginfirebaseapp/spotify/playlist_bloc/playlist_event.dart';
import 'package:loginfirebaseapp/spotify/playlist_bloc/playlist_state.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:loginfirebaseapp/spotify/widgets/SpotifyButton.dart';
import 'package:loginfirebaseapp/spotify/widgets/track_card.dart';
import 'package:loginfirebaseapp/youtube/widgets/modal_videos.dart';
import 'package:lottie/lottie.dart';
import 'package:palette_generator/palette_generator.dart';

class PlaylistDetail extends StatelessWidget  {
  final Playlist _playlist;
  final PaletteGenerator _palette;
  //final PlayerBloc _playerBloc;
  final double heightStatusBar=30;
  final double heightImage=90;
  PlaylistDetail({Playlist playlist,PaletteGenerator paletteGenerator})
  : _playlist=playlist,
        _palette=paletteGenerator
  ;
  /*
  * MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<PlayerBloc>.value(value: _playerBloc),
      ],
      child:
  * */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()=>goToHomeBool(context),
      child: Scaffold(


        body: CustomScrollView(

          slivers: <Widget>[
            /*SliverAppBar(
              elevation: 0,
              pinned: true,
              actions: <Widget>[
                closeIconButton(context)
              ],
              title: Text(_playlist.name),
              backgroundColor: _palette.colors.elementAt(0),
            ),*/
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverDelegate(
                expandedHeight: heightImage+heightStatusBar,
                child: _buildHeaderWithCove(context),
              ),
            ),
            SliverPersistentHeader(
              delegate: CustomSliverDelegate(
                expandedHeight: 80,
                child: header(context),
              ),
            ),

            listOfTrack(),



          ],



        ),
      ),
    );


  }
  void goToHome(context){
    BlocProvider.of<NavigationBloc>(context).add(NavGoHome());
  }
  Future<bool> goToHomeBool(context) async{
    BlocProvider.of<NavigationBloc>(context).add(NavGoHome());
    return false;
  }
  Widget listOfTrack(){

    return BlocProvider<PlaylistBloc>(
      create: (BuildContext context) => PlaylistBloc(_playlist)..add(PlaylistStarted()),
      child:Container(
        child: BlocBuilder<PlaylistBloc, PlaylistState>(

            builder: (BuildContext context,PlaylistState state) {
              if(state is PlaylistIsLoading){
                return SliverFillRemaining(
                  child:  Center(
                    child: Lottie.asset(
                      'assets/lottie/1446-bikingiscool.json',
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }
              if(state is PlaylistLoaded){
                return sliverListOfTracks(state);
              }

              if( state is PlaylistNotLoaded ){
                return SliverFillRemaining(
                  child: Text(state.error),
                );
              }

              if( state is PlaylistTrackNotLoaded){
                return SliverFillRemaining(
                  child: Text(state.error),
                );
              }

              return SliverFillRemaining(
                child: Text("nothing"),
              );
            }
        ),
      )
    );
  }
  Widget _buildHeaderWithCove(context){

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_palette.colors.elementAt(0), Colors.transparent])),
      child:SizedBox(
        height: heightImage+heightStatusBar,
        child: Stack(
          children: <Widget>[
            Positioned(
              top:heightStatusBar ,
              right: 25,
              child: closeIconButton(context),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: FadeInImage(
                  height: heightImage,
                  width: 80,
                  placeholder:  AssetImage("assets/images/spotifyLogoTransparent.png"),
                  image: CachedNetworkImageProvider(_playlist.imagesUrls[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),

          ],
        ) ,
      )
    );

  }
  Widget header(context){
    return Container(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_playlist.name),
          Text(_playlist.description),
          SpotifyButton(_playlist.uri)

        ],
      ),
    );
  }

  Widget listViewOfTracks(PlaylistLoaded state){
    return ListView.separated(
        itemBuilder: (context,index){
          return TrackCard( track: state.tracks.elementAt(index));
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
            width: 20,
          );
        },
        itemCount: state.tracks.length);
  }
  Widget sliverListOfTracks(PlaylistLoaded state){

    SliverChildBuilderDelegate ss= SliverChildBuilderDelegate(
          (context, index) => TrackCard( track: state.tracks.elementAt(index)),
      childCount:  state.tracks.length,
    );
    return SliverList(
      delegate:ss
    );
  }


  Widget closeIconButton(context){
    return IconButton(
        icon: Icon(
          Icons.close,
          size: 35,
        ),
        onPressed: () {
          goToHome(context);
        },
      );
    
  }
}
class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Widget child;

  CustomSliverDelegate({
    @required this.expandedHeight,
    @required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
class MySliverChildBuilderDelegate extends SliverChildBuilderDelegate{
  MySliverChildBuilderDelegate(builder) : super(builder);

}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/player/bloc/player_bloc.dart';
import 'package:loginfirebaseapp/spotify/playlist_bloc/playlist_bloc.dart';
import 'package:loginfirebaseapp/spotify/playlist_bloc/playlist_event.dart';
import 'package:loginfirebaseapp/spotify/playlist_bloc/playlist_state.dart';
import 'package:loginfirebaseapp/spotify/tdo/playlist.dart';
import 'package:loginfirebaseapp/spotify/widgets/track_card.dart';
import 'package:loginfirebaseapp/youtube/widgets/modal_videos.dart';
import 'package:palette_generator/palette_generator.dart';

class PlaylistDetail extends StatelessWidget  {
  final Playlist _playlist;
  final PaletteGenerator _palette;
  //final PlayerBloc _playerBloc;

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
    return Container(
      height: size.height-60,
      child: Scaffold(


        body: CustomScrollView(

          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              pinned: true,

            ),

            SliverPersistentHeader(
              delegate: CustomSliverDelegate(
                expandedHeight: (size.height * .4) - kToolbarHeight,
                child: header(),
              ),
            ),
            listOfTrack(),



          ],



        ),
      ),
    );


  }


  Widget listOfTrack(){

    return BlocProvider<PlaylistBloc>(
      create: (BuildContext context) => PlaylistBloc(_playlist)..add(PlaylistStarted()),
      child:BlocListener<PlaylistBloc, PlaylistState>(
        listener: (BuildContext context,PlaylistState state) {
          if(state is PlaylistTrackLoading){
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Lloading'), Icon(Icons.language)],
                  ),
                  backgroundColor: Colors.yellow,
                ),
              );
          }
          if(state is PlaylistTrackLoaded){
            showModalBottomSheet(
                context: context,
                builder: (context){
                  return ListViewVideos(videos: state.videos);
                }
            );
          }
        },
        child: Container(
          child: BlocBuilder<PlaylistBloc, PlaylistState>(
              condition:(previoSate,state){
                if(state is PlaylistTrackLoading|| state is PlaylistTrackLoaded){
                  return false;
                }
                return true;
              },
              builder: (BuildContext context,PlaylistState state) {
                if(state is PlaylistIsLoading){
                  return SliverFillRemaining(
                    child: Text("loading"),
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
        ),
      )
    );
  }

  Widget header(){
    return Container(
      height: 120,

      child: Row(
        mainAxisAlignment:MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.center ,
        children: <Widget>[

          FadeInImage(
            height: 90,
            width: 80,
            placeholder:  AssetImage("assets/images/spotifyLogoTransparent.png"),
            image: CachedNetworkImageProvider(_playlist.imagesUrls[0]),
          ),

          Container(
            height: 120,
            width: 100,
            child: ListView.builder (
                scrollDirection:  Axis.horizontal,
                itemCount: _palette.colors.length,
                itemBuilder: (context,index){
                  return Container(
                      height: 100,
                      width: 100,
                      color:_palette.colors.elementAt(index)
                  );
                }),
          )

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
      // La función builder devuelve un ListTile con un título que
      // muestra el índice del elemento actual
          (context, index) => TrackCard( track: state.tracks.elementAt(index)),
      // Construye 1000 ListTiles
      childCount:  state.tracks.length,
    );
    return SliverList(
      delegate:ss
    );
  }


  Widget closeIcon(context){
    return Positioned(
      top: 60,
      right: 20,
      child: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
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
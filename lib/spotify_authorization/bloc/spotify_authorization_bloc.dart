import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginfirebaseapp/spotify_authorization/repository/code_repository.dart';
import 'package:loginfirebaseapp/spotify_authorization/repository/observer_code.dart';
import 'package:loginfirebaseapp/spotify_authorization/tdo/init_credential.dart';

part 'spotify_athorization_event.dart';
part 'spotify_authorization_state.dart';



class SpotifyAuthorizationBloc
    extends Bloc<SpotifyAuthorizationEvent, SpotifyAuthorizationState> {

  @override
  SpotifyAuthorizationState get initialState {
    return SpotifyAuthorizationIsUndefined();
  }



  @override
  Stream<SpotifyAuthorizationState> mapEventToState(
      SpotifyAuthorizationEvent event) async* {
    if( event is SpotifyAuthorizationChecked){
      yield*_mapSpotifyAuthorizationChecked();

    }
    if (event is SpotifyAuthorizationStarted) {
      yield*_mapSpotifyAuthorizationStarted(event.userId);
    }
  }

  Stream<SpotifyAuthorizationState> _mapSpotifyAuthorizationChecked() async* {

    final String  code=await CodeRepository.getCode();
    print("CODEE");
    print(code);
    if(code==null || code.isEmpty){
      yield SpotifyAuthorizationIsDenied();
    }
    else{
      yield SpotifyAuthorizationIsSuccess();
    }
  }

  Stream<SpotifyAuthorizationState> _mapSpotifyAuthorizationStarted(String userId) async* {

    // initialize listening of code
    yield SpotifyAuthorizationIsInProgress();

    ObserverCode observerCode = ObserverCode(userId: userId);
    Stream<DocumentSnapshot> stream =observerCode.getStreamOfDocument();

    await for (DocumentSnapshot documentSnapshot in stream ){

      if(documentSnapshot.exists){
        InitCredential credential = InitCredential.fromJson(documentSnapshot.data);
        print(credential.toString());
        if(credential.hasError()){
          yield SpotifyAuthorizationIsDenied();
        }
        if(credential.hasCode()){
          await CodeRepository.saveCode(credential.code);
          yield SpotifyAuthorizationIsSuccess();

          break;
        }
      }
      print("listinig Stream de FIrestone");
    }

    await observerCode.delete();
    print("EEEEEEEEEEEEEEnd Stream de FIrestone");
  }







}

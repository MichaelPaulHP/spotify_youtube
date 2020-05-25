import 'package:cloud_firestore/cloud_firestore.dart';

class ObserverCode{

  final Firestore _firestore;
  static const String COLLECTION = "spotifyAuthorization";
  final String _idUser;

  ObserverCode(
      {String userId})
      : this._firestore = Firestore.instance,
        this._idUser=userId;

  Stream<DocumentSnapshot> getStreamOfDocument() async* {
    //final dataRef = _firestore.collection(COLLECTION).document(_idUser);
    yield* this._firestore.collection(COLLECTION).document(_idUser).snapshots();

  }
  Future<void> delete() async{
    try{
      await this._firestore.collection(COLLECTION).document(_idUser).delete();
      print("DELETED");
    }catch(e){
      print(e.toString());
    }

  }
}
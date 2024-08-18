
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/data/vos/song_vo.dart';
import 'package:music_app/network/data_agent/favourite_data_agent.dart';

class FavouriteDataAgentImpl extends FavouriteDataAgent{
  FavouriteDataAgentImpl._();
  static final FavouriteDataAgentImpl _singleton = FavouriteDataAgentImpl._();
  factory FavouriteDataAgentImpl()=>_singleton;
  final CollectionReference _itemCollection = FirebaseFirestore.instance.collection('favourite_songs');

  @override
  Future deleteFromFavourite(String id) => _itemCollection.doc(id).delete();

  @override
  Stream<List<SongVO>?> getFavouriteListStream() =>_itemCollection.snapshots()
      .map((querySnapShot){
        return querySnapShot.docs.map((document) => SongVO.fromJson(document.data() as Map<String,dynamic>)).toList();
  } );

  @override
  Future saveToFavourite(SongVO songVO) => _itemCollection.doc(songVO.id).set(songVO.toJson());
  
  
}
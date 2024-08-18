
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/data/vos/song_vo.dart';
import 'package:music_app/network/data_agent/song_data_agent.dart';

class SongDataAgentImpl extends SongDataAgent{
  SongDataAgentImpl._();
  static final SongDataAgentImpl _singleton = SongDataAgentImpl._();
  factory SongDataAgentImpl()=>_singleton;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<SongVO>?> getSongList() {
    // TODO: implement getSongList
    throw UnimplementedError();
  }
  
  

  @override
  Stream<List<SongVO>?> getSongListStream() =>_firebaseFirestore.collection('songs')
      .snapshots()
      .map((event) {
        return event.docs.map((document){
          return SongVO.fromJson(document.data());
        }).toList();
  });

  @override
  Future<SongVO?> getSongListById(String id)async {
    return _firebaseFirestore.collection('songs').doc(id)
        .get().then((value) {
          return SongVO.fromJson(Map<String,dynamic>.from(value.data() as Map));
    });
  }
}
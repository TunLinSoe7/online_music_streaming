
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/data/vos/play_list_vo.dart';
import 'package:music_app/network/data_agent/play_list_data_agent.dart';

class PlayListDataAgentImpl extends PlayListDataAgent{
  PlayListDataAgentImpl._();
  static final PlayListDataAgentImpl _singleton = PlayListDataAgentImpl._();
  factory PlayListDataAgentImpl ()=>_singleton;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> createPlayList(PlaylistVO playlistVO) =>_firebaseFirestore.collection('playlists')
      .doc(playlistVO.id).set(playlistVO.toJson());
  @override
  Stream<List<PlaylistVO>?> getPlayList() =>_firebaseFirestore.collection('playlists')
      .snapshots()
      .map((event) {
        return event.docs.map((document) => PlaylistVO.fromJson(document.data())).toList();
  });

}
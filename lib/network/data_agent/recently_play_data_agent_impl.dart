import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/data/vos/song_vo.dart';
import 'package:music_app/network/data_agent/recently_play_data_agent.dart';

class RecentlyPlayDataAgentImpl extends RecentlyPlayDataAgent{
  RecentlyPlayDataAgentImpl._();
  static final RecentlyPlayDataAgentImpl _singleton = RecentlyPlayDataAgentImpl._();
  factory RecentlyPlayDataAgentImpl()=>_singleton;

  final CollectionReference _itemCollection = FirebaseFirestore.instance.collection('recently_songs');

  @override
  Stream<List<SongVO>?> getRecentlySongList() =>_itemCollection.
      orderBy('created_at',descending: true).
  snapshots()
      .map((event){
        return event.docs.map((document) {
          return SongVO.fromJson(document.data() as Map<String,dynamic>);
        }).toList();
  });
  @override
  Future<void> saveRecentlySong(SongVO songVO) async {
    if (songVO.id == null) {
      // Add new song if ID is not provided
      await _itemCollection.add({
        ...songVO.toJson(),
        'created_at': FieldValue.serverTimestamp(), // Set the timestamp
      });
    } else {
      // Update existing song if ID is provided
      await _itemCollection.doc(songVO.id).set({
        ...songVO.toJson(),
        'created_at': FieldValue.serverTimestamp(), // Update the timestamp
      });
    }
  }
}
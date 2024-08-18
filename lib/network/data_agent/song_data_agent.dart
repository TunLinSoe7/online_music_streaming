import 'package:music_app/data/vos/song_vo.dart';

abstract class SongDataAgent{
  Stream<List<SongVO>?> getSongListStream();
  Future<List<SongVO>?> getSongList();
  Future<SongVO?> getSongListById(String id);
}
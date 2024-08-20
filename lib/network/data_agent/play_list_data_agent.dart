import 'package:music_app/data/vos/play_list_vo.dart';

abstract class PlayListDataAgent {

  Future<void> createPlayList(PlaylistVO playlistVO);
  Stream<List<PlaylistVO>?> getPlayList();
}
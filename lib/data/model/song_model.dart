import 'package:music_app/data/vos/play_list_vo.dart';
import 'package:music_app/data/vos/song_vo.dart';

abstract class SongModel {
  Stream<List<SongVO>?> getSongListStream();

  Future<SongVO?> getSongListById(String id);

  /// Recently play
  Stream<List<SongVO>?> getRecentlySongListStream();

  Future saveRecentlySong(SongVO songVO);

  /// Favourites
  Stream<List<SongVO>?> getFavouriteListStream();
  Future saveToFavourite(SongVO songVO);
  Future deleteFromFavourite(String id);

  /// playlist
  Future<void> createPlayList(PlaylistVO playlistVO);
  Stream<List<PlaylistVO>?> getPlayList();

}
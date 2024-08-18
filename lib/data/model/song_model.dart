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

}
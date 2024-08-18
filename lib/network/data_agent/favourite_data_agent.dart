import 'package:music_app/data/vos/song_vo.dart';

abstract class FavouriteDataAgent{
  Stream<List<SongVO>?> getFavouriteListStream();
  Future saveToFavourite(SongVO songVO);
  Future deleteFromFavourite(String id);
}
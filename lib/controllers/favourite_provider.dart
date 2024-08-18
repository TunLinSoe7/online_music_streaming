import 'package:flutter/material.dart';
import '../data/model/song_model.dart';
import '../data/model/song_model_impl.dart';
import '../data/vos/song_vo.dart';

class FavouriteProvider extends ChangeNotifier{
  final SongModel _songModel = SongModelImpl();
  List<SongVO> _favouriteSongs= [];


  /// getters
  List<SongVO>? get favouriteSongs => _favouriteSongs;
FavouriteProvider(){
  _songModel.getFavouriteListStream().listen((event) {
    if(event != null){
      _favouriteSongs = event;
      notifyListeners();
    }
  });
}
  /// Toggle Favourite
  Future<void> toggleFavourite(SongVO songVO) async {
    if (isSongFavourite(songVO.id ?? '')) {
      await removeFromFavourite(songVO.id ?? '');
    } else {
      await saveToFavourite(songVO);
    }
    notifyListeners();
  }

  bool isSongFavourite(String id) {
    return _favouriteSongs.any((song) => song.id == id);
  }

bool isExist(SongVO songVO){
  final isExist = _favouriteSongs.contains(songVO);
  return isExist;
}

Future<void> saveToFavourite(SongVO songVO)async{
  try{
    notifyListeners();
    await _songModel.saveToFavourite(songVO);
    notifyListeners();
  }catch (e){
    notifyListeners();
  }
}

Future<void> removeFromFavourite(String id)async{
    await _songModel.deleteFromFavourite(id);
    notifyListeners();
}
}
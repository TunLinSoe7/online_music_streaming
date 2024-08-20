import 'package:music_app/data/model/song_model.dart';
import 'package:music_app/data/vos/play_list_vo.dart';
import 'package:music_app/data/vos/song_vo.dart';
import 'package:music_app/network/data_agent/favourite_data_agent_impl.dart';
import 'package:music_app/network/data_agent/play_list_data_agent.dart';
import 'package:music_app/network/data_agent/play_list_data_agent_impl.dart';
import 'package:music_app/network/data_agent/recently_play_data_agent.dart';
import 'package:music_app/network/data_agent/recently_play_data_agent_impl.dart';
import 'package:music_app/network/data_agent/song_data_agent.dart';
import 'package:music_app/network/data_agent/song_data_agent_impl.dart';
import '../../network/data_agent/favourite_data_agent.dart';

class SongModelImpl implements SongModel{
  SongModelImpl._();
  static final SongModelImpl _songModelImpl = SongModelImpl._();
  factory SongModelImpl()=>_songModelImpl;
  final SongDataAgent _songDataAgent = SongDataAgentImpl();
  final PlayListDataAgent _playListDataAgent = PlayListDataAgentImpl();
  final RecentlyPlayDataAgent _recentlyPlayDataAgent  = RecentlyPlayDataAgentImpl();
  final FavouriteDataAgent _favouriteDataAgent = FavouriteDataAgentImpl();
  @override
  Stream<List<SongVO>?> getSongListStream() =>_songDataAgent.getSongListStream();

  @override
  Future<SongVO?> getSongListById(String id) =>_songDataAgent.getSongListById(id);

  /// Recently Songs
  @override
  Stream<List<SongVO>?> getRecentlySongListStream()=>_recentlyPlayDataAgent.getRecentlySongList();

  @override
  Future saveRecentlySong(SongVO songVO) =>_recentlyPlayDataAgent.saveRecentlySong(songVO);

  /// Favourite Songs
  @override
  Future deleteFromFavourite(String id) => _favouriteDataAgent.deleteFromFavourite(id);

  @override
  Stream<List<SongVO>?> getFavouriteListStream() => _favouriteDataAgent.getFavouriteListStream();

  @override
  Future saveToFavourite(SongVO songVO) => _favouriteDataAgent.saveToFavourite(songVO);

  /// playlists
  @override
  Stream<List<PlaylistVO>?> getPlayList() =>_playListDataAgent.getPlayList();
  @override
  Future<void> createPlayList(PlaylistVO playlistVO) =>_playListDataAgent.createPlayList(playlistVO);
}
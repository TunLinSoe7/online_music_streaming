import '../../data/vos/song_vo.dart';

abstract class RecentlyPlayDataAgent{
 Stream<List<SongVO>?> getRecentlySongList();
 Future saveRecentlySong(SongVO songVO);
}
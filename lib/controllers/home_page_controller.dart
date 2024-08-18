import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../data/model/song_model.dart';
import '../data/model/song_model_impl.dart';
import '../data/vos/song_vo.dart';
import 'favourite_provider.dart';

class HomePageProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final SongModel _songModel = SongModelImpl();
  List<SongVO> _songs = [];
  List<SongVO> _recentlySongs = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  List<SongVO> _currentPlaylist = [];
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  LoopMode _loopMode = LoopMode.off;

  // Setters
  set setCurrentIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }


  // Getters
  List<SongVO>? get songs => _songs;
  int get currentIndex => _currentIndex;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  bool get isPlaying => _isPlaying;
  List<SongVO> get recentlySongs => _recentlySongs;
  LoopMode get getLoopMode =>_loopMode;



  HomePageProvider() {
    fetchSongs();
    fetchRecentlySongs();
    _setupListeners();
  }
  void setPlaylist(bool onlyFavorites, List<SongVO> favoriteSongs) {
    if (onlyFavorites) {
      _currentPlaylist = favoriteSongs;
    } else {
      _currentPlaylist = _songs;
    }
    notifyListeners();
  }
  void _setupListeners() {
    _audioPlayer.positionStream.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((duration) {
      _totalDuration = duration ?? Duration.zero;
      notifyListeners();
    });

    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      if (state.processingState == ProcessingState.completed) {
        if(_currentIndex == _songs.length-1  && _loopMode == LoopMode.off){
          _audioPlayer.stop();
          _currentPosition = Duration.zero;
          _audioPlayer.seek(Duration.zero);
          notifyListeners();
        }else{
          _audioPlayer.seekToNext();
          notifyListeners();
        }
        notifyListeners();
      }
    });

    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        _currentIndex = index;
        notifyListeners();
      }
    });
    _audioPlayer.setLoopMode(_loopMode);
  }

  Future<void> playSong(int index) async {
    if (_currentIndex == index && _isPlaying) {
      return;
    }
    _currentIndex = index;
    await _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: _currentPlaylist.map((song) {
          return AudioSource.uri(
            Uri.parse(song.fileUrl!),
            tag: MediaItem(
              id: song.id ?? '',
              title: song.title ?? '',
              artist: song.artist ?? '',
              artUri: Uri.parse(song.coverUrl ?? ''),
            ),
          );
        }).toList(),
      ),
      initialIndex: index,
      initialPosition: Duration.zero,
    );

    _audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseSong() {
    _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resumeSong() {
    _audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
    notifyListeners();
  }

  void togglePlayPause() {
    if (_isPlaying) {
      pauseSong();
    } else {
      resumeSong();
    }
  }

  void playNext() {
    if (_loopMode == LoopMode.all && _currentIndex == _songs.length - 1) {
     _audioPlayer.seekToNext();
    } else if (_currentIndex < _songs.length - 1) {
      _audioPlayer.seekToNext();
    }
  }
  void toggleLoopMode() {
    if (_loopMode == LoopMode.off) {
      _loopMode = LoopMode.one;
      notifyListeners();
    } else if (_loopMode == LoopMode.one) {
      _loopMode = LoopMode.all;
      notifyListeners();
    } else {
      _loopMode = LoopMode.off;
      notifyListeners();
    }
    _audioPlayer.setLoopMode(_loopMode);
    notifyListeners();
  }


  void playPrevious() {
    if (_loopMode == LoopMode.all && _currentIndex == 0) {
      _audioPlayer.seekToPrevious();
    } else if (_currentIndex > 0) {
      _audioPlayer.seekToPrevious();
    }
  }
  Future<void> loopMode()async{
    await _audioPlayer.setLoopMode(LoopMode.one);
    notifyListeners();
  }

  Future<void> fetchSongs() async {
    _songModel.getSongListStream().listen((event) {
      _songs = event ?? [];
      notifyListeners();
    });
  }

  Future<void> saveRecentlySong(SongVO songVO) async {
    await _songModel.saveRecentlySong(songVO);
    notifyListeners();
  }

  Future<void> fetchRecentlySongs() async {
    _songModel.getRecentlySongListStream().listen((event) {
      _recentlySongs = event ?? [];
      notifyListeners();
    });
  }
}

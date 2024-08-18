// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';
//
// class AudioPlayerHandler extends BaseAudioHandler {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   AudioPlayerHandler() {
//     _audioPlayer.playbackEventStream.listen((event) {
//       playbackState.add(playbackState.value.copyWith(
//         playing: _audioPlayer.playing,
//         updatePosition: _audioPlayer.position,
//         bufferedPosition: _audioPlayer.bufferedPosition,
//         speed: _audioPlayer.speed,
//         queueIndex: _audioPlayer.sequence?.indexOf(_audioPlayer.currentIndex ?? -1) ?? 0,
//       ));
//     });
//
//     _audioPlayer.durationStream.listen((duration) {
//       mediaItem.add(MediaItem(
//         id: _audioPlayer.audioSource.uri.toString(),
//         album: 'Album Name', // Update with actual album info
//         title: 'Title Name', // Update with actual title info
//         artist: 'Artist Name', // Update with actual artist info
//         duration: duration ?? Duration.zero,
//       ));
//     });
//   }
//
//   @override
//   Future<void> play() async {
//     await _audioPlayer.play();
//     super.play();
//   }
//
//   @override
//   Future<void> pause() async {
//     await _audioPlayer.pause();
//     super.pause();
//   }
//
//   @override
//   Future<void> stop() async {
//     await _audioPlayer.stop();
//     super.stop();
//   }
//
//   @override
//   Future<void> seek(Duration position) async {
//     await _audioPlayer.seek(position);
//     super.seek(position);
//   }
//
//   @override
//   Future<void> setAudioSource(AudioSource source, [int? index]) async {
//     await _audioPlayer.setAudioSource(source, initialIndex: index);
//     super.setAudioSource(source, index);
//   }
// }

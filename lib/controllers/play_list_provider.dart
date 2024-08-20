import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:music_app/data/model/song_model.dart';
import 'package:music_app/data/model/song_model_impl.dart';
import '../data/vos/play_list_vo.dart';
import '../data/vos/song_vo.dart';


class PlaylistProvider extends ChangeNotifier {
 final SongModel _songModel = SongModelImpl();
 List<PlaylistVO> playList = [];
 PlaylistProvider(){
   _songModel.getPlayList().listen((event) {
     if(event != null){
       playList = event;
       notifyListeners();
     }
   });
 }
 Future<void> createPlayList(PlaylistVO playlistVO)async{
   try{
     await _songModel.createPlayList(playlistVO);
   }catch (e){
     throw Exception('Failed to create play list===========>$e');
   }
 }

 Future<void> addSongToPlaylist(String playlistId, SongVO? song) async {
   if (song == null || song.id == null) {
     // If the song is null, do not proceed
     print('Cannot add null song');
     return;
   }

   // Fetch all playlists to check if the song exists in any playlist
   final playlists = await FirebaseFirestore.instance.collection('playlists').get();

   bool songExistsInAnyPlaylist = playlists.docs.any((doc) {
     final playlist = PlaylistVO.fromJson(doc.data());
     return playlist.songs?.any((existingSong) => existingSong.id == song.id) ?? false;
   });

   if (songExistsInAnyPlaylist) {
     print('Song already exists in another playlist');
     return;
   }

   final playlistDoc = FirebaseFirestore.instance.collection('playlists').doc(playlistId);
   final playlistData = await playlistDoc.get();

   if (playlistData.exists) {
     PlaylistVO playlist = PlaylistVO.fromJson(playlistData.data()!);

     // Add the song to the playlist if it does not exist
     final existingSongs = playlist.songs ?? [];
     existingSongs.add(song);
     await playlistDoc.update({
       'songs': existingSongs.map((song) => song.toJson()).toList()
     });
     notifyListeners();
   } else {
     print('Playlist does not exist');
   }
 }


}


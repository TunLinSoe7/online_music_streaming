
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/home_page_controller.dart';
import '../controllers/play_list_provider.dart';
import 'audio_play_page.dart';

class PlayListSongPage extends StatelessWidget {
  final String playListName;
  final int index;

  const PlayListSongPage({Key? key, required this.playListName,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playListName),
        backgroundColor: Colors.black,
      ),
      body: Consumer2<PlaylistProvider, HomePageProvider>(
        builder: (_, playlistProvider, homePageProvider, __) {
          final playlist = playlistProvider.playList[index];
          return ListView.builder(
            itemCount: playlist.songs?.length,
            itemBuilder: (context, index) {
              final song = playlist.songs?[index];
              return ListTile(
                title: Text(song?.title ?? ''),
                subtitle: Text(song?.artist ?? ''),
                trailing: const Icon(Icons.play_arrow),
                onTap: () {
                  homePageProvider.setPlaylist(playlist.songs!);
                  homePageProvider.playSong(index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AudioPlayPage(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}



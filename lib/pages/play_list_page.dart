import 'package:flutter/material.dart';
import 'package:music_app/data/vos/play_list_vo.dart';
import 'package:music_app/pages/play_list_song_page.dart';
import 'package:music_app/utils/constants/colors.dart';
import 'package:music_app/utils/helper_functions/helper_functions.dart';
import 'package:provider/provider.dart';
import '../controllers/play_list_provider.dart';
import '../data/vos/song_vo.dart';

class PlayListPage extends StatelessWidget {
  final SongVO song;

  const PlayListPage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: (){
          _showCreatePlaylistDialog(context, PlaylistProvider());
        },child: const Icon(Icons.add,color: Colors.white,),),
      backgroundColor: kBgColor ,
      body: Consumer<PlaylistProvider>(
        builder: (_, playlistProvider, __) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: playlistProvider.playList.length,
                  itemBuilder: (context, index) {
                    final provider = playlistProvider.playList[index];
                    return Container(
                      margin: const  EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kGreyColor
                      ),
                      child: ListTile(
                        title: Text('${provider.playlistName}',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: kPrimaryColor
                        ),),
                        subtitle: Text('${provider.songs?.length} songs',style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.grey
                        ),),
                        onTap: () {
                            playlistProvider.addSongToPlaylist(playlistProvider.playList[index].id ?? '', song);
                            navigateToScreen(PlayListSongPage(playListName: playlistProvider.playList[index].playlistName ?? '', index: index), context);
                        },
                        trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  void _showCreatePlaylistDialog(BuildContext context, PlaylistProvider playlistProvider) {
    final _playlistNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Playlist'),
          content: TextField(
            controller: _playlistNameController,
            decoration: const InputDecoration(hintText: 'Enter playlist name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final playlistName = _playlistNameController.text.trim();

                if (playlistName.isNotEmpty) {
                  // Check if the playlist name already exists
                  final duplicatePlaylist = playlistProvider.playList.any((playlist) => playlist.playlistName?.toLowerCase() == playlistName.toLowerCase());

                  if (duplicatePlaylist) {
                    // Show warning dialog
                    _showWarningDialog(context);
                  } else {
                    // Create a new playlist if no duplicate is found
                    playlistProvider.createPlayList(
                      PlaylistVO(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        playlistName: playlistName,
                        createdAt: DateTime.now(),
                        songs: [],
                      ),
                    );
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text('A playlist with this name already exists. Please choose a different name.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

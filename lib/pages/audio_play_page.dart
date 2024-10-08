import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/controllers/favourite_provider.dart';
import 'package:music_app/data/vos/song_vo.dart';
import 'package:music_app/pages/library_page.dart';
import 'package:music_app/utils/helper_functions/helper_functions.dart';
import 'package:provider/provider.dart';
import '../controllers/home_page_controller.dart';

class AudioPlayPage extends StatelessWidget {
  const AudioPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<HomePageProvider,FavouriteProvider>(
        builder: (_, homePageProvider,favouriteProvider, __) {
          final songIndex = homePageProvider.currentIndex;
          final song = homePageProvider.currentPlayList!.isNotEmpty
              ? homePageProvider.currentPlayList![songIndex]
              : null;
          return Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: CachedNetworkImage(
                    imageUrl: '${song?.coverUrl}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: '${song?.coverUrl}',
                        child: CachedNetworkImage(
                          imageUrl: '${song?.coverUrl}',
                           width: 250,
                           height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(song?.title ?? '',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 25
                  ),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    child: ProgressBar(
                      progress: homePageProvider.currentPosition,
                      total: homePageProvider.totalDuration,
                      onSeek: (duration) {
                        homePageProvider.seek(duration);
                      },
                      progressBarColor: Colors.green,
                      baseBarColor: Colors.white,
                      thumbColor: Colors.transparent,
                      timeLabelTextStyle: const TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.shuffle,color: Colors.white,size: 30,)),
                      IconButton(onPressed: (){
                        homePageProvider.playPrevious();
                      }, icon: const Icon(Icons.skip_previous,color: Colors.white,size: 30,)),
                      IconButton(onPressed: (){
                        homePageProvider.togglePlayPause();
                      }, icon: Icon(homePageProvider.isPlaying?Icons.pause:Icons.play_arrow,color: Colors.white,size: 30,)),
                      IconButton(onPressed: (){
                        homePageProvider.playNext();
                      }, icon: const Icon(Icons.skip_next,color: Colors.white,size: 30,)),
                      IconButton(
                        onPressed: () {
                          homePageProvider.toggleLoopMode();
                        },
                        icon: Icon(
                          homePageProvider.getLoopMode == LoopMode.one
                              ? Icons.repeat_one
                              : homePageProvider.getLoopMode == LoopMode.all
                              ? Icons.repeat
                              : Icons.shuffle,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      /// icon for to add playlist or remove playlist
                      IconButton(onPressed: (){
                        navigateToScreen(LibraryPage(song: song ?? SongVO()), context);
                      }, icon: const Icon(Icons.playlist_add,color: Colors.white,)),
                    ],
                  ),
                ],

              ),
              Positioned(
                  top: 50,
                  left: 15,
                  child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios,color: Colors.white,))),
              Positioned(
                  top: 50,
                  right: 15,
                  child: InkWell(
                      onTap: (){
                        favouriteProvider.toggleFavourite(song ?? SongVO());
                      },
                      child: Icon(Icons.favorite,color: favouriteProvider.isSongFavourite(song?.id ?? '')?Colors.red:Colors.white,size: 30,))),
            ],
          );
        },
      ),
    );
  }
}

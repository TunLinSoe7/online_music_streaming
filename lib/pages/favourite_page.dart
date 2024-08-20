import 'package:flutter/material.dart';
import 'package:music_app/controllers/favourite_provider.dart';
import 'package:music_app/controllers/home_page_controller.dart';
import 'package:music_app/pages/audio_play_page.dart';
import 'package:music_app/utils/constants/colors.dart';
import 'package:music_app/utils/helper_functions/helper_functions.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<FavouriteProvider,HomePageProvider>(builder: (_,provider,homeProvider,__){
      return Scaffold(
        backgroundColor: kBgColor,
        body: Column(
          children: [
            Expanded(child: ListView.builder(
                itemCount: provider.favouriteSongs?.length,
                itemBuilder: (_,index){
                  final favorites = provider.favouriteSongs?[index];
                  return ListTile(
                    onTap: (){
                      homeProvider.setPlaylist(provider.favouriteSongs!);
                      homeProvider.playSong(index);
                      navigateToScreen(AudioPlayPage(), context);
                    },
                    leading: CircleAvatar(
                      backgroundColor: getRandomColor(),
                      child: Text(getFirstLetter(favorites?.title ?? ''),style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white
                      ),),
                    ),
                    title: Text("${favorites?.title}",style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: kPrimaryColor
                    ),),
                    subtitle: Text('${favorites?.artist}',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white
                    ),),
                    trailing: const Icon(Icons.more_vert_outlined,color: Colors.white,),
                  );
                }))

          ],
        ),
      );
    });
  }
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:music_app/controllers/home_page_controller.dart';
import 'package:music_app/data/vos/song_vo.dart';
import 'package:music_app/pages/audio_play_page.dart';
import 'package:music_app/utils/constants/colors.dart';
import 'package:music_app/utils/helper_functions/helper_functions.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: kBgColor,
        leading: Image.asset('assets/images/logo.png',fit: BoxFit.cover),
        title: Text('Music App',style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Colors.white
        ),),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(),
            HorizontalTitleWidget(title: 'Popular Playlist',),
            PopularPlaylistWidget(),
            HorizontalTitleWidget(title: 'Recently played'),
            RecentlyPlaylistWidget(),
          ],
        ),
      ),
    );
  }
}

class RecentlyPlaylistWidget extends StatelessWidget {
  const RecentlyPlaylistWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(builder: (_,provider,child){
      return SizedBox(
        child: provider.recentlySongs!=null || provider.recentlySongs!.isNotEmpty?ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.recentlySongs?.length,
            itemBuilder: (_,index){
              return SongListTileView(
                image: '${provider.recentlySongs[index].coverUrl}',
                title: '${provider.recentlySongs[index].title}',
                artistName: '${provider.recentlySongs[index].artist}',
                duration: '${provider.recentlySongs[index].duration}',
              );
            }):const Center(child: Text('No Recently Songs'),),
      );
    });
  }
}


class PopularPlaylistWidget extends StatelessWidget {
  const PopularPlaylistWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(builder: (_,provider,child){
      return SizedBox(height: 230,
        child: provider.songs!=null || provider.songs!.isNotEmpty?ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.songs?.length,
            itemBuilder: (_,index){
              return SongListItemView(
                width: 160,
                color: Colors.grey.shade200,
                tag: '${provider.songs?[index].coverUrl}',
                onTap: (){
                  provider.setPlaylist(provider.songs ?? []);
                  provider.playSong(index);
                  navigateToScreen( AudioPlayPage(), context);
                  provider.saveRecentlySong(provider.songs?[index] ?? SongVO());
                },
                imageUrl: '${provider.songs?[index].coverUrl}', title: '${provider.songs?[index].title}', artistName: '${provider.songs?[index].artist}',);
            }):const Center(child: CircularProgressIndicator(),),
      );
    });
  }
}

class SongListTileView extends StatelessWidget {
  const SongListTileView({
    super.key,
    required this.image,
    required this.title,
    required this.artistName,
    required this.duration,
  });

  final String image;
  final String title;
  final String artistName;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kGreyColor,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                Text(
                  artistName,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Iconsax.clock,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      duration,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor,
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}



class SongListItemView extends StatelessWidget {
  const SongListItemView({
    super.key, required this.imageUrl, required this.title, required this.artistName, required this.onTap, required this.tag,
    this.width = 150,this.height = 220,required this.color,
    this.imageWidth = 160,this.imageHeight = 150
  });
  final String imageUrl;
  final String title;
  final String artistName;
  final String tag;
  final double width;
  final double height;
  final double imageWidth;
  final double imageHeight;
  final Color color;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(5),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: kBgColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
              child: Hero(
                 tag: tag,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(imageUrl: imageUrl,fit: BoxFit.fill,width: imageWidth,height: imageHeight,placeholder: (_,url)=>Image.asset('assets/images/logo.png',fit: BoxFit.contain,),)))),
          const SizedBox(height: 10,),
          Expanded(child: Text(title,style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white
          ),maxLines: 1,)),
          Expanded(child: Text(artistName,style: Theme.of(context).textTheme.titleSmall,maxLines: 1,)),
        ],
      ),
    );
  }
}


class HorizontalTitleWidget extends StatelessWidget {
  const HorizontalTitleWidget({
    super.key, required this.title,
  });
 final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:  Text(title,style: Theme.of(context).textTheme.titleLarge!.copyWith(
        color: Colors.white
      ),),
      trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kGreyColor
      ),
      child: Row(
        children: [
          Icon(Icons.search,color: Colors.white,),
          const SizedBox(width: 10,),
          Text('Artist,songs,podcast',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white
          ),)
        ],
      ),
    );
  }
}

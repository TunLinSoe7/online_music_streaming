import 'package:flutter/material.dart';
import 'package:music_app/data/vos/song_vo.dart';
import 'package:music_app/pages/play_list_page.dart';
import 'package:music_app/pages/favourite_page.dart';
import 'package:music_app/utils/constants/colors.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key, required this.song});
  final SongVO song;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Library',style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.white
          ),),
          backgroundColor: kBgColor,
        ),
        backgroundColor: kBgColor,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kGreyColor,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorColor: kPrimaryColor,
                unselectedLabelColor: Colors.white,
                labelColor: kPrimaryColor,
                  tabs: const [
                    Tab(text: 'Favourites',),
                    Tab(text: 'PlayLists',),
                  ]),
            ),
             Expanded(
              child: TabBarView(children: [
                FavouritePage(),
                PlayListPage(song: song),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

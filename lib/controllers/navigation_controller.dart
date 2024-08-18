import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_app/pages/home_page.dart';
import 'package:music_app/pages/library_page.dart';
import 'package:music_app/pages/profile_page.dart';
import 'package:music_app/pages/view_all_pages.dart';

class NavigationController extends GetxController{
  Rx<int> currentIndex = 0.obs;
  void toggleIndex(index){
    currentIndex.value = index;
  }

  List<Widget> pages = [
    HomePage(),
    LibraryPage(),
    ProfilePage(),
  ];
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:music_app/controllers/navigation_controller.dart';
import 'package:music_app/utils/constants/colors.dart';

class BottomNavigationMenu extends StatelessWidget {
  const BottomNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          backgroundColor:  kNavigationColor,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.toggleIndex(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Iconsax.music_library_2), label: 'Library'),
            BottomNavigationBarItem(icon: Icon(Iconsax.profile_circle), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: controller.pages.toList(),
      )),
    );

  }
}
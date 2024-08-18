import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:music_app/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/utils/constants/colors.dart';
import 'package:music_app/utils/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar:AppBar(
        backgroundColor: kBgColor,
        leading: Image.asset('assets/images/logo.png',width: 50,height: 20,fit: BoxFit.cover,),
        title:Text('Your Profile',style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar( 
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset('assets/images/profile.png'),
                  ),
                ),
                const SizedBox(width: 15,),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John abram',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white
                    ),),
                    Text('John@gamil.com',style: TextStyle(
                      color: Colors.grey
                    ),)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15,),
            ProfileListTileWidget(iconData: Icons.person_outline,onTap: (){},title: 'Person',),
            ProfileListTileWidget(iconData: Icons.favorite_outline_outlined,onTap: (){},title: 'My wishlist',),
            ProfileListTileWidget(iconData: Iconsax.setting,onTap: (){},title: 'Settings',),
            ProfileListTileWidget(iconData: Icons.policy_outlined,onTap: (){},title: 'Privacy Policy',),
            ProfileListTileWidget(iconData: Iconsax.logout,onTap: (){},title: 'Log out',),
          ],
        ),
      ),
    );
  }
}

class ProfileListTileWidget extends StatelessWidget {
 const ProfileListTileWidget({
    super.key, required this.iconData, required this.onTap, required this.title, this.subtitle =  Icons.arrow_forward_ios,
  });
 final IconData iconData;
 final GestureTapCallback onTap;
 final String title;
 final IconData subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: HorizontalTitleWidget(title: title),
    );
  }
}

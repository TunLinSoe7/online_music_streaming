import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/controllers/favourite_provider.dart';
import 'package:music_app/controllers/home_page_controller.dart';
import 'package:music_app/firebase_options.dart';
import 'package:music_app/navigation_menu.dart';
import 'package:get/get.dart';
import 'package:music_app/utils/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(
      MultiProvider(
          providers: [
            //ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => HomePageProvider()),
            ChangeNotifierProvider(create: (_) => FavouriteProvider()),
          ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.roboto(
            textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          titleMedium: GoogleFonts.roboto(
            textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          titleSmall: GoogleFonts.roboto(
            textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey[600]),
          ),
          bodyLarge: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
          ),
          bodyMedium: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
          ),
          bodySmall: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 12.0, color: Colors.grey[500]),
          ),
        ),
      ),
      home: const BottomNavigationMenu(),
    );
  }
}

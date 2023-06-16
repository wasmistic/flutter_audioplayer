import 'package:audio_player_app/pages/playlistpage/playlist_page.dart';
import 'package:audio_player_app/pages/songpage/song_page.dart';
import 'package:audio_player_app/pages/welcomepage/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
      ),
    );
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder:(context, child){
          return GetMaterialApp(
            title: 'Flutter Chat UI',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(

            ),
            home: WelcomePage(),
            getPages: [
              GetPage(name: '/', page:()=>WelcomePage()),
              GetPage(name: '/playlist', page: ()=>PlaylistPage()),
              GetPage(name: '/song', page: ()=>SongPage())
            ],
          );
        });
  }
}



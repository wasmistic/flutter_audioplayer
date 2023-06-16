import 'package:audio_player_app/modal/playlist_modal.dart';
import 'package:audio_player_app/pages/playlistpage/playlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../commonwidgets/app_text.dart';
import '../../modal/song_modal.dart';
import '../songpage/song_page.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<Song> music = Song.generateSongs;
  List<Playlist> TrendPlay = Playlist.generatePlaylist();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 40.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800.withOpacity(0.8),
              Colors.deepPurple.shade200.withOpacity(0.8),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTop(),
              _buildTopText(),
              _buildSearchBox(),
              _buildTrendingText(),
              _buildTrendingMusic(),
              _buildPlayText(),
              _buildPlaylistMusic(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTop(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.w,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.grid_view_outlined, color: Colors.white,size: 30.sp,),

          CircleAvatar(
            radius: 20.sp,
            backgroundImage: AssetImage('assets/images/Mylogo.png'),
          )
        ],
      ),
    );
  }
  _buildTopText(){
    return Container(
      width:MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 10.h, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: 'Welcome',weight: FontWeight.w500, textsize: 18.sp, textcolor: Colors.white.withOpacity(0.7),),
          SizedBox(height: 6.h,),
          AppText(text:  'Enjoy your favorite music',weight: FontWeight.bold, textsize: 18.sp, textcolor: Colors.white,)
        ],
      ),
    );
  }
  _buildSearchBox(){
    return Container(
      width:MediaQuery.of(context).size.width,
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal:10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white
      ),
      child: Row(
        children: [
          Icon(Icons.search,color: Colors.grey.withOpacity(0.6),),
          SizedBox(width: 5.w,),
          AppText(text: 'Search', textcolor: Colors.grey.withOpacity(0.6), textsize: 16.sp, weight: FontWeight.w500)
        ],
      ),
    );
  }
  _buildTrendingText(){
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(text: 'Trending Music',weight: FontWeight.w500, textsize: 18.sp, textcolor: Colors.white.withOpacity(0.7),),
          AppText(text: 'View more',weight: FontWeight.w500, textsize: 18.sp, textcolor: Colors.white.withOpacity(0.7),)
        ],
      ),
    );
  }
  _buildPlayText(){
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h, bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(text: 'Playlist',weight: FontWeight.w500, textsize: 18.sp, textcolor: Colors.white.withOpacity(0.7),),
          AppText(text: 'View more',weight: FontWeight.w500, textsize: 18.sp, textcolor: Colors.white.withOpacity(0.7),)
        ],
      ),
    );
  }
  _buildTrendingMusic(){
    return Container(
      margin: EdgeInsets.only(left: 20.w),
      height: 220.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:music.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder:(_,index){
          return GestureDetector(
            onTap: ()=>Get.to(()=>SongPage(song:music[index])),
            child: _buildTrendMusic(music[index]),
          );
          }
      ),
    );
  }
  _buildTrendMusic(Song item){
    return Container(
      height: 210.h,
      width: 165.w,
      margin: EdgeInsets.only(right:10.w),
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(item.coverUrl)
        )
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10.h,
              left: 6.sp,
              child: Container(
                width: 150.w,
                height: 50.h,
                padding: EdgeInsets.only(left:8.w, right: 8.w,bottom: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8.r)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppText(text: item.title, textcolor: Colors.black, textsize:16.sp, weight:FontWeight.w700),
                        SizedBox(height:6.h,),
                        AppText(text: item.description, textcolor: Colors.white, textsize:12.sp, weight:FontWeight.normal)
                      ],
                    ),
                    Icon(Icons.play_circle_sharp,color: Colors.black,size:20.sp,),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
  
  _buildPlaylistMusic(){
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: TrendPlay.length,
        itemBuilder:(_,index){
          return GestureDetector(
            onTap: ()=>Get.to(()=>PlaylistPage(play: TrendPlay[index],)),
            child: _buildPlayMusic(TrendPlay[index]),
          );
        });
  }

  _buildPlayMusic(Playlist item){
    return Container(
      height: 75.h,
      margin: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
      padding: EdgeInsets.only(right: 20.w, left:20.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade800.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.network(item.imageUrl, width: 50.w, height: 50.h, fit: BoxFit.cover,),
              ),
              SizedBox(width: 15.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(text: item.title, textcolor: Colors.white, textsize:16.sp, weight:FontWeight.w700),
                  SizedBox(height:6.h,),
                  AppText(text: '${item.songs.length} songs', textcolor: Colors.white, textsize:12.sp, weight:FontWeight.normal)
                ],
              ),
            ],
          ),
          Icon(Icons.play_circle_sharp,color: Colors.white,size:20.sp,),
        ],
      ),
    );
  }
}

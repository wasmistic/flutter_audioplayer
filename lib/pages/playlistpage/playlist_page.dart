import 'package:audio_player_app/commonwidgets/app_text.dart';
import 'package:audio_player_app/modal/playlist_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../modal/playlist_modal.dart';
import '../../modal/song_modal.dart';
import 'package:get/get.dart';

class PlaylistPage extends StatefulWidget {
  final Playlist? play;
  const PlaylistPage({Key? key, this.play}) : super(key: key);

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  bool isPlay = false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 20.w,right:20.w, top: 50.h),
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 GestureDetector(
                   onTap: ()=>Get.back(),
                   child:  Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,),
                 ),
                  AppText(text: 'Playlists', textcolor: Colors.white, textsize:16.sp, weight:FontWeight.w500),
                  Icon(Icons.more_vert_sharp,color: Colors.white,),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220.h,
                margin: EdgeInsets.only(top:40.h,bottom: 20.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.play!.imageUrl)
                    )
                ),
              ),
              AppText(text: widget.play!.title, textcolor: Colors.white, textsize:22.sp, weight: FontWeight.w800),
              GestureDetector(
                onTap: (){
                  setState(() {
                    isPlay=!isPlay;
                  });
                },
                child: Container(
                  height: 50.h,
                  margin: EdgeInsets.only(top:20.h, bottom:20.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r)
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          left: isPlay ? 0 :MediaQuery.of(context).size.width * 0.439,
                          child: Container(
                            height: 50.h,
                            width: MediaQuery.of(context).size.width *0.45,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade400,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          )
                      ),
                      Row(
                        children: [
                          Expanded(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child:  AppText(text: 'Play', textcolor: isPlay ? Colors.white : Colors.deepPurple, textsize: 17.sp, weight: FontWeight.w600),
                                ),
                                SizedBox(width:10.w,),
                                Icon(Icons.play_circle_sharp,color: isPlay ? Colors.white : Colors.deepPurple,)
                              ],
                            ),
                          ),
                          Expanded(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child:  AppText(text: 'Shuffle', textcolor: isPlay ? Colors.deepPurple : Colors.white, textsize: 17.sp, weight: FontWeight.w600),
                                ),
                                SizedBox(width:10.w,),
                                Icon(Icons.shuffle,color:isPlay ? Colors.deepPurple : Colors.white,)
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 20.h),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.play!.songs.length,
                  itemBuilder:(_,index){
                    return _buildList(index, widget.play!.songs[index]);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildList(int index,Song play){
    return Container(
      height: 75.h,
      margin: EdgeInsets.only(bottom: 10.h,),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             AppText(text: '${index+1}', textcolor: Colors.white, textsize: 16.sp, weight: FontWeight.w500),
              SizedBox(width: 15.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText(text: play.title, textcolor: Colors.white, textsize:16.sp, weight:FontWeight.w700),
                  SizedBox(height:6.h,),
                  AppText(text: '${play.description} ⚬ 02:45', textcolor: Colors.white, textsize:12.sp, weight:FontWeight.normal)
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

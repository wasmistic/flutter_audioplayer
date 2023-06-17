import 'package:audio_player_app/commonwidgets/app_text.dart';
import 'package:audio_player_app/modal/song_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class SongPage extends StatefulWidget {
  final Song? song;
  const SongPage({Key? key, this.song}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  late AudioPlayer AdvancedPlayer;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  // final String path =
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat=false;
  Color color=Colors.white;
  bool mute = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdvancedPlayer = AudioPlayer();

    AdvancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration=d;
      });
    });
    AdvancedPlayer.onPositionChanged.listen((p) {
      _position=p;
    });


    AdvancedPlayer.setSourceAsset(widget.song!.url);
    AdvancedPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position=Duration(seconds: 0);
        if(isRepeat=true){
          isPlaying=true;
        }else{
          isPlaying=false;
          isRepeat=false;
        }

      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(widget.song!.coverUrl)
              )
            ),
          ),
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0),
              ],
              stops: const [
              0.0,
              0.4,
              0.6
              ]).createShader(rect);
              },
            blendMode: BlendMode.dstOut,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepPurple.shade200,
                      Colors.deepPurple.shade800,
                    ],
                  )
              ),
            ),
          ),
          Positioned(
              top: 40.h,
              left: 20.w,
              right: 20.w,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      if(isPlaying==true){
                        AdvancedPlayer.pause();
                        _position=Duration(seconds: 0);
                        setState(() {
                          isPlaying=false;
                        });
                      }
                      Get.back();
                      },
                    child:  Icon(Icons.arrow_back_ios,color: Colors.white,),
                  ),

                  Icon(Icons.more_vert, color:Colors.white,)
                ],
              ),
          ),
          Positioned(
            top: 370.h,
              left: 20.w,
              right: 20.w,
              child:Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(textcolor: Colors.white, weight: FontWeight.bold,textsize: 22.sp,text: widget.song!.title,),
                        SizedBox(height:10.h),
                        AppText(textcolor: Colors.white, weight: FontWeight.w500,textsize: 16.sp,text: widget.song!.description, maxline: 2,),
                        SizedBox(height: 30.h),
                      ],
                    ),
                    Icon(Icons.bookmark_add_outlined,color: Colors.white,)
                  ],
                ),
              )
          ),
          Positioned(
            left: 20.w,
              right: 20.w,
              bottom:100.h,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(text: _position.toString().split('.')[0], textcolor: Colors.white, textsize:16.sp, weight: FontWeight.normal),
                      slider(),
                      AppText(text: _duration.toString().split('.')[0], textcolor: Colors.white, textsize:16.sp, weight: FontWeight.normal),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.timer_outlined,color: Colors.white.withOpacity(0.6),),
                      GestureDetector(
                        onTap:(){
                          if(isRepeat==false){
                            AdvancedPlayer.setReleaseMode(ReleaseMode.loop);
                            setState(() {
                              isRepeat=true;
                              color=Colors.blue;
                            });
                          }else if(isRepeat==true){
                            AdvancedPlayer.setReleaseMode(ReleaseMode.release);
                            setState(() {
                              isRepeat=false;
                              color=Colors.white;
                            });
                          }
                        },
                        child:  Icon(Icons.repeat,color: color, size: 35.sp,),
                      ),
                      GestureDetector(
                        onTap:(){
                          AdvancedPlayer.setPlaybackRate(0.5);
                        },
                        child:  Icon(Icons.skip_previous,color: Colors.white, size: 35.sp,),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(isPlaying==false){
                            AdvancedPlayer.play(AssetSource(widget.song!.url));
                            setState(() {
                              isPlaying=true;
                            });
                          }else if(isPlaying==true){
                            AdvancedPlayer.pause();
                            setState(() {
                              isPlaying=false;
                            });
                          }
                        },
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Center(child: Icon(isPlaying==false ? Icons.play_arrow_sharp : Icons.pause,color: Colors.deepPurple.shade800, size: 30.sp,),),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          AdvancedPlayer.setPlaybackRate(1.5);
                        },
                        child:  Icon(  Icons.skip_next,color: Colors.white, size: 35.sp,),
                      ),
                     GestureDetector(
                       onTap:(){
                        setState(() {
                          mute=!mute;
                        });
                         if(mute==false){
                           AdvancedPlayer.setVolume(1.0);
                         }else if(mute==true){
                           AdvancedPlayer.setVolume(0);
                         }
                       },
                       child:  Icon(mute==false ? Icons.volume_up_sharp : Icons.volume_off_sharp,color: Colors.white,),
                     )
                    ],
                  )
                ],
              ),
          ),
          Positioned(
              left: 20.w,
              right: 20.w,
              bottom:20.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.settings,color: Colors.white, size: 35.sp,),
                  Icon(Icons.cloud_download,color: Colors.white, size: 35.sp,),
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.purple,
        inactiveColor: Colors.white,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });});
  }

  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    AdvancedPlayer.seek(newDuration);
  }
}

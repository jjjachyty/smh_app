import 'dart:async';
import 'dart:io';
import 'package:fijkplayer/fijkplayer.dart';

import 'package:flutter/material.dart';
import 'package:smh/common/init.dart';
import 'package:smh/common/utils.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/resources.dart';
import 'package:smh/models/watch_history.dart';

import 'fijkplayer_panle.dart';

class FijkPlayPage extends StatefulWidget {
  Video movie;
  VideoResources resources;
  FijkPlayer player;

  FijkPlayPage(this.movie, this.resources, this.player);
  @override
  _FijkPlayPageState createState() => _FijkPlayPageState();
}

class _FijkPlayPageState extends State<FijkPlayPage> {
  double _height = 300;
  // FijkPlayer player = FijkPlayer();
  int playEvent;
  @override
  void initState() {
    widget.player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    widget.player.setOption(FijkOption.formatCategory, "parse_cache_map", 1);
    widget.player.setOption(FijkOption.formatCategory, "auto_save_map", 1);

    widget.player.setOption(FijkOption.formatCategory, "cache_file_path",
        localPath + "/tmp/" + widget.player.id.toString());
    widget.player.setOption(FijkOption.formatCategory, "cache_map_path",
        localPath + "/tmp/" + widget.player.id.toString() + "_map");

    //mMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "cache_file_path",“/storage/emulated/0/1.tmp");每首歌的临时文件名自己根据自己需要生成就行了。
    //mMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "cache_map_path",“/storage/emulated/0/2.tmp"");//暂时不知道设置有什么用

  }

  @override
  void dispose() {
    // widget.player.removeListener(_fijkValueListener);

    // widget.player.release();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: GestureDetector(
        child: FijkView(
          fit: FijkFit.cover,
          color: Colors.black,
          // fsFit: FijkFit.fill,
          player: widget.player,
          panelBuilder: (player, playerData, context, size, rect) {
            return FijkPanelBuilder(player, playerData, context, size, rect);
          },
        ),
        onLongPress: () {
          widget.player.setSpeed(2.0);
        },
        onLongPressEnd: (e) {
          widget.player.setSpeed(1.0);
        },
        onHorizontalDragEnd: (e) async {
          print("primaryVelocity ${e.primaryVelocity}");
          var current = widget.player.currentPos.inMilliseconds;

          if (e.primaryVelocity > 0) {
            widget.player
                .seekTo(current + Duration(seconds: 30).inMilliseconds);
          } else {
            var to = current - Duration(seconds: 30).inMilliseconds;
            print("${current}----${to}---${current - to}");

            widget.player.seekTo(to);
          }
        },
      ),
    );
  }



  void _playInput() async {
    print(widget.resources.URL);
    // await widget.player.setDataSource(
    //   widget.resources.URL,
    //   autoPlay: true,
    //   showCover: true,
    // );

    await widget.player
        .setOption(FijkOption.hostCategory, "request-screen-on", 1);

    if (widget.movie.ID == null || widget.movie.ID == "") {
      widget.movie.CreateBy = currentUser != null ? currentUser.ID : "";
      print(widget.movie.CreateBy);
      var _resp = await movieAdd(widget.movie);
      if (_resp.State) {
        var res = widget.resources;
        var moveResult = Video.fromJson(_resp.Data);
        res.VideoID = moveResult.ID;
        res.VideoThumbnail = moveResult.Cover;
        res.State = true;
        await addResources(res);
      }
    }

  }
}

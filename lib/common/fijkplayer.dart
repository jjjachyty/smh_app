import 'dart:async';
import 'dart:io';
import 'package:fijkplayer/fijkplayer.dart';

import 'package:flutter/material.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/resources.dart';
import 'package:smh/models/watch_history.dart';

class FijkPlayPage extends StatefulWidget {
  Video movie;
  VideoResources resources;

  FijkPlayPage(this.movie, this.resources);
  @override
  _FijkPlayPageState createState() => _FijkPlayPageState();
}

class _FijkPlayPageState extends State<FijkPlayPage> {
  double _height = 250;
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    _playInput();
    player.onCurrentPosUpdate.listen((v) {
      if (v.inSeconds % 30 == 0) {
        //30S更新一次
        var history = WatchingHistory(
          UserID: currentUser.ID,
          VideoID: widget.resources.VideoID,
          VideoName: widget.movie.Name,
          ResourcesID: widget.resources.ID,
          ResourcesName: widget.resources.Name,
          VideoDuration: player.value.duration.inMinutes.toDouble(),
          Progress: v.inSeconds.toDouble(),
          VideoThumbnail: widget.movie.Cover,
        );
        updateWatch(history);
      }
    });
  }

  @override
  void dispose() {
    // player.removeListener(_fijkValueListener);

    player.release();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: FijkView(
        fit: FijkFit.cover,
        color: Colors.black,
        // fsFit: FijkFit.fill,
        player: player,
      ),
    );
  }

  void _checkHasWathcing() async {
    var history = WatchingHistory(
      UserID: currentUser.ID ?? "",
      VideoID: widget.resources.VideoID,
      VideoName: widget.movie.Name,
      ResourcesID: widget.resources.ID,
      ResourcesName: widget.resources.Name,
      VideoDuration: player.value.duration.inMinutes.toDouble(),
      VideoThumbnail: widget.movie.Cover,
    );
    var resp = await getResourceWatch(history);
    if (resp.State) {
      var _result = WatchingHistory.fromJson(resp.Data);
      if (_result.Progress > 0) {
        player.seekTo((_result.Progress * 1000).toInt());
      }
    }
  }

  void _playInput() async {
    print(widget.resources.URL);
    await player.setDataSource(
      widget.resources.URL,
      autoPlay: true,
      showCover: true,
    );

    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);

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
    if (currentUser != null) {
      _checkHasWathcing();
    }
  }
}

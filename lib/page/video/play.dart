// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
// import 'package:smh/common/init.dart';
// import 'package:smh/models/video.dart';
// import 'package:smh/models/resources.dart';
// import 'package:smh/models/watch_history.dart';

// class PlayPage extends StatefulWidget {
//   Video movie;
//   VideoResources resources;

//   PlayPage(this.movie, this.resources);
//   @override
//   _PlayPageState createState() => _PlayPageState();
// }

// class _PlayPageState extends State<PlayPage> {
//   Timer _timer;
//   IjkMediaController mediaController = IjkMediaController();

//   @override
//   void initState() {
//     _playInput();
//     mediaController.setIjkPlayerOptions(
//       [TargetPlatform.android, TargetPlatform.iOS],
//       [
//         IjkOption(IjkOptionCategory.format, "dns_cache_clear", 1),
//         IjkOption(IjkOptionCategory.player, "mediacodec", 1),
//         IjkOption(IjkOptionCategory.format, "analyzeduration", 1),
//         IjkOption(IjkOptionCategory.format, "fflags", "fastseek"),
//         IjkOption(IjkOptionCategory.format, "analyzemaxduration", 100),
//         IjkOption(IjkOptionCategory.player, "packet-buffering", 1),
//         IjkOption(IjkOptionCategory.format, "flush_packets", 1)
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     mediaController.stop();
//     mediaController.dispose();
//     if (_timer != null) {
//       _timer.cancel();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 250,
//       child: IjkPlayer(
//           mediaController: mediaController,
//           controllerWidgetBuilder: (mediaController) {
//             return DefaultIJKControllerWidget(
//                 controller: mediaController,
//                 fullScreenType: FullScreenType.rotateScreen);
//           }),
//     );
//   }

//   void _updateWatching() async {
//     var history = WatchingHistory(
//       UserID: currentUser.ID ?? "",
//       VideoID: widget.resources.VideoID,
//       VideoName: widget.movie.Name,
//       ResourcesID: widget.resources.ID,
//       ResourcesName: widget.resources.Name,
//       VideoDuration: mediaController.videoInfo.duration,
//       VideoThumbnail: widget.movie.Cover,
//     );
//     var resp = await getResourceWatch(history);
//     if (resp.State) {
//       var _result = WatchingHistory.fromJson(resp.Data);
//       if (_result.Progress > 0) {
//         mediaController.seekTo(_result.Progress);
//       }

//       _timer = Timer.periodic(new Duration(seconds: 30), (timer) async {
//         history = WatchingHistory(
//           UserID: currentUser.ID,
//           VideoID: widget.resources.VideoID,
//           VideoName: widget.movie.Name,
//           ResourcesID: widget.resources.ID,
//           ResourcesName: widget.resources.Name,
//           VideoDuration: mediaController.videoInfo.duration,
//           Progress: mediaController.videoInfo.currentPosition,
//           VideoThumbnail: widget.movie.Cover,
//         );
//         updateWatch(history).then((resp) {
//           print(resp.Message);
//         });
//       });
//     }
//   }

//   void _playInput() async {
//     print(widget.resources.URL);
//     await mediaController.setNetworkDataSource(
//       widget.resources.URL,
//       autoPlay: true,
//       headers: <String, String>{},
//     );

//     if (widget.movie.ID == null || widget.movie.ID == "") {
//       widget.movie.CreateBy = currentUser != null ? currentUser.ID : "";
//       print(widget.movie.CreateBy);
//       var _resp = await movieAdd(widget.movie);
//       if (_resp.State) {
//         var res = widget.resources;
//         var moveResult = Video.fromJson(_resp.Data);
//         res.VideoID = moveResult.ID;
//         res.VideoThumbnail = moveResult.Cover;
//         res.State = true;
//         await addResources(res);
//       }
//     }
//     if (currentUser != null) {
//       _updateWatching();
//     }
//   }
// }

// // the option is copied from ijkplayer example
// // Set<IjkOption> createIJKOptions() {
// //   return <IjkOption>[
// //     IjkOption(IjkOptionCategory.player, "mediacodec", 0),
// //     IjkOption(IjkOptionCategory.player, "opensles", 0),
// //     IjkOption(IjkOptionCategory.player, "overlay-format", 0x32335652),
// //     IjkOption(IjkOptionCategory.player, "framedrop", 1),
// //     IjkOption(IjkOptionCategory.player, "start-on-prepared", 0),
// //     IjkOption(IjkOptionCategory.format, "http-detect-range-support", 0),
// //     IjkOption(IjkOptionCategory.codec, "skip_loop_filter", 48),
// //   ].toSet();
// // }

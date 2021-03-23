import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/ads/interstitial.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:smh/common/event_bus.dart';
import 'package:smh/common/fijkplayer.dart';
import 'package:smh/common/init.dart';
import 'package:smh/common/webview.dart';
import 'package:smh/models/comment.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/player.dart';
import 'package:smh/models/resources.dart';
import 'package:smh/models/spiders/diaosidao.dart';
import 'package:smh/models/user.dart';
import 'package:smh/models/watch_history.dart';
import 'package:smh/page/video/play.dart';
import 'package:smh/page/video/resources.dart';
import 'package:smh/page/user/login.dart';
import 'package:smh/page/user/profile/index.dart';
import 'package:url_launcher/url_launcher.dart';

import 'comment.dart';

// final flutterWebviewPlugin = new FlutterWebviewPlugin();

class VideoProfilePage extends StatefulWidget {
  Video movie;
  VideoProfilePage(this.movie);
  @override
  _VideoProfilePageState createState() => _VideoProfilePageState();
}

class _VideoProfilePageState extends State<VideoProfilePage>
    with SingleTickerProviderStateMixin {
  VideoResources playResources;
  String currentPlayURL = "";
  TabController controller;
  List<Tab> tabs = List<Tab>();

  Map<String, List<VideoResources>> resources;
  User creater;
  FijkPlayer player = new FijkPlayer();
  bool canView = false;

  Player _player1 =
      new Player(Name: "17k云", URL: "https://17kyun.com/api.php?url=");
  Player _player2 =
      new Player(Name: "高速云", URL: "https://www.660406.com/parse393/?url=");
  Player _player3 =
      new Player(Name: "稳定云", URL: "https://www.594446.com/dpm3u8/?url=");

  void _listener() {
    eventBus.on<PlayMoieEvent>().listen((event) {
      setState(() {
        // playResources = null;
        playResources = event.resources;
        playResources.VideoThumbnail = widget.movie.Cover;
      });
    });
  }

  //简介
  Widget _profile() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          width: 200,
          height: 280,
          child: new Image.network(
            widget.movie.Cover,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
            child: Column(
          children: <Widget>[
            ListTile(
              isThreeLine: false,
              dense: true,
              leading: Text("类型"),
              title: Text(widget.movie.Genre),
            ),
            ListTile(
              isThreeLine: false,
              dense: true,
              title: Text(widget.movie.Region),
              leading: Text("地区"),
            ),
            ListTile(
              isThreeLine: false,
              dense: true,
              leading: Text("年代"),
              title: Text(widget.movie.Years),
            ),
            // ListTile(
            //   isThreeLine: false,
            //   dense: true,
            //   leading: Text("豆瓣评分"),
            //   title: Text((widget.movie.ScoreDB ?? 0 / 10).toString()),
            // ),
            widget.movie.Director == ""
                ? Text("")
                : ListTile(
                    isThreeLine: false,
                    dense: true,
                    leading: Text("导演"),
                    title: Text(widget.movie.Director),
                  ),
            widget.movie.Actor == ""
                ? Text("")
                : ListTile(
                    isThreeLine: false,
                    dense: true,
                    leading: Text("主演"),
                    title: Text(
                      widget.movie.Actor,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
            ListTile(
              isThreeLine: false,
              dense: true,
              leading: Text("创建人"),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UserProfilePage(creater);
                  }));
                },
                child: creater != null
                    ? CircleAvatar(
                        backgroundImage: AssetImage(creater.Avatar),
                      )
                    : Text("暂无人观看"),
              ),
            )
          ],
        ))
      ],
    );
  }

  @override
  void initState() {
    _listener();

    getResources(widget.movie).then((list) {
      setState(() {
        resources = list;
      });
      controller =
          TabController(initialIndex: 0, length: resources.length, vsync: this);
      tabs = resources.keys.map((e) {
        return Tab(
          text: e.toString(),
        );
      }).toList();
    });

    //initialIndex初始选中第几个

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // flutterWebviewPlugin.close();
    // flutterWebviewPlugin.dispose();
    // TODO: implement dispose
    player.release();
    // player.dispose();
    super.dispose();
  }

  Widget _getResource(String key) {
    if (resources != null) {
      return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2,
              childAspectRatio: 3),
          scrollDirection: Axis.vertical,
          itemCount: resources[key].length,
          itemBuilder: (c, i) {
            return FlatButton(
              padding: EdgeInsets.all(0),
              child: Text(
                resources[key][i].Name,
                style: TextStyle(
                    color: currentPlayURL == resources[key][i].URL
                        ? Colors.white
                        : Colors.black),
              ),
              color: currentPlayURL == resources[key][i].URL
                  ? Colors.red
                  : Colors.white,
              onPressed: () async {
                setState(() {
                  currentPlayURL = resources[key][i].URL;
                });
                // rewardedVideoAd().then((onValue) {
                //   RewardedVideoAd.instance.show();
                // });
                // interstitialAd.load();
                // interstitialAd.show();

                //判断有没有登录
                // if (currentUser == null) {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (BuildContext context) => LoginPage()));
                //   return;
                // }

                //判断是从本地加载而来，还是从第三方
                var _tmp = resources[key][i];
                var _movieTmp = widget.movie;
                if (_tmp.URL.contains(".html")) {
                  var _url = await getURL(resources[key][i].URL);
                  _tmp.URL = _url;
                }

                if (_tmp.URL.contains(".m3u8")) {
                  if (player.state == FijkState.end) {
                    player = FijkPlayer();
                  }
                  if (player.state == FijkState.started) {
                    await player.reset();
                  }

                  player.setDataSource(_tmp.URL,
                      autoPlay: true, showCover: true);
                  setState(() {
                    playResources = _tmp;
                  });
                } else {
                  player.release();
                  setState(() {
                    playResources = null;
                  });
                  // if (Platform.isAndroid) {
                  //   launch(_tmp.URL, forceWebView: false);
                  // } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WebViewPage(_tmp.Name, _tmp.URL);
                  }));
                }
                // }
              },
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.Name + (playResources == null ? "" : playResources.Name),
        ),
        backgroundColor: playResources != null ? Colors.black : Colors.red,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              child:
                  playResources != null && playResources.URL.contains(".m3u8")
                      ? FijkPlayPage(widget.movie, playResources,
                          player) //PlayPage(widget.movie, playResources)
                      : _profile(),
            ),
            playResources?.Platform == "m3u8"
                ? Container(
                    height: 30,
                    child: Row(
                      children: <Widget>[
                        FlatButton(
                            onPressed: null,
                            child: Text(
                              "云播/投屏",
                              style: TextStyle(fontSize: 12),
                            )),
                        OutlineButton(
                            color: Colors.white,
                            child: Text(
                              _player1.Name,
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () async {
                              player.release();
                              var url = playResources.URL;
                              //https://www.044416.com/parse392/player/dplayer/?live=0&autoplay=0&url=
                              // if (Platform.isAndroid) {
                              //   launch(_player1.URL + url);
                              // } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WebViewPage(
                                    "初始加载需等待", _player1.URL + url);
                              }));
                              // }
                              setState(() {
                                playResources = null;
                              });
                            }),
                        OutlineButton(
                            color: Colors.white,
                            child: Text(
                              _player2.Name,
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () async {
                              player.release();
                              var url = playResources.URL;
                              //https://www.044416.com/parse392/player/dplayer/?live=0&autoplay=0&url=
                              // if (Platform.isAndroid) {
                              //   launch(_player1.URL + url);
                              // } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WebViewPage(
                                    "初始加载需要等待", _player2.URL + url);
                              }));
                              // }
                              setState(() {
                                playResources = null;
                              });
                            }),
                        OutlineButton(
                            color: Colors.white,
                            child: Text(
                              _player3.Name,
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () async {
                              player.release();
                              var url = playResources.URL;
                              //https://www.044416.com/parse392/player/dplayer/?live=0&autoplay=0&url=
                              // if (Platform.isAndroid) {
                              //   launch(_player1.URL + url);
                              // } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WebViewPage(
                                    "初始加载需等待", _player3.URL + url);
                              }));
                              // }
                              setState(() {
                                playResources = null;
                              });
                            }),
                        Divider()
                      ],
                    ),
                  )
                : Text(""),
            (widget.movie.Actor == ""
                ? Text("")
                : resources != null
                    ? Column(children: [
                        Container(
                            child: TabBar(
                          controller:
                              controller, //可以和TabBarView使用同一个TabController
                          tabs: tabs,
                          labelColor: Colors.red,
                          indicatorColor: Colors.red,
                          indicatorWeight: 1,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.only(bottom: 10.0),
                          labelPadding: EdgeInsets.only(left: 20),
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 12.0,
                          ),
                        )),
                        Container(
                            height: 200,
                            child: TabBarView(
                                controller: controller,
                                children: (resources.keys.map((key) {
                                  return Container(child: _getResource(key));
                                }).toList())))
                      ])
                    : Center(child: Text("加载资源中"))),
            // Container(
            //   height: 250,
            //   child: VideoCommentPage(widget.movie),
            // ),
          ],
        ),
      )),
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
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

import 'comment.dart';

// final flutterWebviewPlugin = new FlutterWebviewPlugin();

class VideoProfilePage extends StatefulWidget {
  Video movie;
  VideoProfilePage(this.movie);
  @override
  _VideoProfilePageState createState() => _VideoProfilePageState();
}

class _VideoProfilePageState extends State<VideoProfilePage> {
  VideoResources playResources;
  int currentIndex;
  List<VideoResources> resources;
  User creater;
  bool canView = false;

  Player _player1 = new Player(
      Name: "最快云", URL: "https://player.gxtstatic.com/m3u8dp.php?url=");
  Player _player2 =
      new Player(Name: "高速云", URL: "https://www.660406.com/parse393/?url=");
  Player _player3 =
      new Player(Name: "稳定云", URL: "https://www.594446.com/dpm3u8/?url=");

  void _listener() {
    eventBus.on<PlayMoieEvent>().listen((event) {
      setState(() {
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
                child: (creater != null && creater.Avatar != "")
                    ? CircleAvatar(
                        backgroundImage: AssetImage(creater.Avatar),
                      )
                    : Text(""),
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

    if (widget.movie.Genre == "限制级") {
      checkVIP().then((_resp) {
        if (_resp.State) {
          if (_resp.Data as bool) {
            setState(() {
              canView = true;
            });
            getResources(widget.movie).then((list) {
              setState(() {
                resources = list;
              });
            });
            return;
          }
        } else {
          Fluttertoast.showToast(
              msg: "服务器请求失败,请稍后再试",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }
      });
    } else {
      canView = true;
      getResources(widget.movie).then((list) {
        setState(() {
          resources = list;
        });
      });
    }

    if (widget.movie.CreateBy != null && widget.movie.CreateBy != 0) {
      getUserInfo(widget.movie.CreateBy).then((user) {
        setState(() {
          creater = user;
        });
      });
    }

    getPlayer("2").then((player) {
      setState(() {
        _player1 = player;
      });
    });
    getPlayer("3").then((player) {
      setState(() {
        _player2 = player;
      });
    });
    getPlayer("4").then((player) {
      setState(() {
        _player3 = player;
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // flutterWebviewPlugin.close();
    // flutterWebviewPlugin.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          widget.movie.Name,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              // height: 300,
              child: playResources != null
                  ? FijkPlayPage(widget.movie,
                      playResources) //PlayPage(widget.movie, playResources)
                  : _profile(),
            ),
            Divider(),
            playResources != null && playResources.URL.contains(".m3u8")
                ? Container(
                    height: 20,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "第三方支持",
                          style: TextStyle(fontSize: 8),
                        ),
                        OutlineButton(
                            color: Colors.white,
                            child: Text(
                              _player1.Name,
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () async {
                              var url = playResources.URL;
                              //https://www.044416.com/parse392/player/dplayer/?live=0&autoplay=0&url=
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WebViewPage(
                                    "初始加载需等待", _player1.URL + url);
                              }));

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
                              var url = playResources.URL;
                              //https://www.044416.com/parse392/player/dplayer/?live=0&autoplay=0&url=
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WebViewPage(
                                    "初始加载需要等待", _player2.URL + url);
                              }));

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
                              var url = playResources.URL;
                              //https://www.044416.com/parse392/player/dplayer/?live=0&autoplay=0&url=
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WebViewPage(
                                    "初始加载需等待", _player3.URL + url);
                              }));
                              setState(() {
                                playResources = null;
                              });
                            }),
                      ],
                    ),
                  )
                : Text(""),
            Container(
                height: 100,
                child: canView
                    ? (resources == null
                        ? Text("加载中....")
                        : resources.length > 0
                            ? GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 2.0,
                                        mainAxisSpacing: 2,
                                        childAspectRatio: 3),
                                scrollDirection: Axis.vertical,
                                itemCount: resources.length,
                                itemBuilder: (c, i) {
                                  return FlatButton(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      resources[i].Name,
                                      style: TextStyle(
                                          color: currentIndex == i
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    color: currentIndex == i
                                        ? Colors.red
                                        : Colors.white,
                                    onPressed: () async {
                                      setState(() {
                                        currentIndex = i;
                                      });
                                      rewardedVideoAd().then((onValue) {
                                        RewardedVideoAd.instance.show();
                                      });

                                      //判断有没有登录
                                      if (currentUser == null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LoginPage()));
                                        return;
                                      }

                                      //判断是从本地加载而来，还是从第三方
                                      var _tmp = resources[i];
                                      var _movieTmp = widget.movie;
                                      if (_tmp.URL.contains(".html")) {
                                        var _url =
                                            await getURL(resources[i].URL);
                                        _tmp.URL = _url;
                                      }

                                      if (_tmp.URL.contains(".m3u8")) {
                                        setState(() {
                                          playResources = _tmp;
                                        });
                                      } else {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return WebViewPage(
                                              _tmp.Name, _tmp.URL);
                                        }));
                                      }
                                      if (_movieTmp.ID == null ||
                                          _movieTmp.ID == "") {
                                        _movieTmp.CreateBy = currentUser != null
                                            ? currentUser.ID
                                            : "";

                                        var _resp =
                                            await movieAdd(widget.movie);
                                        if (_resp.State) {
                                          // var res = resources[i];

                                          _movieTmp =
                                              Video.fromJson(_resp.Data);
                                          _tmp.VideoID = _movieTmp.ID;
                                          _tmp.VideoThumbnail = _movieTmp.Cover;
                                          _tmp.State = true;

                                          setState(() {
                                            widget.movie = _movieTmp;
                                          });
                                        }
                                      }

                                      //如果资源ID 为空 则新增资源
                                      if (_tmp.ID == null) {
                                        _tmp.VideoID = _movieTmp.ID;
                                        _tmp.VideoThumbnail = _movieTmp.Cover;
                                        var _resResp = await addResources(_tmp);
                                        if (_resResp.State) {
                                          _tmp = VideoResources.fromJson(
                                              _resResp.Data);
                                        }
                                        setState(() {
                                          resources[i] = _tmp;
                                        });
                                      }

                                      //更新观看记录
                                      if (currentUser != null &&
                                          currentUser.ID != null) {
                                        var history = WatchingHistory(
                                          UserID: currentUser == null
                                              ? ""
                                              : currentUser.ID,
                                          VideoID: _movieTmp.ID,
                                          VideoName: _movieTmp.Name,
                                          ResourcesID: _tmp.ID,
                                          ResourcesName: _tmp.Name,
                                          VideoDuration: 0,
                                          VideoThumbnail: _movieTmp.Cover,
                                        );
                                        // var _historyResp =
                                        //     await getResourceWatch(history);
                                        // if (_historyResp.State) {
                                        //   var _result = WatchingHistory.fromJson(
                                        //       _historyResp.Data);
                                        //   if (_result.CreateAt ==
                                        //       "0001-01-01T00:00:00Z") {
                                        addWatch(history);
                                      }
                                      //   }
                                      // }
                                    },
                                  );
                                })
                            : Text("无"))
                    : Text(
                        "非VIP暂不能观看限制类电影",
                        style: TextStyle(color: Colors.red),
                      )),
            Container(
              height: 300,
              child: VideoCommentPage(widget.movie),
            ),
          ],
        ),
      ),
    );
  }
}

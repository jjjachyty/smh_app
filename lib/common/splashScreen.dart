import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smh/common/version.dart';
import 'package:smh/page/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'init.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  int count = 3;

  startTime() async {
    //设置启动图生效时间
    var _duration = new Duration(seconds: 1);
    new Timer(_duration, () {
      // 空等1秒之后再计时
      _timer = new Timer.periodic(const Duration(milliseconds: 1000), (v) {
        count--;
        if (count == 0) {
          navigationPage();
        } else {
          setState(() {});
        }
      });
      return _timer;
    });
  }

  void navigationPage() {
    _timer.cancel();
    // if (newestVersion.VersionCode != currentVersion) {
    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (BuildContext context) => VersionPage()));
    // } else {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => IndexPage()));
    // }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: const Alignment(1.0, -1.0), // 右上角对齐
      children: [
        new ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: new CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: "http://smh.apcchis.com/splashscreens.jpg",
              // placeholder: (context, url) => Container(
              //   color: Colors.white,
              //   child: Image.asset("images/logo.png"),
              // ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            )),
        new Padding(
          padding: new EdgeInsets.fromLTRB(
              0.0, MediaQuery.of(context).size.height * 0.7, 10.0, 0.0),
          child: new FlatButton(
            onPressed: () {
              navigationPage();
            },
//            padding: EdgeInsets.all(0.0),
            color: Colors.transparent,
            child: new Text(
              "$count 跳过广告",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        )
      ],
    );
  }
}

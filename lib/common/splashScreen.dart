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
      // alignment: Alignment.center, // 右上角对齐
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 252, 104, 143),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/nhdz.jpg",
                width: 100,
                height: 100,
              ),
              Text(
                "滴～ 滴 滴",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              Text(
                "《书名号》",
                style: TextStyle(
                    color: Colors.white, decoration: TextDecoration.none),
              ),
              Text(
                "Q群:1091923826",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
        new Padding(
          padding: new EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width - 100,
              MediaQuery.of(context).size.height * 0.7,
              0.0,
              0.0),
          child: new FlatButton(
            onPressed: () {
              navigationPage();
            },
//            padding: EdgeInsets.all(0.0),
            color: Colors.transparent,
            child: new Text(
              "$count 点击跳过",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        )
      ],
    );
  }
}

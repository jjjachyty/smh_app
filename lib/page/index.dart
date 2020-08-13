import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smh/ads/interstitial.dart';
import 'package:smh/common/event_bus.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/video.dart';
import 'package:smh/page/video/index.dart';
import 'package:smh/page/video/profile.dart';
import 'package:smh/page/video/serach.dart';
import 'package:smh/page/user/index.dart';
import 'package:smh/page/user/login.dart';
import 'package:smh/page/user/nologin.dart';
import 'package:smh/page/video/vip.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with TickerProviderStateMixin {
  TabController controller;

  void _listener() {
    eventBus.on().listen((event) {
      switch (event.runtimeType.toString()) {
        case "ToLogin":
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
          break;

        case "UserChangeEvent":
          setState(() {});
          break;

        default:
      }
    });
  }

  @override
  void initState() {
    // controller = new TabController(length: 1, vsync: this);

    _listener();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: new Drawer(
      //   child: currentUser == null ? NoLoginPage() : UserIndexPage(),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        // title: Text(
        //   "书名号",
        //   // style: TextStyle(color: Colors.red),
        // ),
      
        
       
        title: Text("书名号-单机版"),
        centerTitle: true,
        // TabBar(
        //     unselectedLabelColor: Colors.grey,
        //     indicatorColor: Colors.white,
        //     indicatorSize: TabBarIndicatorSize.label,
        //     indicatorWeight: 10.0,
        //     controller: controller,
        //     tabs: <Widget>[
        //       // Tab(icon: Icon(Icons.home)),
        //       Tab(icon: Icon(Icons.movie)),
        //     ]),
      ),
      body: VideoIndexPage(),
    );
  }
}

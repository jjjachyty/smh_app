import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:oktoast/oktoast.dart';
import 'package:smh/page/index.dart';

import 'common/init.dart';
import 'common/splashScreen.dart';

void main() async {
  // IjkConfig.isLog = true;
//  IjkConfig.level = LogLevel.verbose;
  // await IjkManager.initIJKPlayer();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    init().then((onValue) {
      interstitialAd
        ..load().then((onValue) {
          interstitialAd.show();
        });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(primaryColor: Colors.red),
      themeMode: ThemeMode.system,
    );
  }
}

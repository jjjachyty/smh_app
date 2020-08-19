import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:smh/ads/interstitial.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/common/spider.dart';
import 'package:smh/common/utils.dart';
import 'package:smh/models/user.dart';
import 'package:smh/models/version.dart';

// User currentUser;
var currentVersion = "0.0.1"; //当前版本
Version newestVersion = new Version(VersionCode: "0.0.1"); //最新版本

String token;
DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
AndroidDeviceInfo androidInfo;
String testDevice;
String localPath = "";
InterstitialAd interstitialAd;

RegExp phoneExp = RegExp(
    r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

RegExp passwdExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,16}$');
var flag = false;
Future<void> init() async {
  await initSharedPreferences();
  // await getUser();
  flag = (await getStorageBool("flag")) == null
      ? Platform.isIOS ? false : true
      : true;
  initDio();
  localPath = await findLocalPath();
  // await getVersion(Platform.operatingSystem);
  FirebaseAdMob.instance
      .initialize(appId: "ca-app-pub-4849347031921234~6752835093");
  // if (Platform.isIOS) {
  //   testDevice = (await deviceInfo.iosInfo).identifierForVendor;
  // } else {
  //   testDevice = (await deviceInfo.androidInfo).androidId;
  // }
  print("testDevice========${testDevice}");
  interstitialAd = createInterstitialAd();
  rewardedVideoAd();
}

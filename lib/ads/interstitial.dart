import 'dart:io';
import 'package:device_info/device_info.dart';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:smh/common/init.dart';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  testDevices: testDevice != null ? <String>[testDevice] : null,
  keywords: <String>['leisure', 'game', 'relaxation', 'puzzle'],
  contentUrl: 'https://flutter.io',
  childDirected: true,
  nonPersonalizedAds: true,
);

InterstitialAd createInterstitialAd() {
  return InterstitialAd(
    adUnitId: "ca-app-pub-4849347031921234/7846424916",
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event $event");
    },
  );
}

Future<void> rewardedVideoAd() async {
  return await RewardedVideoAd.instance.load(
      adUnitId: "ca-app-pub-4849347031921234/4195255833",
      targetingInfo: targetingInfo);
}

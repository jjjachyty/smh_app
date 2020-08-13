import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/common/event_bus.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/video.dart';
import 'package:smh/page/video/list.dart';
import 'package:smh/page/video/profile.dart';
import 'package:smh/page/video/serach.dart';
import 'package:smh/page/video/vip.dart';
import 'package:smh/page/video/watching.dart';

class VideoIndexPage extends StatefulWidget {
  @override
  _VideoIndexPageState createState() => _VideoIndexPageState();
}

class _VideoIndexPageState extends State<VideoIndexPage> {
  List<Video> videos;
  // SwiperControl swiperControl = new SwiperControl();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        ListTile(
          subtitle: Text("原站VIP"),
        ),
        Wrap(
          children: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  interstitialAd.load();
                  interstitialAd.show();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VipVideoPage("爱奇艺", "https://www.iqiyi.com/");
                  }));
                },
                icon: Image.asset("images/aqylogo.png"),
                label: Text("")),
            FlatButton.icon(
                onPressed: () {
                  interstitialAd.load();
                  interstitialAd.show();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VipVideoPage("腾讯", "https://m.v.qq.com/");
                  }));
                },
                icon: Image.asset("images/qqlogo.png"),
                label: Text("")),
            FlatButton.icon(
                onPressed: () {
                  interstitialAd.load();
                  interstitialAd.show();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VipVideoPage("优酷", "https://www.youku.com/");
                  }));
                },
                icon: Image.asset("images/youkulogo.png"),
                label: Text("")),
            FlatButton.icon(
                onPressed: () {
                  interstitialAd.load();
                  interstitialAd.show();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VipVideoPage("bilibili", "https://m.bilibili.com/");
                  }));
                },
                icon: Image.asset("images/bilibililogo.png"),
                label: Text("")),
            FlatButton.icon(
                onPressed: () {
                   interstitialAd.load();
                  interstitialAd.show();
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VipVideoPage("芒果", "https://m.mgtv.com/channel/home/");
                  }));
                  
                },
                icon: Image.asset("images/hunantvlogo.png"),
                label: Text("")),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "点击搜索视频",
                  prefixIcon: Icon(Icons.search)),
              onTap: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              },
            )),
        ListTile(
            subtitle:
                Text("当前版本" + currentVersion + "\n如有任何问题请前往QQ群1091923826交流")),
      ],
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}

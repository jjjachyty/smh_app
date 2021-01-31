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
    videos = [
      Video(
          Name: "日常英语",
          Cover:
              "https://dss2.bdstatic.com/8_V1bjqh_Q23odCf/pacific/1915226453.jpg",
          Years: "2020",
          Genre: "日常",
          Director: "",
          Actor: "",
          Region: "美国"),
      Video(
          Name: "零基础英语",
          Cover:
              "https://dss2.bdstatic.com/8_V1bjqh_Q23odCf/pacific/1915013701.jpg",
          Years: "2020",
          Genre: "日常",
          Director: "",
          Actor: "",
          Region: "美国"),
      Video(
          Name: "商务英语",
          Cover:
              "https://dss2.bdstatic.com/8_V1bjqh_Q23odCf/pacific/1915013702.jpg",
          Years: "2020",
          Genre: "日常",
          Director: "",
          Actor: "",
          Region: "美国"),
      Video(
          Name: "旅游英语",
          Cover:
              "https://dss2.bdstatic.com/8_V1bjqh_Q23odCf/pacific/1915013709.jpg",
          Years: "2020",
          Genre: "日常",
          Director: "",
          Actor: "",
          Region: "美国"),
    ];
  }

  Widget _initWidget() {
    return GridView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      // controller: _scrollController,
      scrollDirection: Axis.vertical,
      //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //横轴元素个数
        crossAxisCount: 3,
        //纵轴间距
        mainAxisSpacing: 0.5,
        //横轴间距
        crossAxisSpacing: 0.5,
        //子组件宽高长度比例
      ),

      itemCount: videos.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () async {
              //获取电影信息

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          VideoProfilePage(videos[index])));
            },
            child: Container(
                child: Column(
              children: <Widget>[
                Container(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      videos[index].Cover,
                      fit: BoxFit.fill,
                    )),
              ],
            )));
      },
    );
  }

  Widget _movieWidget() {
    return Column(
      children: <Widget>[
        ListTile(
          subtitle: Text("原站VIP"),
        ),
        Wrap(
          children: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  // interstitialAd.load();
                  // interstitialAd.show();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VipVideoPage("爱奇艺", "https://www.iqiyi.com/");
                  }));
                },
                icon: Image.asset("images/aqylogo.png"),
                label: Text("")),
            FlatButton.icon(
                onPressed: () {
                  // interstitialAd.load();
                  // interstitialAd.show();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VipVideoPage("腾讯", "https://m.v.qq.com/");
                  }));
                },
                icon: Image.asset("images/qqlogo.png"),
                label: Text("")),
            FlatButton.icon(
                onPressed: () {
                  // interstitialAd.load();
                  // interstitialAd.show();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VipVideoPage("优酷", "https://www.youku.com/");
                  }));
                },
                icon: Image.asset("images/youkulogo.png"),
                label: Text("")),
            FlatButton.icon(
                onPressed: () {
                  // interstitialAd.load();
                  // interstitialAd.show();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VipVideoPage("bilibili", "https://m.bilibili.com/");
                  }));
                },
                icon: Image.asset("images/bilibililogo.png"),
                label: Text("")),
            FlatButton.icon(
                onPressed: () {
                  // interstitialAd.load();
                  // interstitialAd.show();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VipVideoPage(
                        "芒果", "https://m.mgtv.com/channel/home/");
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: flag ? _movieWidget() : _initWidget(),
    );
    ;
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}

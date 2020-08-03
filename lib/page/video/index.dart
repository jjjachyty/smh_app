import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/common/event_bus.dart';
import 'package:smh/models/video.dart';
import 'package:smh/page/video/list.dart';
import 'package:smh/page/video/profile.dart';
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
    eventBus.on<UserChangeEvent>().listen((event) {
      _newestVideo();
    });
    _newestVideo();
    // TODO: implement initState
    super.initState();
  }

  _newestVideo() {
    newestVideo().then(((resp) {
      setState(() {
        videos = resp.Data;
      });
    }));
  }

  Widget _getSwipper() {
    if (videos == null) {
      return Container(height: 300, child: Text("加载中...."));
    } else if (videos.length == 0) {
      return Container(height: 300, child: Text("....无...."));
    }
    // return Container(
    //     height: 300,
    //     child: Swiper(
    //       autoplay: true,
    //       onTap: (i) {
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (BuildContext context) =>
    //                     VideoProfilePage(videos[i])));
    //       },
    //       itemBuilder: (BuildContext context, int index) {
    //         return Column(
    //           children: <Widget>[
    //             Container(
    //                 height: 270,
    //                 width: MediaQuery.of(context).size.width * 0.8,
    //                 child: CachedNetworkImage(
    //                   imageUrl: videos[index].Cover,
    //                   fit: BoxFit.cover,
    //                 )),
    //             Text(
    //               videos[index].Name,
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             )
    //           ],
    //         );
    //       },
    //       itemCount: videos.length,
    //       itemWidth: 300.0,
    //       viewportFraction: 0.8,
    //       scale: 0.9,
    //       control: swiperControl,
    //     ));
    return BannerSwiper(
      //width  和 height 是图片的高宽比  不用传具体的高宽   必传
      height: 250,
      width: 250,
      //轮播图数目 必传
      length: videos.length,

      //轮播的item  widget 必传
      getwidget: (index) {
        return new GestureDetector(
            child: CachedNetworkImage(
              imageUrl: videos[index % videos.length].Cover,
              fit: BoxFit.cover,
            ),
            onTap: () {
              //点击后todo
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          VideoProfilePage(videos[index % videos.length])));
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        _getSwipper(),
        VideoWatchingPage(),
        ListTile(
          leading: Text("全网最新观看:"),
        ),
        VideosPage(),
      ],
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}

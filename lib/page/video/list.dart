import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smh/common/event_bus.dart';
import 'package:smh/models/video.dart';

import 'profile.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  ScrollController _scrollController = new ScrollController();
  var pageSize = 0;
  List<Video> videos;
  Widget _page(List<Video> videos) {
    return GridView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //横轴元素个数
        crossAxisCount: 4,
        //纵轴间距
        mainAxisSpacing: 0.0,
        //横轴间距
        crossAxisSpacing: 0.0,
        // childAspectRatio: 0
        //子组件宽高长度比例
      ),

      itemCount: videos.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          VideoProfilePage(videos[index])));
            },
            child: Column(
              children: <Widget>[
                Container(
                    height: 80,
                    width: 80,
                    child: CachedNetworkImage(
                      imageUrl: videos[index].Cover,
                      fit: BoxFit.cover,
                    )),
                Text(videos[index].Name,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ))
              ],
            ));
      },
    );
  }

  _loadMore() {
    movieList(pageSize).then((resp) {
      if (resp.State) {
        setState(() {
          if (videos == null) {
            videos = resp.Data;
          } else {
            videos.addAll(resp.Data);
          }
        });
      }
    });
  }

  @override
  void initState() {
    eventBus.on<UserChangeEvent>().listen((event) {
      videos = null;
      _loadMore();
    });

    // TODO: implement initState
    _loadMore();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(_scrollController.position.userScrollDirection.index);

        if (_scrollController.position.userScrollDirection.index == 2) {
          print("2");
          setState(() {
            pageSize++;
          });
          //下一页
        } else {
          //上一页
          setState(() {
            pageSize--;
          });
        }
        _loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Builder(
        builder: (context) {
          if (videos == null) {
            return Center(
              child: Text("加载中..."),
            );
          }
          if (videos.length > 0) {
            return _page(videos);
          } else {
            return Text(
              "...暂无...",
              style: TextStyle(color: Colors.grey),
            );
          }
        },
      ),
    );
  }
}

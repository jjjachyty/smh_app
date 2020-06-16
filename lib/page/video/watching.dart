import 'package:flutter/material.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/watch_history.dart';

import 'profile.dart';

class VideoWatchingPage extends StatefulWidget {
  @override
  _VideoWatchingPageState createState() => _VideoWatchingPageState();
}

class _VideoWatchingPageState extends State<VideoWatchingPage> {
  ScrollController _scrollController = new ScrollController();
  var pageSize = 0;
  List<Watching> watchings = new List();

  Widget _page(List<Watching> watchings) {
    return GridView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //横轴元素个数
        crossAxisCount: 1,
        //纵轴间距
        mainAxisSpacing: 0.0,
        //横轴间距
        crossAxisSpacing: 0.0,
        //子组件宽高长度比例
      ),

      itemCount: watchings.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () async {
              //获取电影信息
              var _resp = await movieGet(watchings[index].VideoID);
              if (_resp.State) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            VideoProfilePage(_resp.Data)));
              }
            },
            child: Container(
                child: Column(
              children: <Widget>[
                Container(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      watchings[index].VideoThumbnail,
                      fit: BoxFit.fill,
                    )),
                Text(
                  watchings[index].Count.toString() + "人",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                )
              ],
            )));
      },
    );
  }

  _loadMore() {
    watchingList().then((resp) {
      if (resp.State) {
        setState(() {
          watchings.addAll(resp.Data);
        });
      }
    });
  }

  @override
  void initState() {
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
    if (watchings.length > 0) {
      return Container(
          height: 180,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Text("当前正在观看Top15:"),
              ),
              Expanded(
                child: _page(watchings),
              )
            ],
          ));
    } else {
      return Divider();
    }
  }
}

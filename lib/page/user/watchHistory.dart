import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/watch_history.dart';
import 'package:smh/page/video/profile.dart';

class WatchHistoryPage extends StatefulWidget {
  @override
  _WatchHistoryPageState createState() => _WatchHistoryPageState();
}

class _WatchHistoryPageState extends State<WatchHistoryPage> {
  int pageSize = 0;
  List<WatchingHistory> historys = new List();
  ScrollController _scrollController = new ScrollController();

  _loadMore() {
    getResourceWatchs(pageSize, currentUser.ID).then((resp) {
      if (resp.State) {
        setState(() {
          historys.addAll(resp.Data);
        });
      }
    });
  }

  @override
  void initState() {
    _loadMore();
    // TODO: implement initState
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
    return Scaffold(
        appBar: AppBar(
          title: Text("观看记录"),
        ),
        body: Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: historys.length,
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: true,
                  subtitle: Text("观看至:" +
                      (historys[index].Progress / 60).toStringAsFixed(2)),
                  leading: Image.network(
                    historys[index].VideoThumbnail,
                    fit: BoxFit.fill,
                  ),
                  title: Text(historys[index].VideoName +
                      "   " +
                      historys[index].ResourcesName),
                  trailing: Text(historys[index].Progress == 0
                      ? "0%"
                      : (historys[index].Progress /
                                  historys[index].VideoDuration)
                              .toStringAsFixed(2) +
                          "%"),
                  onTap: () async {
                    var resp = await movieGet(historys[index].VideoID);
                    if (resp.State) {
                      if (resp.Data.ID != "") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    VideoProfilePage(resp.Data)));
                      } else {
                        Fluttertoast.showToast(
                            msg: "该资源已被他人删除,无法再继续观看",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  },
                );
              },
            )));
  }
}

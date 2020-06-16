import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/watch_history.dart';
import 'package:smh/page/video/profile.dart';

class UserWatchHistoryPage extends StatefulWidget {
  int userID;
  UserWatchHistoryPage(this.userID);
  @override
  _UserWatchHistoryPageState createState() => _UserWatchHistoryPageState();
}

class _UserWatchHistoryPageState extends State<UserWatchHistoryPage> {
  int pageSize = 0;
  List<WatchingHistory> historys;
  ScrollController _scrollController = new ScrollController();

  _loadMore() {
    getResourceWatchs(pageSize, widget.userID).then((resp) {
      if (resp.State) {
        setState(() {
          if (historys == null) {
            historys = resp.Data;
          } else {
            historys.addAll(resp.Data);
          }
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
    if (historys == null) {
      return Center(child: Text("加载中...."));
    }
    return ListView.builder(
      controller: _scrollController,
      itemCount: historys.length,
      itemBuilder: (context, index) {
        return ListTile(
          // isThreeLine: true,

          leading: Image.network(
            historys[index].VideoThumbnail,
            fit: BoxFit.fill,
            width: 50,
          ),
          title: Text(historys[index].VideoName +
              "[" +
              historys[index].ResourcesName +
              "]"),
          trailing: Text(
            formatDate(DateTime.parse(historys[index].CreateAt).toLocal(),
                [yyyy, "/", mm, "/", dd, " ", HH, ":", nn, ":", ss]),
            style: TextStyle(fontSize: 12),
          ),
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
    );
  }
}

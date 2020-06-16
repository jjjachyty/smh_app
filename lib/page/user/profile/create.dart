import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/watch_history.dart';
import 'package:smh/page/video/profile.dart';

class UserCreatePage extends StatefulWidget {
  int userID;
  UserCreatePage(this.userID);
  @override
  _UserCreatePageState createState() => _UserCreatePageState();
}

class _UserCreatePageState extends State<UserCreatePage> {
  int pageSize = 0;
  List<Video> videos;
  ScrollController _scrollController = new ScrollController();

  _loadMore() {
    userCreate(pageSize, widget.userID).then((resp) {
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
    if (videos == null) {
      return Center(child: Text("加载中..."));
    }
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(
            videos[index].Cover,
            fit: BoxFit.fill,
            width: 50,
          ),
          title: Text(
            videos[index].Name,
            // style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            formatDate(DateTime.parse(videos[index].CreateAt).toLocal(),
                [yyyy, "/", mm, "/", dd, " ", HH, ":", nn, ":", ss]),
            style: TextStyle(fontSize: 12),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        VideoProfilePage(videos[index])));
          },
        );
      },
    );
  }
}

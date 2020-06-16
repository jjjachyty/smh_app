import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/watch_history.dart';
import 'package:smh/page/video/profile.dart';

class CreateVideosPage extends StatefulWidget {
  @override
  _CreateVideosPageState createState() => _CreateVideosPageState();
}

class _CreateVideosPageState extends State<CreateVideosPage> {
  int pageSize = 0;
  List<Video> videos = new List();
  ScrollController _scrollController = new ScrollController();

  _loadMore() {
    userCreate(pageSize, currentUser.ID).then((resp) {
      if (resp.State) {
        setState(() {
          videos.addAll(resp.Data);
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
          title: Text("我创建的"),
        ),
        body: Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      leading:
                          CachedNetworkImage(imageUrl: videos[index].Cover),
                      title: Text(videos[index].Name),
                      subtitle: Text(
                        formatDate(
                            DateTime.parse(videos[index].CreateAt).toLocal(), [
                          yyyy,
                          "/",
                          mm,
                          "/",
                          dd,
                          " ",
                          HH,
                          ":",
                          nn,
                          ":",
                          ss
                        ]),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    VideoProfilePage(videos[index])));
                      },
                    ),
                  ),
                  actions: <Widget>[],
                  secondaryActions: <Widget>[
                    // IconSlideAction(
                    //   caption: '查看',
                    //   color: Colors.black45,
                    //   icon: Icons.view_headline,
                    //   onTap: () {},
                    // ),
                    IconSlideAction(
                      caption: '删除',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () async {
                        if (await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('确定删除吗?'),
                              content: Text('删除后其他人无法再浏览观看'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('取消'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                ),
                                FlatButton(
                                    child: Text('确定'),
                                    onPressed: () async {
                                      var resp =
                                          await movieRemove(videos[index].ID);
                                      if (resp.State) {
                                        Navigator.of(context).pop(true);
                                      }
                                    }),
                              ],
                            );
                          },
                        )) {
                          setState(() {
                            videos.removeAt(index);
                          });
                        }
                      },
                    ),
                  ],
                );
                // return ListTile(
                //   leading: CachedNetworkImage(imageUrl: videos[index].Cover),
                //   title: Text(videos[index].Name),
                //   subtitle: Text(videos[index].CreateAt),
                //   trailing: IconButton(
                //       icon: Icon(Icons.remove_circle), onPressed: () {}),
                //   onTap: () async {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (BuildContext context) =>
                //                 VideoIndexPage(videos[index])));
                //   },
                // );
              },
            )));
  }
}

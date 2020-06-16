import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/follow.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/user.dart';
import 'package:smh/models/watch_history.dart';
import 'package:smh/page/video/profile.dart';
import 'package:smh/page/user/profile/index.dart';

class UserFlowPage extends StatefulWidget {
  @override
  _UserFlowPageState createState() => _UserFlowPageState();
}

class _UserFlowPageState extends State<UserFlowPage> {
  int pageSize = 0;
  List<Follow> follows = new List();
  ScrollController _scrollController = new ScrollController();

  _loadMore() {
    userFollows(pageSize).then((resp) {
      if (resp.State) {
        setState(() {
          follows.addAll(resp.Data);
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
          title: Text("我关注的人"),
        ),
        body: Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: follows.length,
              itemBuilder: (context, index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: Image.asset(follows[index].FollowAvatar),
                      title: Text(follows[index].FollowName),
                      subtitle: Text(
                        formatDate(
                            DateTime.parse(follows[index].CreateAt).toLocal(), [
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
                      onTap: () async {
                        var user = await getUserInfo(follows[index].FollowID);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UserProfilePage(user)));
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
                      caption: '取关',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () async {
                        if (await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('确定取消关注吗?'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('取消'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                ),
                                FlatButton(
                                    child: Text('确定'),
                                    onPressed: () async {
                                      var resp = await removeFollow(
                                          follows[index].FollowID);
                                      if (resp.State) {
                                        Navigator.of(context).pop(true);
                                      }
                                    }),
                              ],
                            );
                          },
                        )) {
                          setState(() {
                            follows.removeAt(index);
                          });
                        }
                      },
                    ),
                  ],
                );
                // return ListTile(
                //   leading: CachedNetworkImage(imageUrl: follows[index].Cover),
                //   title: Text(follows[index].Name),
                //   subtitle: Text(follows[index].CreateAt),
                //   trailing: IconButton(
                //       icon: Icon(Icons.remove_circle), onPressed: () {}),
                //   onTap: () async {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (BuildContext context) =>
                //                 VideoIndexPage(follows[index])));
                //   },
                // );
              },
            )));
  }
}

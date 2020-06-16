import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/follow.dart';
import 'package:smh/models/user.dart';
import 'package:smh/page/user/profile/comment.dart';
import 'package:smh/page/user/profile/create.dart';
import 'package:smh/page/user/profile/watching.dart';

class UserProfilePage extends StatefulWidget {
  User user;
  UserProfilePage(this.user);
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with TickerProviderStateMixin {
  TabController controller;
  var hasFollow = false;
  //定义一个widget数组，用于存放标签栏的内容,这里我定义了8个标签栏，分别对应不同的新闻类型
  final List<Tab> tabs = <Tab>[
    new Tab(
      text: 'TA的创建',
    ),
    new Tab(
      text: 'TA的观看',
    ),
    new Tab(
      text: 'TA的评论',
    ),
  ];

  @override
  void initState() {
    checkFollow(widget.user.ID).then((flag) {
      setState(() {
        hasFollow = flag;
      });
    });
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: <Widget>[
              hasFollow
                  ? FlatButton(
                      child: Text(
                      "已关注",
                      style: TextStyle(color: Colors.black),
                    ))
                  : FlatButton.icon(
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        var _resp = await addFollow(Follow(
                            UserID: currentUser.ID,
                            FollowID: widget.user.ID,
                            FollowName: widget.user.NickName,
                            FollowAvatar: widget.user.Avatar));
                        if (_resp.State) {
                          setState(() {
                            hasFollow = true;
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "关注出错，请稍后重试",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      label: Text("关注",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)))
            ],
          ),
          Container(
            child: Center(
              child: (widget.user != null && widget.user.Avatar != "")
                  ? Image.asset(widget.user.Avatar)
                  : "无头像",
            ),
          ),
          Text(widget.user.NickName),
          Text(widget.user.Introduce),
          Container(
              alignment: Alignment.center,
              child: new TabBar(
                unselectedLabelColor: Colors.black38,
                indicatorColor: Colors.red,
                tabs: tabs,

                //这表示当标签栏内容超过屏幕宽度时是否滚动，因为我们有8个标签栏所以这里设置是
                isScrollable: true,
                //标签颜色
                labelColor: Colors.red,
                //未被选中的标签的颜色
                labelStyle: new TextStyle(fontSize: 18.0),
                controller: controller,
              )),
          Expanded(
              flex: 1,
              child: TabBarView(controller: controller, children: [
                UserCreatePage(widget.user.ID),
                UserWatchHistoryPage(widget.user.ID),
                UserCommentPage(widget.user.ID)
              ]))
        ],
      ),
    );
  }
}

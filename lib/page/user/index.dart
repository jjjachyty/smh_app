import 'package:date_format/date_format.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/ads/interstitial.dart';
import 'package:smh/common/event_bus.dart';
import 'package:smh/common/init.dart';
import 'package:smh/common/utils.dart';
import 'package:smh/models/user.dart';
import 'package:smh/page/video/vip.dart';
import 'package:smh/page/user/article/publish.dart';
import 'package:smh/page/user/create_videos.dart';
import 'package:flutter/services.dart';
import 'package:smh/page/user/flow.dart';
import 'package:smh/page/user/profile/vip.dart';
import 'package:smh/page/user/setting/setting.dart';
import 'package:smh/page/user/watchHistory.dart';

class DrawerWeiget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DrawerWeigetState();
  }
}

class _DrawerWeigetState extends State<DrawerWeiget> {
  GlobalKey key = new GlobalKey();

  @override
  void initState() {
    //   RewardedVideoAd.instance.listener =
    //     (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
    //   print("RewardedVideoAd event $event");
    //   if (event == RewardedVideoAdEvent.rewarded) {
    //     setState(() {
    //       _coins += rewardAmount;
    //     });
    //   }
    // };

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.only(top: 40, left: 10),
      children: <Widget>[
        new Row(
          children: <Widget>[
            // Expanded(
            //   flex: 1,
            //   child: CircleAvatar(
            //     backgroundColor: Colors.red,
            //     radius: 40,
            //     backgroundImage: AssetImage(currentUser.Avatar == ""
            //         ? "images/avatar/hanweizhelianmeng-yemoxia.png"
            //         : currentUser.Avatar),
            //   ),
            // ),
            Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Text(
                        //   currentUser.NickName,
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            //             UserSettingPage()));
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // new Text(
                        //   currentUser.Introduce == ""
                        //       ? '无签名'
                        //       : currentUser.Introduce,
                        //   style: TextStyle(color: Colors.grey),
                        // )
                      ],
                    ),
                  ],
                )),
          ],

//
        ),
        // new ListTile(
        //   title: new Text('我发布的'),
        //   trailing: new Icon(Icons.arrow_right),
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (BuildContext context) => ArticlePublishPage()));
        //   },
        // ),
        // new ListTile(
        //     leading: Text('VIP'),
        //     title: Text(
        //       "到期时间" +
        //           formatDate(DateTime.parse(currentUser.VIPEndTime).toLocal(),
        //               [yyyy, "/", mm, "/", dd, " ", HH, ":", nn, ":", ss]),
        //       style: TextStyle(color: Colors.grey, fontSize: 10),
        //     ),
        //     trailing: Text(
        //       "看广告续签",
        //       style: TextStyle(color: Colors.red),
        //     ),
        //     onTap: () async {
        //       rewardedVideoAd();
        //       RewardedVideoAd.instance.show().catchError((onError) {
        //         Fluttertoast.showToast(
        //             msg: "广告加载失败,请重试",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             timeInSecForIos: 2,
        //             fontSize: 16.0);
        //       });
        //       RewardedVideoAd.instance.listener = (RewardedVideoAdEvent event,
        //           {String rewardType, int rewardAmount}) async {
        //         switch (event) {
        //           case RewardedVideoAdEvent.loaded:
        //             // RewardedVideoAd.instance.show();
        //             break;
        //           case RewardedVideoAdEvent.failedToLoad:
        //             Fluttertoast.showToast(
        //                 msg: "广告加载失败,请联系管理员",
        //                 toastLength: Toast.LENGTH_SHORT,
        //                 gravity: ToastGravity.CENTER,
        //                 backgroundColor: Colors.red,
        //                 textColor: Colors.white,
        //                 timeInSecForIos: 2,
        //                 fontSize: 16.0);
        //             //读取失败！
        //             break;
        //           case RewardedVideoAdEvent.opened:
        //             break;
        //           case RewardedVideoAdEvent.leftApplication:
        //             break;
        //           case RewardedVideoAdEvent.closed:
        //             // Fluttertoast.showToast(
        //             //     msg: "广告未看完,自动放弃获取VIP",
        //             //     toastLength: Toast.LENGTH_SHORT,
        //             //     gravity: ToastGravity.CENTER,
        //             //     backgroundColor: Colors.red,
        //             //     textColor: Colors.white,
        //             //     timeInSecForIos: 2,
        //             //     fontSize: 16.0);
        //             rewardedVideoAd();
        //             break;
        //           case RewardedVideoAdEvent.rewarded:
        //             // print("*********奖励 $rewardAmount");
        //             await getVIP();
        //             eventBus.fire(UserChangeEvent);
        //             Fluttertoast.showToast(
        //                 msg: "VIP续签成功",
        //                 toastLength: Toast.LENGTH_SHORT,
        //                 gravity: ToastGravity.CENTER,
        //                 backgroundColor: Colors.red,
        //                 textColor: Colors.white,
        //                 timeInSecForIos: 2,
        //                 fontSize: 16.0);
        //             setState(() {
        //               // currentUser.VIPEndTime
        //               // currentUser.VIPEndTime =
        //               //     DateTime.parse(currentUser.VIPEndTime)
        //               //         .add(Duration(days: 1))
        //               //         .toString();
        //             });
        //             break;
        //           case RewardedVideoAdEvent.started:
        //             break;
        //           case RewardedVideoAdEvent.completed:
        //             print("*********播放结束");
        //             break;
        //         }
        //       };
        //     }),
        new Divider(),
        new ListTile(
          title: new Text('我关注的人'),
          trailing: new Icon(Icons.arrow_right),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => UserFlowPage()));
          },
        ),
        new Divider(),

        new ListTile(
          title: new Text('我创建的'),
          trailing: new Icon(Icons.arrow_right),
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => CreateVideosPage()));
          },
        ),

        new Divider(),
        Column(
          children: <Widget>[
            new ListTile(
              title: new Text('观看记录'),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => WatchHistoryPage()));
              },
            ),
            new Divider(),
            new ListTile(
                key: key,
                title: new Text('爱奇艺/优酷/腾讯'),
                trailing: new Icon(Icons.arrow_right),
                onTap: () async {
                  RenderBox _obj = key.currentContext.findRenderObject();
                  var _offset = _obj.localToGlobal(Offset.zero);
                  // RewardedVideoAd.instance.show();

                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(10, _offset.dy, 0, 0),
                      items: [
                        PopupMenuItem(
                            child: FlatButton(
                          child: Text("爱奇艺"),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return VipVideoPage(
                                  "爱奇艺", "https://www.iqiyi.com/");
                            }));
                          },
                        )),
                        PopupMenuItem(
                            child: FlatButton(
                          child: Text("优酷"),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return VipVideoPage(
                                  "优酷", "https://www.youku.com/");
                            }));
                          },
                        )),
                        PopupMenuItem(
                            child: FlatButton(
                          child: Text("腾讯"),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return VipVideoPage("腾讯", "https://m.v.qq.com/");
                            }));
                          },
                        )),
                      ]);
                })
            // : ListTile(
            //     title: Text("签到(有惊喜)"),
            //     onTap: () async {
            //       var _resp = await getVIP();
            //       if (_resp.State) {
            //         Fluttertoast.showToast(
            //             msg: "签到成功",
            //             toastLength: Toast.LENGTH_SHORT,
            //             gravity: ToastGravity.CENTER,
            //             timeInSecForIos: 2,
            //             backgroundColor: Colors.white,
            //             textColor: Colors.black,
            //             fontSize: 16.0);
            //         setState(() {});
            //       } else {
            //         Fluttertoast.showToast(
            //             msg: "签到失败,赶紧报告管理员",
            //             toastLength: Toast.LENGTH_SHORT,
            //             gravity: ToastGravity.CENTER,
            //             timeInSecForIos: 2,
            //             backgroundColor: Colors.red,
            //             textColor: Colors.white,
            //             fontSize: 16.0);
            //       }
            //     },
            //   ),
          ],
        ),
        new Divider(),
        new ListTile(
            title: new Text('退出'),
            onTap: () {
              loginOut();
              eventBus.fire(UserChangeEvent());
            }),
        new ListTile(
            title: Text(
              "当前前版本" + currentVersion,
            ),
            subtitle: Text.rich(TextSpan(
                text: "交流QQ群:1091923826",
                recognizer: LongPressGestureRecognizer()
                  ..onLongPress = () {
                    eventBus.fire(ShowVideo());
                  })))
      ],
    );
  }
}

class UserIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new DrawerWeiget(),
    );
  }
}

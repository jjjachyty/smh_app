import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class GetVIPPage extends StatefulWidget {
  @override
  _GetVIPPageState createState() => _GetVIPPageState();
}

class _GetVIPPageState extends State<GetVIPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("购买VIP"),
        ),
        body: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "请输入激活码",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.green, //边框颜色为绿色
                            width: 1, //宽度为5
                          )),
                          prefixIcon: Icon(Icons.confirmation_number,
                              color: Colors.red),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.check), onPressed: () {}),
                        ),
                      )),
                ]),
                Text("""如何获得激活码:"""),
                Text("""1.微信扫一扫,5/月,备注留言注册手机号,长按保存二维码."""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onLongPress: () async {
                          PermissionHandler()
                              .requestPermissions(<PermissionGroup>[
                            PermissionGroup.storage, // 在这里添加需要的权限
                          ]);
                          PermissionStatus permission =
                              await PermissionHandler().checkPermissionStatus(
                                  PermissionGroup.storage);
                          if (permission == PermissionStatus.granted) {
                            ByteData bytes =
                                await rootBundle.load('images/weixin.JPG');
                            // final result = await ImageGallerySaver.saveImage(
                            //     bytes.buffer.asUint8List());
                          } else {
                            Fluttertoast.showToast(
                                msg: "请允许访问相册权限",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Image.asset(
                          "images/weixin.JPG",
                          width: 200,
                          height: 200,
                        )),
                  ],
                ),
                Text("""2.加入QQ群 1091923826 购买."""),
                Text("""3.分享我的邀请码注册即可获得VIP."""),
              ],
            )));
  }
}

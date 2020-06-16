import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/user.dart';

var avatar = [
  "images/avatar/aochuang.png",
  "images/avatar/dongrizhanshi.png",
  "images/avatar/elingqishi.png",
  "images/avatar/feihongnvwu.png",
  "images/avatar/fuchouzhelianmeng-gangtiexia.png",
  "images/avatar/fuchouzhelianmeng-haoke.png",
  "images/avatar/fuchouzhelianmeng-heibao.png",
  "images/avatar/fuchouzhelianmeng-heiguafu.png",
  "images/avatar/fuchouzhelianmeng-huanshi.png",
  "images/avatar/fuchouzhelianmeng-leishen.png",
  "images/avatar/fuchouzhelianmeng-lieying.png",
  "images/avatar/fuchouzhelianmeng-meiguoduichang.png",
  "images/avatar/fuchouzhelianmeng-yingyan.png",
  "images/avatar/fuchouzhelianmeng-yiren.png",
  "images/avatar/hanweizhelianmeng-yemoxia.png",
  "images/avatar/honghaoke.png",
  "images/avatar/hongkulou.png",
  "images/avatar/jiaochagu.png",
  "images/avatar/luoji.png",
  "images/avatar/luonan.png",
  "images/avatar/mieba.png",
  "images/avatar/moriboshi.png",
  "images/avatar/qiyiboshi.png",
  "images/avatar/shenqisixia-pilihuo.png",
  "images/avatar/shenqisixia-shenqixiansheng.png",
  "images/avatar/shenqisixia-shitouren.png",
  "images/avatar/shenqisixia-yinxingnvxia.png",
  "images/avatar/yinhehuweidui-gelute.png",
  "images/avatar/yinhehuweidui-huanxionghuojian.png",
  "images/avatar/yinhehuweidui-huimiezhedelakesi.png",
  "images/avatar/yinhehuweidui-qiamola.png",
  "images/avatar/yinhehuweidui-xingjue.png",
  "images/avatar/yirenzu-heifuwang.png",
  "images/avatar/zemonanjue.png",
  "images/avatar/zhengfuzhekang.png"
];

class UserSettingPage extends StatefulWidget {
  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("设置"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Image.network("src"),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      currentUser.Avatar,
                      width: 120,
                      height: 120,
                    ),
                    Wrap(
                      children: avatar.map((f) {
                        return IconButton(
                            icon: Image.asset(
                              f,
                              width: 40,
                              height: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                currentUser.Avatar = f;
                              });
                            });
                      }).toList(),
                    ),
                    TextFormField(
                      initialValue: currentUser.NickName,
                      maxLength: 7,
                      decoration: InputDecoration(labelText: "昵称:"),
                      onSaved: (val) {
                        currentUser.NickName = val;
                      },
                    ),
                    Container(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Radio(
                              value: 0,
                              groupValue: currentUser.Sex,
                              // title: new Text('男'),
                              onChanged: (T) {
                                setState(() {
                                  currentUser.Sex = T;
                                });
                              }),
                          Text("男"),
                          new Radio(
                              value: 1,
                              groupValue: currentUser.Sex,
                              // title: new Text('女'),
                              onChanged: (T) {
                                setState(() {
                                  currentUser.Sex = T;
                                });
                              }),
                          Text("女"),
                        ],
                      ),
                    ),
                    TextFormField(
                      initialValue: currentUser.Introduce,
                      maxLines: 3,
                      maxLength: 14,
                      decoration: InputDecoration(labelText: ("个性签名:")),
                      onSaved: (val) {
                        currentUser.Introduce = val;
                      },
                    ),
                  ],
                ),
              ),

              ProgressButton(
                defaultWidget: const Text(
                  '确认',
                  style: TextStyle(color: Colors.white),
                ),
                progressWidget: const CircularProgressIndicator(),
                color: Theme.of(context).primaryColor,
                width: 196,
                // height: 40,
                onPressed: () async {
                  _formKey.currentState.save();

                  var _resp = await updateInfo(User(
                      ID: currentUser.ID,
                      Sex: currentUser.Sex,
                      Avatar: currentUser.Avatar,
                      NickName: currentUser.NickName,
                      Introduce: currentUser.Introduce));
                  if (_resp.State) {
                    setUser(currentUser);
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(
                        msg: _resp.Message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ],
          ),
        ));
  }
}

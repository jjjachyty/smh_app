import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:smh/common/event_bus.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/user.dart';
import 'package:smh/page/user/index.dart';
import 'package:smh/page/user/register.dart';

import 'login.dart';

class NoLoginPage extends StatefulWidget {
  @override
  _NoLoginPageState createState() => _NoLoginPageState();
}

class _NoLoginPageState extends State<NoLoginPage> {
  var phone;
  var passwd;
  GlobalKey<FormState> _formKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://picsum.photos/400/900?random"),
              fit: BoxFit.fitHeight,
            ),
          ),
          // padding: EdgeInsets.only(top: 200),

          child: Column(
            children: <Widget>[
              // CircleAvatar(
              //   foregroundColor: Colors.red,
              //   backgroundColor: Colors.red,
              //   backgroundImage: AssetImage(
              //     "images/logo.png",
              //   ),
              //   radius: 40,
              // ),
              Text(
                "《 书名号 》",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Text(
                "\n",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Card(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Text.rich(
                        TextSpan(
                            text: "登 录",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginPage()));
                              }),
                      ),
                      Divider(),

                      Text.rich(
                        TextSpan(
                            text: "注 册",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UserRegister()));
                              }),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      // ListTile(
                      //   dense: true,
                      //   leading: Text("微信"),
                      //   subtitle: Text("hyh5290604"),
                      // ),
                      // ListTile(
                      //   dense: true,
                      //   leading: Text("QQ"),
                      //   subtitle: Text("1942056324"),
                      // ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

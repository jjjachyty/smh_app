import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/models/player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VipVideoPage extends StatefulWidget {
  String name;
  String url;
  VipVideoPage(this.name, this.url);
  @override
  _VipVideoPageState createState() => _VipVideoPageState();
}

class _VipVideoPageState extends State<VipVideoPage> {
  // final flutterWebviewPlugin = new FlutterWebviewPlugin();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  var _player = "https://player.gps0476.com/1717yun/?url=";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("""
              1.点击到要看的具体视频页面
              2.点击右上角播放按钮播放
              视频缓冲需要时间
              如果提示服务器加载失败
              点击中间刷新按钮即可
              """),
            );
          });
    });

    getPlayer("1").then((player) {
      setState(() {
        _player = player.URL;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              var controller = (await _controller.future);
              controller.reload();
            }),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              var controller = (await _controller.future);
              if (await controller.canGoBack()) {
                controller.goBack();
              } else {
                Navigator.pop(context);
              }
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.play_circle_filled,
                color: Colors.white,
              ),
              onPressed: () async {
                var controller = (await _controller.future);
                var _url = await controller.currentUrl();

                if (widget.name == "腾讯") {
                  var _uri = Uri.parse(_url);
                  var _cid = _uri.queryParameters['cid'];
                  var _vid = _uri.queryParameters['vid'];
                  if (_vid == "") {
                    _url = "https://v.qq.com/x/cover/" + _cid + ".html";
                  } else {
                    _url = "https://v.qq.com/x/cover/" +
                        _cid +
                        "/" +
                        _vid +
                        ".html";
                  }
                }
                // var _palyUrl =
                //     "https://player.gps0476.com/1717yun/?url=" + _url;
                var _palyUrl = _player + _url;
                await controller.loadUrl(_palyUrl);
              })
        ],
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        gestureNavigationEnabled: true,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https') ||
              request.url.startsWith('http')) {
            return NavigationDecision.navigate;
          } else {
            return NavigationDecision.prevent;
          }
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return new WebviewScaffold(

  //       // appBar: new AppBar(
  //       //   title: Text(widget.name),
  //       //   backgroundColor: Colors.black,
  //       // ),
  //       supportMultipleWindows: true,
  //       withJavascript: true,
  //       // userAgent:
  //       // "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36",
  //       url: widget.url,
  //       withZoom: true,
  //       bottomNavigationBar: Container(
  //           color: Colors.black,
  //           child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 IconButton(
  //                   icon: Icon(
  //                     Icons.arrow_back,
  //                     color: Colors.white,
  //                   ),
  //                   onPressed: () {
  //                     flutterWebviewPlugin.goBack();
  //                   },
  //                 ),
  //                 IconButton(
  //                   icon: Icon(
  //                     Icons.refresh,
  //                     color: Colors.white,
  //                   ),
  //                   onPressed: () {
  //                     flutterWebviewPlugin.reload();
  //                   },
  //                 ),
  //                 IconButton(
  //                   icon: Icon(
  //                     Icons.play_arrow,
  //                     color: Colors.white,
  //                   ),
  //                   onPressed: () {
  //                     flutterWebviewPlugin
  //                         .evalJavascript("window.location.href")
  //                         .then((url) {
  //                       print("url==${url}");
  //                       flutterWebviewPlugin.reloadUrl(
  //                           "https://player.gps0476.com/1717yun/?url=" + url);
  //                     });
  //                   },
  //                 ),
  //                 IconButton(
  //                   icon: Icon(
  //                     Icons.close,
  //                     color: Colors.white,
  //                   ),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                 )
  //               ])),
  //       initialChild: Container(
  //           color: Colors.black,
  //           child: Center(
  //               child: Text(
  //             "加载中",
  //             style: TextStyle(color: Colors.black),
  //           ))));
  // }
}

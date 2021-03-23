import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'init.dart';

class WebViewPage extends StatefulWidget {
  String title;
  String url;
  WebViewPage(this.title, this.url);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    // flutterWebviewPlugin.close();
    super.dispose();
  }

  // void _updateWatching() async {
  //   var history = WatchingHistory(
  //     UserID: currentUser.ID ?? "",
  //     VideoID: widget.resources.VideoID,
  //     ResourcesID: widget.resources.ID,
  //     VideoDuration: 0,
  //     VideoThumbnail: widget.resources.VideoThumbnail,
  //   );
  //   var resp = await getResourceWatch(history);
  //   print(resp);
  //   if (resp.State) {
  //     var _result = WatchingHistory.fromJson(resp.Data);
  //     if (_result.CreateAt == "0001-01-01T00:00:00Z") {
  //       addWatch(history).then((resp) {
  //         print(resp.Message);
  //       });
  //     }
  //   }
  // }

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    // if (widget.movie.ID == null || widget.movie.ID == "") {
    //   movieAdd(widget.movie).then((_resp) {
    //     print(_resp);
    //     if (_resp.State) {
    //       var res = widget.resources;
    //       var moveResult = Video.fromJson(_resp.Data);
    //       res.VideoID = moveResult.ID;
    //       res.VideoThumbnail = moveResult.Cover;
    //       res.State = true;
    //       addResources(res).then((_resp) {
    //         if (_resp.State) {
    //           if (currentUser != null) {
    //             _updateWatching();
    //           }
    //         }
    //       });
    //     }
    //   });
    // }

    // super.initState();
    //  if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();

    print(widget.url);

    //  X5Sdk.openWebActivity(widget.url,title: "web页面");
    return new Scaffold(
        appBar: new AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.black,
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          userAgent:
              "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1",
          gestureNavigationEnabled: true,
        )
        // InAppWebView(
        //           initialUrl: widget.url,
        //           initialHeaders: {
        //           },
        //           initialOptions: InAppWebViewGroupOptions(
        //             crossPlatform: InAppWebViewOptions(
        //                 debuggingEnabled: true,
        //             )
        //           ),
        //           onWebViewCreated: (InAppWebViewController controller) {
        //             webView = controller;
        //           },
        //           onLoadStart: (InAppWebViewController controller, String url) {
        //             setState(() {
        //               this.url = url;
        //             });
        //           },
        //           onLoadStop: (InAppWebViewController controller, String url) async {
        //             setState(() {
        //               this.url = url;
        //             });
        //           },
        //           onProgressChanged: (InAppWebViewController controller, int progress) {
        //             setState(() {
        //               this.progress = progress / 100;
        //             });
        //           },

        //         ),

        );

    // return WebviewScaffold(
    //           url: widget.url,
    //           mediaPlaybackRequiresUserGesture: false,
    //           appBar: AppBar(
    //          title: Text(widget.title),
    //           ),
    //           withZoom: true,
    //           withLocalStorage: true,
    //           hidden: true,
    //           initialChild: Container(
    //             color: Colors.redAccent,
    //             child: const Center(
    //               child: Text('Waiting.....'),
    //             ),
    //           ),);
  }
}

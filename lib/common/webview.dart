import 'dart:async';

import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();

    print(widget.url);
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
          gestureNavigationEnabled: true,
        ));
  }
}

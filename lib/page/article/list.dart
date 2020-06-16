import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/models/article.dart';
import 'package:smh/models/video.dart';
import 'package:smh/page/article/post.dart';
import 'package:zefyr/zefyr.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  ScrollController _scrollController = new ScrollController();
  var pageSize = 0;
  List<Article> articles = new List();

  Future<void> _loadMore() async {
    var resp = await articleList(pageSize);
    if (resp.State) {
      setState(() {
        articles.addAll(resp.Data);
      });
    }
  }

  Future<void> _refresh() async {
    var resp = await articleList(0);
    if (resp.State) {
      setState(() {
        articles = resp.Data;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadMore();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        // 加载更多数据
        setState(() {
          pageSize++;
        });
        _loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 1,
                    child: Container(
                        constraints: BoxConstraints(maxHeight: 150),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                dense: true,
                                title: Text(
                                  articles[index].Title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      "http://smh.apcchis.com/avatar.jpeg"),
                                  maxRadius: 10,
                                ),
                                trailing: Text(
                                  formatDate(
                                      DateTime.parse(articles[index].CreateAt)
                                          .toLocal(),
                                      [
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
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              Divider(),
                              Text(
                                articles[index].Context,
                                maxLines: 3,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FlatButton(
                                      child: Text("举报"),
                                      onPressed: () {
                                        Fluttertoast.showToast(
                                            msg: "举报成功",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIos: 2,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                    )
                                  ])
                            ])),
                  ));
            },
          )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ArticleAddPage();
            }));
          }),
    );
  }
}

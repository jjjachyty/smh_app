// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smh/models/article.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

import 'package:notus/convert.dart';

class ArticleAddPage extends StatefulWidget {
  @override
  _ArticleAddPageState createState() => _ArticleAddPageState();
}

class _ArticleAddPageState extends State<ArticleAddPage> {
  ZefyrController _controller;
  final FocusNode _focusNode = FocusNode();
  GlobalKey<FormState> _fromKey = new GlobalKey();
  Article article;

  @override
  void initState() {
    article = new Article();
    _controller = ZefyrController(NotusDocument());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final form = Form(
      key: _fromKey,
      child: Column(children: [
        TextFormField(
          decoration: InputDecoration(hintText: "标题"),
          validator: (val) {
            if (val == null || val.length == 0) {
              return "还是写个标题吧";
            } else if (val.length > 14) {
              return "标题最长14个字";
            }
          },
          onSaved: (val) {
            article.Title = val;
          },
        ),
        TextFormField(
          validator: (val) {
            if (val == null || val.length == 0) {
              return "还是写点儿内容吧";
            } else if (val.length > 140) {
              return "内容最长140个字";
            }
          },
          maxLines: 6,
          decoration: InputDecoration(hintText: "内容"),
          onSaved: (val) {
            article.Context = val;
          },
        ),
        ListTile(
          leading: IconButton(icon: Icon(Icons.add), onPressed: () {}),
        )
      ]),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("发帖"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "发布",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_fromKey.currentState.validate()) {
                _fromKey.currentState.save();
                // var _delta = _controller.document.toDelta();
                // article.Context = notusMarkdown.encode(_delta);
                // article.Context = json.encode(_controller.document.toJson());
                // news.content = _controller.document.toString();
                var _data = await addArticle(article);
                if (_data.State) {
                  Fluttertoast.showToast(
                      msg: "发布成功",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      timeInSecForIos: 2,
                      fontSize: 16.0);
                  Navigator.pop(context);
                }
              }
            },
          )
        ],
      ),
      body: ZefyrScaffold(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: form,
        ),
      ),
    );
  }

  Widget buildEditor() {
    final theme = ZefyrThemeData(
        // toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        //   color: Colors.grey.shade800,
        //   toggleColor: Colors.grey.shade900,
        //   iconColor: Colors.white,
        //   disabledIconColor: Colors.grey.shade500,
        // ),
        );

    return ZefyrTheme(
      data: theme,
      child: ZefyrField(
        height: 150,
        decoration: InputDecoration(labelText: '请输入'),
        controller: _controller,
        focusNode: _focusNode,
        autofocus: true,
        mode: ZefyrMode.edit,
        // imageDelegate: CustomImageDelegate(),
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}

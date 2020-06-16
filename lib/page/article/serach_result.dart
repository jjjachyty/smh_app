import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/spiders/diaosidao.dart';
import 'package:smh/page/video/apply.dart';
import 'package:smh/page/video/profile.dart';

class SerachResultPage extends StatefulWidget {
  String keyWords;
  SerachResultPage(this.keyWords);
  @override
  _SerachResultPageState createState() => _SerachResultPageState();
}

class _SerachResultPageState extends State<SerachResultPage> {
  List<Video> videos;
  bool appalyFlag = false;

  Widget _item(Video movie) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          height: 150,
          // width: 100,
          child: new Image.network(
            movie.Cover,
            width: 100,
            // fit: BoxFit.cover,
          ),
        ),
        Expanded(
            child: Table(
          //所有列宽
          columnWidths: const {
            //列宽
            0: FixedColumnWidth(1.0),
            1: FixedColumnWidth(150.0),
          },
          //表格边框样式

          children: [
            TableRow(children: [
              Text("名字"),
              Text(movie.Name),
            ]),
            TableRow(children: [
              Text("地区"),
              Text(movie.Region),
            ]),
            TableRow(children: [
              Text("年代"),
              Text(movie.Years),
            ]),
            TableRow(children: [
              Text("类型"),
              Text(movie.Genre),
            ]),
            TableRow(children: [
              Text("导演"),
              Text(movie.Director),
            ]),
            TableRow(children: [
              Text("主演"),
              Text(movie.Actor),
            ])
          ],
        ))
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    serach(widget.keyWords).then((resp) async {
      if (resp.State) {
        setState(() {
          videos = resp.Data;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (videos == null) {
      return Center(child: Text("搜索中...."));
    }

    if (videos.length == 0) {
      return Text.rich(TextSpan(text: "这都没搜索到,还是让管理员出手吧", children: [
        TextSpan(
            text: "  去求片",
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ApplyVideoPage(widget.keyWords)));
              }),
      ]));
    }

    if (videos.length > 0) {
      return Column(
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.all(8),
          //   child: Text.rich(TextSpan(text: "没有想要的?,你可以", children: [
          //     TextSpan(
          //         text: "  点我",
          //         style: TextStyle(color: Colors.blue),
          //         recognizer: TapGestureRecognizer()
          //           ..onTap = () async {
          //             setState(() {
          //               serachFlag = true;
          //             });

          //             var _result = await dsdSerach(widget.keyWords);
          //             if (_result.length > 0) {
          //               setState(() {
          //                 serachFlag = false;

          //                 videos = _result;
          //               });
          //             } else {
          //               setState(() {
          //                 serachFlag = false;

          //                 appalyFlag = true;
          //               });
          //             }
          //           }),
          //   ])),
          // ),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, i) => Divider(),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: _item(videos[index]),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return VideoProfilePage(videos[index]);
                  }));
                },
              );
            },
          )),
        ],
      );
    } else {
      return Text("搜索中....");
    }
    // else {
    //   return Center(
    //     child: Text.rich(TextSpan(text: "我还未搜录相关电影,你可以", children: [
    //       TextSpan(
    //           text: "  点我",
    //           style: TextStyle(color: Colors.blue),
    //           recognizer: TapGestureRecognizer()
    //             ..onTap = () async {
    //               setState(() {
    //                 serachFlag = true;
    //               });

    //               var _result = await dsdSerach(widget.keyWords);
    //               if (_result.length > 0) {
    //                 setState(() {
    //                   serachFlag = false;

    //                   videos = _result;
    //                 });
    //               } else {
    //                 setState(() {
    //                   serachFlag = false;

    //                   appalyFlag = true;
    //                 });
    //               }
    //             }),
    //     ])),
    //   );
    // }
  }
}

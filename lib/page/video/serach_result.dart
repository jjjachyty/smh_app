import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/common/init.dart';
import 'package:smh/common/utils.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/spiders/diaosidao.dart';
import 'package:smh/models/user.dart';
import 'package:smh/page/video/apply.dart';
import 'package:smh/page/video/profile.dart';
import 'package:smh/page/user/login.dart';

class SerachResultPage extends StatefulWidget {
  String keyWords;
  SerachResultPage(this.keyWords);
  @override
  _SerachResultPageState createState() => _SerachResultPageState();
}

class _SerachResultPageState extends State<SerachResultPage> {
  List<Video> videos;
  ScrollController _scrollController = ScrollController(); //listview的控制器
  int _page = 1; //加载的页数
  bool isLoading = false; //是否正在加载数据
  bool _nodata = false;

  bool appalyFlag = false;

  Widget _item(Video movie) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          height: 150,
          width: 120,
          child: new Image.network(
            movie.Cover,
            fit: BoxFit.fill,
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
            movie.Director == ""
                ? TableRow(children: [Text(""), Text("")])
                : TableRow(children: [
                    Text("导演"),
                    Text(movie.Director),
                  ]),
            movie.Actor == ""
                ? TableRow(children: [Text(""), Text("")])
                : TableRow(children: [
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
    _getMore();

    _scrollController.addListener(() {
      if (!_nodata &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _getMore();
      }
    });

    super.initState();
  }

  _getMore() {
    setState(() {
      _nodata = false;
      isLoading = true;
    });
// TODO: implement initState
    serach(widget.keyWords, _page).then((resp) async {
      if (resp.State) {
        setState(() {
          isLoading= false;
          if (videos == null) {
            videos = resp.Data;
            return;
          }
          if (resp.Data != null && resp.Data.length != 0) {
             if (resp.Data.length < 6) {
              _nodata = true;
            }
            videos.addAll(resp.Data);
           
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (videos == null) {
      return Center(child: Text("搜索中...."));
    }

    if (videos.length == 0) {
      return Text.rich(TextSpan(text: "这都没搜索到,还是让管理员出手吧", children: [
        TextSpan(
            text: "  去留言",
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
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, i) => Divider(),
            itemCount: videos.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: _item(videos[index]),
                onTap: () async {
                  // if (currentUser == null) {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) {
                  //     return LoginPage();
                  //   }));
                  // } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return VideoProfilePage(videos[index]);
                    }));
                  // }
                },
              );
            },
          )),
          _nodata
              ? Text(
                  "已全部加载",
                  style: TextStyle(color: Colors.grey),
                )
              : isLoading?Text("加载中...."):Text("")
        ],
      );
    } else {
      return Text("搜索中....");
    }
  }
}

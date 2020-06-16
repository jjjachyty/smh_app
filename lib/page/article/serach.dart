import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/spiders/diaosidao.dart';
import 'package:smh/page/video/apply.dart';
import 'package:smh/page/video/profile.dart';

import 'serach_result.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  SearchBarDelegate({
    String hintText,
  }) : super(
          searchFieldLabel: "请输入电影名称/演员",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );
  //重寫交叉按鈕清空數據
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      )
    ];
  }

  //重寫左邊按鈕
  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, //動態圖表
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  //重寫返回結果
  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return SerachResultPage(query.toString());
    } else {
      return _suggestions();
    }
  }

  //推薦
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: movieRecommend(),
      builder: (context, shot) {
        if (shot.hasData) {
          var videos = shot.data.Data as List<Video>;
          return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      query = videos[index].Name;
                    },
                    title: Text(
                      videos[index].Name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(videos[index].ScoreDB.toString() + "分",
                        style: TextStyle(color: Colors.yellow.shade900)),
                  ));
        } else {
          return Text("data");
        }
      },
    );

    // TODO: implement buildSuggestions
  }

  Widget _suggestions() {
    return Wrap(
      children: <Widget>[
        OutlineButton(
          child: Text("data"),
        )
      ],
    );
  }
}

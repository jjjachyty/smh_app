import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/models/comment.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/user.dart';
import 'package:smh/models/watch_history.dart';
import 'package:smh/page/video/profile.dart';

class UserCommentPage extends StatefulWidget {
  int userID;
  UserCommentPage(this.userID);
  @override
  _UserCommentPageState createState() => _UserCommentPageState();
}

class _UserCommentPageState extends State<UserCommentPage> {
  int pageSize = 0;
  List<Comment> comments = new List();
  ScrollController _scrollController = new ScrollController();

  _loadMore() {
    userComments(pageSize, widget.userID).then((resp) {
      if (resp.State) {
        setState(() {
          comments.addAll(resp.Data);
        });
      }
    });
  }

  @override
  void initState() {
    _loadMore();
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(_scrollController.position.userScrollDirection.index);

        if (_scrollController.position.userScrollDirection.index == 2) {
          print("2");
          setState(() {
            pageSize++;
          });
          //下一页
        } else {
          //上一页
          setState(() {
            pageSize--;
          });
        }
        _loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, i) => Divider(),
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            comments[index].Content,
            // style: TextStyle(color: Colors.grey),
          ),
          trailing: Image.network(
            comments[index].VideoThumbnail,
            fit: BoxFit.fill,
          ),
          // subtitle: ListTile(
          //   leading: Text(comments[index].VideoName),
          //   trailing: Image.network(
          //     comments[index].VideoThumbnail,
          //     height: 20,
          //     width: 20,
          //   ),
          // ),
          onTap: () async {
            var resp = await movieGet(comments[index].VideoID);
            if (resp.State) {
              if (resp.Data.ID != "") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            VideoProfilePage(resp.Data)));
              } else {
                Fluttertoast.showToast(
                    msg: "该资源已被他人删除,无法再继续观看",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          },
        );

        // return ListTile(
        //   leading: CachedNetworkImage(imageUrl: comments[index].Cover),
        //   title: Text(comments[index].Name),
        //   subtitle: Text(comments[index].CreateAt),
        //   trailing: IconButton(
        //       icon: Icon(Icons.remove_circle), onPressed: () {}),
        //   onTap: () async {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (BuildContext context) =>
        //                 VideoIndexPage(comments[index])));
        //   },
        // );
      },
    );
  }
}

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/comment.dart';
import 'package:smh/models/video.dart';
import 'package:smh/page/user/login.dart';

//安卓:http://suo.im/6eS7XP
class VideoCommentPage extends StatefulWidget {
  Video movie;
  VideoCommentPage(this.movie);

  @override
  _VideoCommentPageState createState() => _VideoCommentPageState();
}

class _VideoCommentPageState extends State<VideoCommentPage> {
  int pageSize = 0;
  List<Comment> comments = new List();
  String content = "";
  var _contentErr;
  GlobalKey<FormFieldState> _key = new GlobalKey();
  ScrollController _scrollController = new ScrollController();
  var _id = currentUser == null ? "" : currentUser.ID;
  _loadMore() {
    if (widget.movie.ID != null) {
      commentList(
        pageSize,
        widget.movie.ID,
      ).then((resp) {
        if (resp.State) {
          setState(() {
            comments.addAll(resp.Data);
          });
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(_scrollController.position.userScrollDirection.index);

        if (_scrollController.position.userScrollDirection.index == 2) {
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
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          isThreeLine: false,
          leading: Text("评论"),
          trailing: IconButton(
            icon: Icon(
              Icons.message,
              color: Colors.red,
            ),
            onPressed: () {
              print(currentUser);
              if (currentUser == null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
                return;
              }
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                isDismissible: true,
                useRootNavigator: true,
                builder: (BuildContext context) {
                  return new SingleChildScrollView(
                      child: AnimatedPadding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  15),
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.decelerate,
                          child: Column(
                            // contentPadding: EdgeInsets.all(8),
                            children: <Widget>[
                              TextFormField(
                                key: _key,
                                textInputAction: TextInputAction.send,
                                maxLength: 140,
                                maxLines: 3,
                                autofocus: true,
                                onSaved: (val) {
                                  setState(() {
                                    content = val;
                                  });
                                },
                                validator: (val) {
                                  if (val.length < 10) {
                                    return "就这样字字如金吗?多说点儿吧";
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "请说",
                                    errorText: _contentErr,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    )),
                                onFieldSubmitted: (vale) async {
                                  if (_key.currentState.validate()) {
                                    _key.currentState.save();
                                    var ct = Comment(
                                        VideoID: widget.movie.ID,
                                        VideoName: widget.movie.Name,
                                        VideoThumbnail: widget.movie.Cover,
                                        Sender: _id,
                                        SenderAvatar: currentUser.Avatar,
                                        Content: content,
                                        LikeCount: 0,
                                        UnLikeCount: 0,
                                        Likes: [],
                                        UnLikes: []);
                                    var _resp = await addComment(ct);
                                    if (_resp.State) {
                                      setState(() {
                                        _contentErr = null;
                                        comments.insert(
                                            0, Comment.fromJson(_resp.Data));
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      setState(() {
                                        _contentErr = _resp.Message;
                                      });
                                    }
                                  }
                                },
                              ),
                            ],
                          )));
                },
              );
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, i) => Divider(),
            controller: _scrollController,
            itemCount: comments.length,
            itemBuilder: (c, index) {
              return Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  new AssetImage(comments[index].SenderAvatar),
                            ),
                            Text(
                              comments[index].CreateAt == null
                                  ? "刚刚"
                                  : formatDate(
                                      DateTime.parse(comments[index].CreateAt)
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
                              style: TextStyle(fontSize: 8),
                            ),
                            Spacer(),
                            FlatButton.icon(
                              icon: Icon(Icons.thumb_up,
                                  size: 15,
                                  color: comments[index].Likes != null &&
                                          comments[index].Likes.contains(_id)
                                      ? Colors.red
                                      : Colors.grey),
                              label: Text(comments[index].LikeCount.toString()),
                              onPressed: () async {
                                comments[index].Likes == null
                                    ? comments[index].Likes = new List<String>()
                                    : Null;
                                comments[index].UnLikes == null
                                    ? comments[index].UnLikes =
                                        new List<String>()
                                    : Null;

                                if (comments[index].Likes.contains(_id)) {
                                  var _resp = await commentLikeCancel(
                                      comments[index].ID, _id);
                                  if (_resp.State) {
                                    setState(() {
                                      comments[index].LikeCount--;
                                      comments[index].Likes.remove(_id);
                                    });
                                  }
                                  return;
                                }
                                var _resp =
                                    await commentLike(comments[index].ID, _id);
                                if (_resp.State) {
                                  setState(() {
                                    comments[index].LikeCount++;
                                    comments[index].Likes.add(_id);
                                  });

                                  //判断是否踩过
                                  if (comments[index].UnLikes.contains(_id)) {
                                    var _resp = await commentUnLikeCancel(
                                        comments[index].ID, _id);
                                    if (_resp.State) {
                                      setState(() {
                                        comments[index].UnLikeCount--;
                                        comments[index].UnLikes.remove(_id);
                                      });
                                    }
                                  }
                                }
                              },
                            ),
                            FlatButton.icon(
                              icon: Icon(
                                Icons.thumb_down,
                                size: 15,
                                color: comments[index].UnLikes != null &&
                                        comments[index].UnLikes.contains(_id)
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              label:
                                  Text(comments[index].UnLikeCount.toString()),
                              onPressed: () async {
                                comments[index].Likes == null
                                    ? comments[index].Likes = new List<String>()
                                    : Null;
                                comments[index].UnLikes == null
                                    ? comments[index].UnLikes =
                                        new List<String>()
                                    : Null;

                                if (comments[index].UnLikes.contains(_id)) {
                                  var _resp = await commentUnLikeCancel(
                                      comments[index].ID, _id);
                                  if (_resp.State) {
                                    setState(() {
                                      comments[index].UnLikeCount--;
                                      comments[index].UnLikes.remove(_id);
                                    });
                                  }
                                  return;
                                }
                                var _resp = await commentUnLike(
                                    comments[index].ID, _id);
                                if (_resp.State) {
                                  setState(() {
                                    comments[index].UnLikeCount++;
                                    comments[index].UnLikes.add(_id);
                                  });
                                  //判断是否赞过
                                  if (comments[index].Likes.contains(_id)) {
                                    var _resp = await commentLikeCancel(
                                        comments[index].ID, _id);
                                    if (_resp.State) {
                                      setState(() {
                                        comments[index].LikeCount--;
                                        comments[index].Likes.remove(_id);
                                      });
                                    }
                                  }
                                }
                              },
                            ),
                            // FlatButton(
                            //   child: Text("回复"),
                            //   onPressed: () {
                            //                        if (currentUser == null) {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //     return LoginPage();
                            //   }));
                            //   return;
                            // }
                            //     showDialog<Null>(
                            //       context: context,
                            //       builder: (BuildContext context) {
                            //         return new SimpleDialog(
                            //           contentPadding: EdgeInsets.all(8),
                            //           children: <Widget>[
                            //             TextFormField(
                            //               key: _key,
                            //               maxLength: 140,
                            //               maxLines: 3,
                            //               onSaved: (val) {
                            //                 setState(() {
                            //                   content = val;
                            //                 });
                            //               },
                            //               validator: (val) {
                            //                 if (val.length < 10) {
                            //                   return "就这样字字如金吗?多说点儿吧";
                            //                 }
                            //               },
                            //               decoration: InputDecoration(
                            //                   hintText: "请说",
                            //                   errorText: _contentErr,
                            //                   border: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(15.0),
                            //                   )),
                            //             ),
                            //             ProgressButton(
                            //               defaultWidget: const Text(
                            //                 '���定',
                            //                 style:
                            //                     TextStyle(color: Colors.white),
                            //               ),
                            //               progressWidget:
                            //                   const CircularProgressIndicator(),
                            //               color: Theme.of(context).primaryColor,
                            //               width: 196,
                            //               height: 40,
                            //               onPressed: () async {
                            //                 if (_key.currentState.validate()) {
                            //                   _key.currentState.save();
                            //                   var ct = Comment(
                            //                       VideoID: widget.movie.ID,
                            //                       Sender: _id,
                            //                       Content: content,
                            //                       LikeCount: 0,
                            //                       UnLikeCount: 0,
                            //                       Receiver:
                            //                           comments[index].Sender,
                            //                       RefID: comments[index].ID,
                            //                       Likes: [],
                            //                       UnLikes: []);
                            //                   var _resp = await addComment(ct);
                            //                   if (_resp.State) {
                            //                     setState(() {
                            //                       _contentErr = null;
                            //                       comments.insert(0, ct);
                            //                       Navigator.pop(context);
                            //                     });
                            //                   } else {
                            //                     setState(() {
                            //                       _contentErr = _resp.Message;
                            //                     });
                            //                   }
                            //                 }
                            //               },
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //     );
                            //   },
                            // )
                          ]),
                      Text.rich(
                        TextSpan(
                          text: comments[index].Content,
                          style: TextStyle(),
                        ),
                        maxLines: 3,
                      ),
                    ]),
              );
            },
          ),
        )
      ],
    );
  }
}

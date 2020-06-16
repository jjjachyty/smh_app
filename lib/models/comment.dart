import 'package:json_annotation/json_annotation.dart';
import 'package:smh/common/dio.dart';

part 'comment.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Comment {
  String ID;
  String VideoID;
  String VideoName;
  String VideoThumbnail;
  String Content;
  String Sender;
  String SenderAvatar;
  String Receiver;
  String RefID;
  String RefMainID;
  int LikeCount;
  int UnLikeCount;
  List<String> Likes;
  List<String> UnLikes;
  List<String> At;
  String CreateAt;

  Comment({
    this.ID,
    this.VideoID,
    this.VideoName,
    this.VideoThumbnail,
    this.Content,
    this.Sender,
    this.SenderAvatar,
    this.Receiver,
    this.RefMainID,
    this.RefID,
    this.LikeCount,
    this.UnLikeCount,
    this.Likes,
    this.UnLikes,
    this.At,
    this.CreateAt,
  });
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

List<Comment> toList(List list) {
  List<Comment> comments = new List();
  if (list != null) {
    list.forEach((e) {
      comments.add(Comment.fromJson(e));
    });
  }
  return comments;
}

Future<Response> addComment(Comment ct) {
  return post("/comment/add", ct.toJson());
}

Future<Response> commentLike(String id, String userID) {
  return post("/comment/like", {"ID": id, "UserID": userID});
}

Future<Response> commentLikeCancel(String id, String userID) {
  return post("/comment/likecancel", {"ID": id, "UserID": userID});
}

Future<Response> commentUnLike(String id, String userID) {
  return post("/comment/unlike", {"ID": id, "UserID": userID});
}

Future<Response> commentUnLikeCancel(String id, String userID) {
  return post("/comment/unlikecancel", {"ID": id, "UserID": userID});
}

Future<Response> commentList(int pageSize, String movieID) async {
  print("movieID=${movieID}");
  var resp = await get("/comment/list?movieid=" +
      movieID +
      "&offset=" +
      (pageSize * 15).toString());
  if (resp.State) {
    resp.Data = toList(resp.Data);
  }
  return resp;
}

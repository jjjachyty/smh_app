import 'package:json_annotation/json_annotation.dart';
import 'package:smh/common/dio.dart';

part 'follow.g.dart';

@JsonSerializable()
class Follow {
  String ID;
  int UserID;
  int FollowID;
  String FollowName;
  String FollowAvatar;
  String CreateAt;
  Follow(
      {this.ID,
      this.UserID,
      this.FollowID,
      this.FollowName,
      this.FollowAvatar,
      this.CreateAt});
  //不同的类使用不同的mixin即可
  factory Follow.fromJson(Map<String, dynamic> json) => _$FollowFromJson(json);
  Map<String, dynamic> toJson() => _$FollowToJson(this);
}

List<Follow> toFollowList(List list) {
  List<Follow> videos = new List();
  if (list != null) {
    list.forEach((e) {
      videos.add(Follow.fromJson(e));
    });
  }
  return videos;
}

Future<Response> addFollow(Follow follow) {
  return post("/user/followadd", follow.toJson());
}

Future<Response> removeFollow(int followID) {
  return post("/user/followremove", {"FollowID": followID});
}

Future<bool> checkFollow(int followID) async {
  var _resp =
      await get("/user/followcheck", parameters: {"FollowID": followID});
  if (_resp.State && Follow.fromJson(_resp.Data).ID != "") {
    return true;
  }
  return false;
}

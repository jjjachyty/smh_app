import 'package:json_annotation/json_annotation.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/common/init.dart';

part 'watch_history.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class WatchingHistory {
  int UserID;
  String VideoID;
  String VideoName;
  String VideoThumbnail;
  double VideoDuration;
  String ResourcesID;
  String ResourcesName;

  double Progress;
  bool Finish;
  String CreateAt;
  WatchingHistory({
    this.UserID,
    this.VideoID,
    this.VideoName,
    this.VideoThumbnail,
    this.VideoDuration,
    this.Progress,
    this.ResourcesID,
    this.ResourcesName,
    this.Finish,
    this.CreateAt,
  });
  factory WatchingHistory.fromJson(Map<String, dynamic> json) =>
      _$WatchingHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$WatchingHistoryToJson(this);
}

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Watching {
  String VideoID;
  String VideoThumbnail;
  int Count;
  Watching({
    this.VideoID,
    this.VideoThumbnail,
    this.Count,
  });
  factory Watching.fromJson(Map<String, dynamic> json) =>
      _$WatchingFromJson(json);
  Map<String, dynamic> toJson() => _$WatchingToJson(this);
}

List<Watching> toWatchingList(List list) {
  List<Watching> watchings = new List();
  if (list != null) {
    list.forEach((e) {
      watchings.add(Watching.fromJson(e));
    });
  }
  return watchings;
}

List<WatchingHistory> toList(List list) {
  List<WatchingHistory> videos = new List();
  if (list != null) {
    list.forEach((e) {
      videos.add(WatchingHistory.fromJson(e));
    });
  }
  return videos;
}

Future<Response> addWatch(WatchingHistory history) async {
  return post("/video/addwatch", history.toJson());
}

Future<Response> updateWatch(WatchingHistory history) async {
  return post("/video/updatewatch", history.toJson());
}

Future<Response> getResourceWatch(WatchingHistory history) async {
  return post("/video/watch", history.toJson());
}

Future<Response> watchingList() async {
  var resp = await get("/video/watching");
  if (resp.State) {
    resp.Data = toWatchingList(resp.Data);
  }
  return resp;
}

Future<Response> getResourceWatchs(int offset, int userid) async {
  var path = "/video/watchs?offset=" +
      (offset * 15).toString() +
      "&UserID=" +
      userid.toString();

  var resp = await get(path);
  if (resp.State) {
    resp.Data = toList(resp.Data);
  }
  return resp;
}

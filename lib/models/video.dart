import 'package:json_annotation/json_annotation.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/spiders/diaosidao.dart';
// user.g.dart 将在我们运行生成命令后自动生成
part 'video.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Video {
  String ID;
  String Name;
  String Cover;
  String Years;
  String Region;
  int ScoreDB;
  String Genre;
  String Director;
  String Actor;
  String CreateAt;
  int CreateBy;
  String UpdateAt;
  String playURL;
  String DetailURL;
  int pltform;
  Video({
    this.ID,
    this.Name,
    this.Cover,
    this.Years,
    this.Region,
    this.ScoreDB,
    this.Director,
    this.Actor,
    this.CreateAt,
    this.UpdateAt,
    this.Genre,
    this.pltform,
    this.playURL,
    this.DetailURL,
    this.CreateBy,
  });
  //不同的类使用不同的mixin即可
  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

List<Video> toList(List list) {
  List<Video> videos = new List();
  if (list != null) {
    list.forEach((e) {
      videos.add(Video.fromJson(e));
    });
  }
  return videos;
}

Future<Response> newestVideo() async {
  var resp = await get("/video/newest");
  if (resp.State) {
    resp.Data = toList(resp.Data);
  }
  return resp;
}

Future<Response> movieRecommend() async {
  var resp = await get("/video/recommend");
  if (resp.State) {
    resp.Data = toList(resp.Data);
  }
  return resp;
}

Future<Response> movieList(int pageSize) async {
  var resp = await get("/video/all?offset=" + pageSize.toString());
  if (resp.State) {
    resp.Data = toList(resp.Data);
  }
  return resp;
}

Future<Response> movieGet(String id) async {
  var resp = await get("/video/get?id=" + id);
  if (resp.State) {
    resp.Data = Video.fromJson(resp.Data);
  }
  return resp;
}

Future<Response> movieAdd(Video movie) async {
  return await post("/video/add", movie.toJson());
}

Future<Response> movieRemove(String id) async {
  return await delete("/video/id/" + id);
}

Future<Response> serach(String key,int page) async {
  var resp = await get("/video/serach?key=" + key);
  List<Video> locationList = List<Video>();
  if (resp.State) {
    locationList = toList(resp.Data);
    // 查询屌丝岛
  }
  if (currentUser != null && currentUser.ID != 1) {
    var onlineList = await dsdSerach(key,page);
    if (onlineList.length > 0) {
      onlineList.forEach((f) {
        locationList.forEach((e) {
          // print("${e.Name} ==== ${f.Name} === ${e.Director}=== ${f.Director}");
          if (e.Name == f.Name && e.Director == f.Director) {
            f = e;
          }
        });
      });
    }
    resp.Data = onlineList;
  } else {
    resp.Data = locationList;
  }

  return resp;
}

Future<Response> userCreate(int offset, int userid) async {
  var path = "/user/moviecreate";

  var resp = await get(path,
      parameters: {"offset": (offset * 15), "CreateBy": userid});
  if (resp.State) {
    resp.Data = toList(resp.Data);
  }
  return resp;
}

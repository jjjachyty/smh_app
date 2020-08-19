import 'package:json_annotation/json_annotation.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/models/spiders/diaosidao.dart';

import 'video.dart';
// user.g.dart 将在我们运行生成命令后自动生成
part 'resources.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class VideoResources {
  String ID;
  String Platform;
  String Name;
  String VideoID;
  String VideoThumbnail;
  String URL;
  String ResourcesID;
  bool State;
  VideoResources(
      {this.ID,
      this.Name,
      this.Platform,
      this.VideoThumbnail,
      this.VideoID,
      this.URL,
      this.ResourcesID,
      this.State});
  //不同的类使用不同的mixin即可
  factory VideoResources.fromJson(Map<String, dynamic> json) =>
      _$VideoResourcesFromJson(json);
  Map<String, dynamic> toJson() => _$VideoResourcesToJson(this);
}

List<VideoResources> toList(List list) {
  List<VideoResources> movieResourcess = new List();
  if (list != null) {
    list.forEach((e) {
      var _res = VideoResources.fromJson(e);
      movieResourcess.add(_res);
    });
  }
  return movieResourcess;
}

Future<Response> movieResources(String id) async {
  var resp = await get("/video/resources/" + id);
  if (resp.State) {
    resp.Data = toList(resp.Data);
  }
  return resp;
}

Future<Response> addResources(VideoResources resources) async {
  return await post("/video/addresources", resources.toJson());
}

Future<Map<String,List<VideoResources>>> getResources(Video movie) async {
  Map<String,List<VideoResources>> results = new Map<String,List<VideoResources>>(); 
 List<VideoResources> list;
  // if (movie.ID != null) {
  //   var _resp = await movieResources(movie.ID);
  //   if (_resp.State) {
  //     list = _resp.Data as List<VideoResources>;
  //   }
  // }
  // if (movie.DetailURL == null || movie.DetailURL == "") {
  //    list.forEach((element) { 
  //      results[element.Platform].add(element);
  //    });
  //    return results;
  // }

  //从第三方来
  results = (await resources(movie.DetailURL));
  // if (list == null || list.length == 0) {
  //   //本地没有 直接返回在线的
  //   return results;
  // }
  // var _tmp = new List<VideoResources>();
  // results.values.forEach((element) {
  //   element.forEach((element1) { 
  //     list.forEach((element2) { 
  //       if (element1.Name == element2.Name){
  //         element1 = element2;
  //       }
  //     });
      
  //   });
  //  });
  // list.addAll(_tmp);
  return results;
}

import 'package:json_annotation/json_annotation.dart';
import 'package:smh/common/dio.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  String ID;
  String Title;
  String Context;
  String CreateAt;
  String CreateBy;
  Article({this.Title, this.ID, this.Context, this.CreateAt, this.CreateBy});
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

Future<Response> addArticle(Article article) async {
  var resp = await post("/article/add", article.toJson());
  return resp;
}

Future<Response> articleList(int offset) async {
  offset = offset * 15;
  var resp = await get("/article/list?offset=" + offset.toString());
  if (resp.State) {
    resp.Data = toList(resp.Data);
  }
  return resp;
}

Future<Response> myArticle(int offset) async {
  offset = offset * 15;
  var resp = await get("/article/my?offset=" + offset.toString());
  if (resp.State) {
    resp.Data = toList(resp.Data);
  }
  return resp;
}

Future<Response> articleRemove(Article article) async {
  var resp = await post("/article/remove", article.toJson());
  return resp;
}

List<Article> toList(List list) {
  List<Article> videos = new List();
  if (list != null) {
    list.forEach((e) {
      videos.add(Article.fromJson(e));
    });
  }
  return videos;
}

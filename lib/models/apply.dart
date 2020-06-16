import 'package:json_annotation/json_annotation.dart';
import 'package:smh/common/dio.dart';

part 'apply.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Apply {
  String ID;
  String Name;
  String Describe;
  List<String> Users;
  bool State;
  String CreateAt;
  String UpdateAt;
  Apply(
      {this.ID,
      this.Name,
      this.Describe,
      this.State,
      this.CreateAt,
      this.UpdateAt,
      this.Users});

  //不同的类使用不同的mixin即可
  factory Apply.fromJson(Map<String, dynamic> json) => _$ApplyFromJson(json);
  Map<String, dynamic> toJson() => _$ApplyToJson(this);
}

List<Apply> applyList(List list) {
  List<Apply> applys = new List();
  if (list != null) {
    list.forEach((e) {
      applys.add(Apply.fromJson(e));
    });
  }
  return applys;
}

Future<String> addApply(Apply apply) async {
  var resp = await post("/video/apply", apply);

  if (!resp.State) {
    if (resp.Message.contains("duplicate key")) {
      return "已有人求过该片了";
    }
    return resp.Message;
  }
}

Future<Response> getApplys() async {
  var resp = await get("/video/applys");
  if (resp.State) {
    resp.Data = applyList(resp.Data);
  }
  return resp;
}

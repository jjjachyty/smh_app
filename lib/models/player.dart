import 'package:json_annotation/json_annotation.dart';
import 'package:smh/common/dio.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  String ID;
  String Name;
  String URL;
  Player({this.ID, this.Name, this.URL});
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}

Future<Player> getPlayer(String id) async {
  Player player;
  var _resp = await get("/player", parameters: {"id": id});
  if (_resp.State) {
    player = Player.fromJson(_resp.Data);
  }

  return player;
}

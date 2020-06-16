import 'package:dio/dio.dart' as dio;
import 'package:smh/common/dio.dart';
import 'package:smh/common/init.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Version {
  String VersionCode;
  String ReleaseTime;
  String ReleaseNote;
  String DownloadURL;

  Version({
    this.VersionCode,
    this.ReleaseTime,
    this.ReleaseNote,
    this.DownloadURL,
  });
  factory Version.fromJson(Map<String, dynamic> json) =>
      _$VersionFromJson(json);
  Map<String, dynamic> toJson() => _$VersionToJson(this);
}

Future<Response> getVersion(String platform) async {
  var response = await get("/base/version", parameters: {"platform": platform});
  if (response.State) {
    print(response.Data);
    newestVersion = Version.fromJson(response.Data);
  }
}

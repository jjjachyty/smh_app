// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Version _$VersionFromJson(Map<String, dynamic> json) {
  return Version(
    VersionCode: json['VersionCode'] as String,
    ReleaseTime: json['ReleaseTime'] as String,
    ReleaseNote: json['ReleaseNote'] as String,
    DownloadURL: json['DownloadURL'] as String,
  );
}

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'VersionCode': instance.VersionCode,
      'ReleaseTime': instance.ReleaseTime,
      'ReleaseNote': instance.ReleaseNote,
      'DownloadURL': instance.DownloadURL,
    };

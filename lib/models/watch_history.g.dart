// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchingHistory _$WatchingHistoryFromJson(Map<String, dynamic> json) {
  return WatchingHistory(
    UserID: json['UserID'] as int,
    VideoID: json['VideoID'] as String,
    VideoName: json['VideoName'] as String,
    VideoThumbnail: json['VideoThumbnail'] as String,
    VideoDuration: (json['VideoDuration'] as num)?.toDouble(),
    Progress: (json['Progress'] as num)?.toDouble(),
    ResourcesID: json['ResourcesID'] as String,
    ResourcesName: json['ResourcesName'] as String,
    Finish: json['Finish'] as bool,
    CreateAt: json['CreateAt'] as String,
  );
}

Map<String, dynamic> _$WatchingHistoryToJson(WatchingHistory instance) =>
    <String, dynamic>{
      'UserID': instance.UserID,
      'VideoID': instance.VideoID,
      'VideoName': instance.VideoName,
      'VideoThumbnail': instance.VideoThumbnail,
      'VideoDuration': instance.VideoDuration,
      'ResourcesID': instance.ResourcesID,
      'ResourcesName': instance.ResourcesName,
      'Progress': instance.Progress,
      'Finish': instance.Finish,
      'CreateAt': instance.CreateAt,
    };

Watching _$WatchingFromJson(Map<String, dynamic> json) {
  return Watching(
    VideoID: json['VideoID'] as String,
    VideoThumbnail: json['VideoThumbnail'] as String,
    Count: json['Count'] as int,
  );
}

Map<String, dynamic> _$WatchingToJson(Watching instance) => <String, dynamic>{
      'VideoID': instance.VideoID,
      'VideoThumbnail': instance.VideoThumbnail,
      'Count': instance.Count,
    };

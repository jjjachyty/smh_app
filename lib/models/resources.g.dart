// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resources.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoResources _$VideoResourcesFromJson(Map<String, dynamic> json) {
  return VideoResources(
    ID: json['ID'] as String,
    Name: json['Name'] as String,
    VideoThumbnail: json['VideoThumbnail'] as String,
    VideoID: json['VideoID'] as String,
    URL: json['URL'] as String,
    ResourcesID: json['ResourcesID'] as String,
    State: json['State'] as bool,
  );
}

Map<String, dynamic> _$VideoResourcesToJson(VideoResources instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'Name': instance.Name,
      'VideoID': instance.VideoID,
      'VideoThumbnail': instance.VideoThumbnail,
      'URL': instance.URL,
      'ResourcesID': instance.ResourcesID,
      'State': instance.State,
    };

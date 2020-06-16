// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    ID: json['ID'] as String,
    VideoID: json['VideoID'] as String,
    VideoName: json['VideoName'] as String,
    VideoThumbnail: json['VideoThumbnail'] as String,
    Content: json['Content'] as String,
    Sender: json['Sender'] as String,
    SenderAvatar: json['SenderAvatar'] as String,
    Receiver: json['Receiver'] as String,
    RefMainID: json['RefMainID'] as String,
    RefID: json['RefID'] as String,
    LikeCount: json['LikeCount'] as int,
    UnLikeCount: json['UnLikeCount'] as int,
    Likes: (json['Likes'] as List)?.map((e) => e as String)?.toList(),
    UnLikes: (json['UnLikes'] as List)?.map((e) => e as String)?.toList(),
    At: (json['At'] as List)?.map((e) => e as String)?.toList(),
    CreateAt: json['CreateAt'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'ID': instance.ID,
      'VideoID': instance.VideoID,
      'VideoName': instance.VideoName,
      'VideoThumbnail': instance.VideoThumbnail,
      'Content': instance.Content,
      'Sender': instance.Sender,
      'SenderAvatar': instance.SenderAvatar,
      'Receiver': instance.Receiver,
      'RefID': instance.RefID,
      'RefMainID': instance.RefMainID,
      'LikeCount': instance.LikeCount,
      'UnLikeCount': instance.UnLikeCount,
      'Likes': instance.Likes,
      'UnLikes': instance.UnLikes,
      'At': instance.At,
      'CreateAt': instance.CreateAt,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follow _$FollowFromJson(Map<String, dynamic> json) {
  return Follow(
    ID: json['ID'] as String,
    UserID: json['UserID'] as int,
    FollowID: json['FollowID'] as int,
    FollowName: json['FollowName'] as String,
    FollowAvatar: json['FollowAvatar'] as String,
    CreateAt: json['CreateAt'] as String,
  );
}

Map<String, dynamic> _$FollowToJson(Follow instance) => <String, dynamic>{
      'ID': instance.ID,
      'UserID': instance.UserID,
      'FollowID': instance.FollowID,
      'FollowName': instance.FollowName,
      'FollowAvatar': instance.FollowAvatar,
      'CreateAt': instance.CreateAt,
    };

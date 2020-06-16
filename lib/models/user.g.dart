// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    ID: json['ID'] as int,
    Mail: json['Mail'] as String,
    NickName: json['NickName'] as String,
    Introduce: json['Introduce'] as String,
    Sex: json['Sex'] as int,
    VIPEndTime: json['VIPEndTime'] as String,
    Avatar: json['Avatar'] as String,
    Phone: json['Phone'] as String,
    PassWord: json['PassWord'] as String,
    DeviceID: json['DeviceID'] as String,
    DevicePlatform: json['DevicePlatform'] as String,
    IP: json['IP'] as String,
    Coin: json['Coin'] as num,
    Platform: json['Platform'] as String,
    Longitude: json['Longitude'] as num,
    Latitude: json['Latitude'] as num,
    CreateAt: json['CreateAt'] as String,
    LastLogin: json['LastLogin'] as String,
    State: json['State'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'ID': instance.ID,
      'Mail': instance.Mail,
      'NickName': instance.NickName,
      'Introduce': instance.Introduce,
      'VIPEndTime': instance.VIPEndTime,
      'Sex': instance.Sex,
      'Avatar': instance.Avatar,
      'Phone': instance.Phone,
      'PassWord': instance.PassWord,
      'DeviceID': instance.DeviceID,
      'DevicePlatform': instance.DevicePlatform,
      'IP': instance.IP,
      'Coin': instance.Coin,
      'Platform': instance.Platform,
      'Longitude': instance.Longitude,
      'Latitude': instance.Latitude,
      'CreateAt': instance.CreateAt,
      'LastLogin': instance.LastLogin,
      'State': instance.State,
    };

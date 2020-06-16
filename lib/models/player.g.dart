// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
    ID: json['ID'] as String,
    Name: json['Name'] as String,
    URL: json['URL'] as String,
  );
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'ID': instance.ID,
      'Name': instance.Name,
      'URL': instance.URL,
    };

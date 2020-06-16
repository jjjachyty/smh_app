// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apply _$ApplyFromJson(Map<String, dynamic> json) {
  return Apply(
    ID: json['ID'] as String,
    Name: json['Name'] as String,
    Describe: json['Describe'] as String,
    State: json['State'] as bool,
    CreateAt: json['CreateAt'] as String,
    UpdateAt: json['UpdateAt'] as String,
    Users: (json['Users'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ApplyToJson(Apply instance) => <String, dynamic>{
      'ID': instance.ID,
      'Name': instance.Name,
      'Describe': instance.Describe,
      'Users': instance.Users,
      'State': instance.State,
      'CreateAt': instance.CreateAt,
      'UpdateAt': instance.UpdateAt,
    };

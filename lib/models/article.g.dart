// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    Title: json['Title'] as String,
    ID: json['ID'] as String,
    Context: json['Context'] as String,
    CreateAt: json['CreateAt'] as String,
    CreateBy: json['CreateBy'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'ID': instance.ID,
      'Title': instance.Title,
      'Context': instance.Context,
      'CreateAt': instance.CreateAt,
      'CreateBy': instance.CreateBy,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'girls_image_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GirlsImageModel _$GirlsImageModelFromJson(Map<String, dynamic> json) {
  return GirlsImageModel()
    ..status = json['status'] as String
    ..currentPage = json['current_page'] as int
    ..totalComments = json['total_comments'] as int
    ..pageCount = json['page_count'] as int
    ..count = json['count'] as int
    ..comments = (json['comments'] as List)
        ?.map((e) => e == null
            ? null
            : GirlsImageBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GirlsImageModelToJson(GirlsImageModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'current_page': instance.currentPage,
      'total_comments': instance.totalComments,
      'page_count': instance.pageCount,
      'count': instance.count,
      'comments': instance.comments
    };

GirlsImageBean _$GirlsImageBeanFromJson(Map<String, dynamic> json) {
  return GirlsImageBean()
    ..authorName = json['comment_author'] as String
    ..date = json['comment_date'] as String
    ..votePositive = json['vote_positive'] as String
    ..voteNegative = json['vote_negative'] as String
    ..subCommentCount = json['sub_comment_count'] as String
    ..textContent = json['text_content'] as String
    ..pics = (json['pics'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$GirlsImageBeanToJson(GirlsImageBean instance) =>
    <String, dynamic>{
      'comment_author': instance.authorName,
      'comment_date': instance.date,
      'vote_positive': instance.votePositive,
      'vote_negative': instance.voteNegative,
      'sub_comment_count': instance.subCommentCount,
      'text_content': instance.textContent,
      'pics': instance.pics
    };

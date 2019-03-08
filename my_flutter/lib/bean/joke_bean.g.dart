// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokeModel _$JokeModelFromJson(Map<String, dynamic> json) {
  return JokeModel()
    ..status = json['status'] as String
    ..currentPage = json['current_page'] as int
    ..totalComments = json['total_comments'] as int
    ..pageCount = json['page_count'] as int
    ..count = json['count'] as int
    ..comments = (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : JokeBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$JokeModelToJson(JokeModel instance) => <String, dynamic>{
      'status': instance.status,
      'current_page': instance.currentPage,
      'total_comments': instance.totalComments,
      'page_count': instance.pageCount,
      'count': instance.count,
      'comments': instance.comments
    };

JokeBean _$JokeBeanFromJson(Map<String, dynamic> json) {
  return JokeBean()
    ..author = json['comment_author'] as String
    ..date = json['comment_date'] as String
    ..content = json['text_content'] as String
    ..votePositive = json['vote_positive'] as String
    ..voteNegative = json['vote_negative'] as String
    ..subCommentCount = json['sub_comment_count'] as String;
}

Map<String, dynamic> _$JokeBeanToJson(JokeBean instance) => <String, dynamic>{
      'comment_author': instance.author,
      'comment_date': instance.date,
      'text_content': instance.content,
      'vote_positive': instance.votePositive,
      'vote_negative': instance.voteNegative,
      'sub_comment_count': instance.subCommentCount
    };

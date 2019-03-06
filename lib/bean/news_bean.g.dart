// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsBean _$NewsBeanFromJson(Map<String, dynamic> json) {
  return NewsBean()
    ..title = json['title'] as String
    ..excerpt = json['excerpt'] as String
    ..date = json['date'] as String
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..commentCount = json['comment_count'] as int
    ..author = json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>)
    ..customFields = json['custom_fields'] == null
        ? null
        : CustomFields.fromJson(json['custom_fields'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NewsBeanToJson(NewsBean instance) => <String, dynamic>{
      'title': instance.title,
      'excerpt': instance.excerpt,
      'date': instance.date,
      'tags': instance.tags,
      'comment_count': instance.commentCount,
      'author': instance.author,
      'custom_fields': instance.customFields
    };

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag()
    ..id = json['id'] as int
    ..slug = json['slug'] as String
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..postCount = json['post_count'] as int;
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'description': instance.description,
      'post_count': instance.postCount
    };

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author()
    ..id = json['id'] as int
    ..slug = json['slug'] as String
    ..name = json['name'] as String
    ..nickname = json['nickname'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'nickname': instance.nickname,
      'description': instance.description
    };

CustomFields _$CustomFieldsFromJson(Map<String, dynamic> json) {
  return CustomFields()
    ..thumb = (json['thumb_c'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$CustomFieldsToJson(CustomFields instance) =>
    <String, dynamic>{'thumb_c': instance.thumb};

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return NewsModel()
    ..status = json['status'] as String
    ..currentPage = json['current_page'] as int
    ..totalComments = json['total_comments'] as int
    ..pageCount = json['page_count'] as int
    ..count = json['count'] as int
    ..posts = (json['posts'] as List)
        ?.map((e) =>
            e == null ? null : NewsBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'status': instance.status,
      'current_page': instance.currentPage,
      'total_comments': instance.totalComments,
      'page_count': instance.pageCount,
      'count': instance.count,
      'posts': instance.posts
    };

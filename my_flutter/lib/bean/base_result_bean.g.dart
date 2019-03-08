// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_result_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResultBean _$BaseResultBeanFromJson(Map<String, dynamic> json) {
  return BaseResultBean()
    ..status = json['status'] as String
    ..currentPage = json['current_page'] as int
    ..totalComments = json['total_comments'] as int
    ..pageCount = json['page_count'] as int
    ..count = json['count'] as int;
}

Map<String, dynamic> _$BaseResultBeanToJson(BaseResultBean instance) =>
    <String, dynamic>{
      'status': instance.status,
      'current_page': instance.currentPage,
      'total_comments': instance.totalComments,
      'page_count': instance.pageCount,
      'count': instance.count
    };

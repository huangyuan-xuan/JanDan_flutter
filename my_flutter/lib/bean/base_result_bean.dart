import 'package:json_annotation/json_annotation.dart';
part 'base_result_bean.g.dart';

@JsonSerializable()
class BaseResultBean{
  BaseResultBean();


  String status;

  @JsonKey(name: "current_page")
  int currentPage;

  @JsonKey(name: "total_comments")
  int totalComments;

  @JsonKey(name: "page_count")
  int pageCount;


  int count;


  factory BaseResultBean.fromJson(Map<String, dynamic> json) => _$BaseResultBeanFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResultBeanToJson(this);


}
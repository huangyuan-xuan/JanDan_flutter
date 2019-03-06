import 'package:jandan_flutter/bean/base_result_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_bean.g.dart';

@JsonSerializable()
class NewsBean {
  NewsBean();

  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "excerpt")
  String excerpt;

  @JsonKey(name: "date")
  String date;

  @JsonKey(name: "tags")
  List<Tag> tags;

  @JsonKey(name: "comment_count")
  int commentCount;

  @JsonKey(name: "author")
  Author author;

  @JsonKey(name: "custom_fields")
  CustomFields customFields;

  factory NewsBean.fromJson(Map<String, dynamic> json) =>
      _$NewsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$NewsBeanToJson(this);
}

@JsonSerializable()
class Tag {
  Tag();

  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "slug")
  String slug;

  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "description")
  String description;

  @JsonKey(name: "post_count")
  int postCount;



  factory Tag.fromJson(Map<String, dynamic> json) =>
      _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);

}


@JsonSerializable()
class Author{
  Author();

  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "slug")
  String slug;


  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "nickname")
  String nickname;

  @JsonKey(name: "description")
  String description;

  factory Author.fromJson(Map<String, dynamic> json) =>
      _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);

}

@JsonSerializable()
class CustomFields{
  CustomFields();


  @JsonKey(name:"thumb_c")
  List<String> thumb;


  factory CustomFields.fromJson(Map<String, dynamic> json) =>
      _$CustomFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomFieldsToJson(this);


}



@JsonSerializable()
class NewsModel extends BaseResultBean {
  NewsModel();

  List<NewsBean> posts;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

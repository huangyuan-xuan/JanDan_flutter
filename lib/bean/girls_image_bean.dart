import 'package:json_annotation/json_annotation.dart';
import 'package:jandan_flutter/bean/base_result_bean.dart';
part 'girls_image_bean.g.dart';

@JsonSerializable()
class GirlsImageModel extends BaseResultBean{

  GirlsImageModel();

  @JsonKey(name:"comments")
  List<GirlsImageBean> comments;

  factory GirlsImageModel.fromJson(Map<String, dynamic> json) =>
      _$GirlsImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$GirlsImageModelToJson(this);


}



@JsonSerializable()
class GirlsImageBean {

  GirlsImageBean();

  @JsonKey(name: "comment_author")
  String authorName;

  @JsonKey(name: "comment_date")
  String date;

  @JsonKey(name: "vote_positive")
  String votePositive;

  @JsonKey(name: "vote_negative")
  String voteNegative;

  @JsonKey(name: "sub_comment_count")
  String subCommentCount;

  @JsonKey(name: "text_content")
  String textContent;

  @JsonKey(name: "pics")
  List<String> pics;


  factory GirlsImageBean.fromJson(Map<String, dynamic> json) =>
      _$GirlsImageBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GirlsImageBeanToJson(this);

}



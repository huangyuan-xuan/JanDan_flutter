import 'base_result_bean.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bored_image_bean.g.dart';

@JsonSerializable()
class BoredImageBean{

  BoredImageBean();

  @JsonKey(name: "comment_author")
  String author;

  @JsonKey(name: "comment_date")
  String date;

  @JsonKey(name: "text_content")
  String content;

  @JsonKey(name: "pics")
  List<String> pics;

  @JsonKey(name: "vote_positive")
  String votePositive;

  @JsonKey(name: "vote_negative")
  String voteNegative;

  @JsonKey(name: "sub_comment_count")
  String subCommentCount;


  factory BoredImageBean.fromJson(Map<String, dynamic> json) => _$BoredImageBeanFromJson(json);
  Map<String, dynamic> toJson() => _$BoredImageBeanToJson(this);

}


@JsonSerializable()
class BoredImageModel extends BaseResultBean{

  BoredImageModel();

  List<BoredImageBean> comments;


  factory BoredImageModel.fromJson(Map<String, dynamic> json) => _$BoredImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$BoredImageModelToJson(this);

}
import 'package:json_annotation/json_annotation.dart';
import 'base_result_bean.dart';
part 'joke_bean.g.dart';

@JsonSerializable()
class JokeModel extends BaseResultBean{
  JokeModel();

  List<JokeBean> comments;


  factory JokeModel.fromJson(Map<String, dynamic> json) => _$JokeModelFromJson(json);
  Map<String, dynamic> toJson() => _$JokeModelToJson(this);

}


@JsonSerializable()
class JokeBean {
  JokeBean(){}

  @JsonKey(name: "comment_author")
  String author;

  @JsonKey(name:"comment_date")
  String date;

  @JsonKey(name: "text_content")
  String content;

  @JsonKey(name: "vote_positive")
  String votePositive;

  @JsonKey(name: "vote_negative")
  String voteNegative;

  @JsonKey(name: "sub_comment_count")
  String subCommentCount;
  factory JokeBean.fromJson(Map<String, dynamic> json) => _$JokeBeanFromJson(json);
  Map<String, dynamic> toJson() => _$JokeBeanToJson(this);
}


import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int id;
  final String author;
  final String text;
  final int burns;

  const Comment({
    required this.id,
    required this.author,
    required this.text,
    required this.burns,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

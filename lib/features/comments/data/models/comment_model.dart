import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;
}

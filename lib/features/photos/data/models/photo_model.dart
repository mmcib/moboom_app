import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel {
  PhotoModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) => _$PhotoModelFromJson(json);

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
}

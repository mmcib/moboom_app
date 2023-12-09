import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moboom_app/core/data/database/moboom_database.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  final String id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  factory UserModel.fromDbModel(User user) {
    return UserModel(
      id: user.id!,
      email: user.email!,
      password: user.password!,
      firstName: user.firstName!,
      lastName: user.lastName!,
    );
  }
}

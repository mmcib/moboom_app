import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_user_state.freezed.dart';

@freezed
class AddUserState with _$AddUserState {
  const factory AddUserState.initial() = _Initial;

  const factory AddUserState.inProgress() = _InProgress;

  const factory AddUserState.userAdded() = _UserAdded;

  const factory AddUserState.failure() = _Failure;
}

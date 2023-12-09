import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/features/auth/data/models/user_model.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;

  const factory SignInState.inProgress() = _InProgress;

  const factory SignInState.signedIn(List<UserModel> users) = _SignedIn;

  const factory SignInState.failure(Failure failure) = _Failure;
}

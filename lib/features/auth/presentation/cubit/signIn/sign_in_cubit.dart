import 'package:bloc/bloc.dart';
import 'package:moboom_app/features/auth/domain/usecases/get_user_use_case.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signIn/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._getUserUseCase) : super(const SignInState.initial());

  final GetUserUseCase _getUserUseCase;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const SignInState.inProgress());
    final authResult = await _getUserUseCase(
      email: email,
      password: password,
    );

    authResult.fold(
      (_) => emit(const SignInState.unauthorized()),
      (r) {
        print('SignInCubit: ${r}');
        return emit(SignInState.authorized(r));
      },
    );
  }
}

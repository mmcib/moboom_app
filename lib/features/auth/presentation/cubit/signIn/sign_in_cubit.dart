import 'package:bloc/bloc.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/auth/domain/usecases/add_user_use_case.dart';
import 'package:moboom_app/features/auth/domain/usecases/get_all_local_users.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signIn/sign_in_state.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signUp/add_user_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._getAllLocalUsersUseCase) : super(const SignInState.initial());

  final GetAllLocalUsersUseCase _getAllLocalUsersUseCase;

  Future<void> getUsers(
    // String id,
    // String email,
    // String password,
    // String firstName,
    // String lastName,
  ) async {
    emit(const SignInState.inProgress());
    final result = await _getAllLocalUsersUseCase.execute(
      NoParams(),

      // id: id,
      // email: email,
      // password: password,
      // firstName: firstName,
      // lastName: lastName,
    );
    result.fold(
      (l) => emit( SignInState.failure(l)),
      (r) {
        print('SignInCubit: ${r}');
        return emit( SignInState.signedIn(r));
      },
    );
  }
}

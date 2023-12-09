import 'package:bloc/bloc.dart';
import 'package:moboom_app/features/auth/domain/usecases/add_user_use_case.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signUp/add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit(this._addUserUseCase) : super(const AddUserState.initial());

  final AddUserUseCase _addUserUseCase;

  Future<void> addUser(
    String id,
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    emit(const AddUserState.inProgress());
    final result = await _addUserUseCase.execute(
      id: id,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    result.fold(
      (l) => emit(const AddUserState.failure()),
      (r) => emit(const AddUserState.userAdded()),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:moboom_app/core/presentation/bloc/get_data_state.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/auth/data/models/user_model.dart';
import 'package:moboom_app/features/auth/domain/usecases/get_all_local_users.dart';

class GetAllUsersCubit extends Cubit<GetDataState<List<UserModel>>> {
  GetAllUsersCubit(this._getAllLocalUsersUseCase)
      : super(const GetDataState.initial());

  final GetAllLocalUsersUseCase _getAllLocalUsersUseCase;

  Future<void> getUsers() async {
    emit(const GetDataState.inProgress());
    final result = await _getAllLocalUsersUseCase.execute(
      NoParams(),
    );
    result.fold(
      (l) => emit(GetDataState.failure(l)),
      (r) {
        print('GetAllUsersCubit: ${r}');
        return emit(GetDataState.success(r));
      },
    );
  }
}

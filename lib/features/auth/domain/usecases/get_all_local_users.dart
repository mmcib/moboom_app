import 'package:dartz/dartz.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/auth/data/models/user_model.dart';
import 'package:moboom_app/features/auth/domain/repositories/user_repository.dart';

class GetAllLocalUsersUseCase extends UseCase<List<UserModel>, NoParams> {
  GetAllLocalUsersUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, List<UserModel>>> execute(NoParams noParams) {
    return _userRepository.getAllLocalUsers();
  }
}

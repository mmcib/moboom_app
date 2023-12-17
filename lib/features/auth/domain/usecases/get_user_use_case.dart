import 'package:dartz/dartz.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/features/auth/data/models/user_model.dart';
import 'package:moboom_app/features/auth/domain/repositories/user_repository.dart';

class GetUserUseCase {
  GetUserUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<Either<Failure, UserModel>> call({
    required String email,
    required String password,
  }) {
    return _userRepository.getUser(
      email: email,
      password: password,
    );
  }
}

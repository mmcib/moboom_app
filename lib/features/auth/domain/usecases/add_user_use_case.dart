import 'package:dartz/dartz.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/features/auth/data/models/user_model.dart';
import 'package:moboom_app/features/auth/domain/repositories/user_repository.dart';

class AddUserUseCase {
  AddUserUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<Either<Failure, void>> execute({
    required String id,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final result = await _userRepository.addUser(
      UserModel(
        id: id,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    result.fold(Left.new, (r) async => r);
    return result;
  }
}

import 'package:dartz/dartz.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/features/auth/data/models/user_model.dart';

abstract class UserRepository {
  // Future<Either<Failure, UserModel>> getUser();

  Future<Either<Failure, int>> addUser(UserModel user);

  Future<Either<Failure, List<UserModel>>> getAllLocalUsers();

  // Future<Either<Failure, void>> removeQuote(String quoteId);
}

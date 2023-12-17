import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:moboom_app/core/data/database/moboom_database.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/features/auth/data/dataproviders/user_db.dart';
import 'package:moboom_app/features/auth/data/models/user_model.dart';
import 'package:moboom_app/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl(this._usersDatabase);

  final UsersDatabase _usersDatabase;

  @override
  Future<Either<Failure, UserModel>> getUser({
    required String email,
    required String password,
  }) async {
    try {
      final userDbOrNull = await _usersDatabase.getUserEntry(email, password);

      if (userDbOrNull != null) {
        return Right<Failure, UserModel>(UserModel.fromDbModel(userDbOrNull));
      }

      return Left(AuthFailure());
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack, label: 'UserRepositoryImpl.getUser');
      return Left(ClientFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllLocalUsers() async {
    try {
      return _mapUsersToRightEntities(await _usersDatabase.getUserEntries());
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack, label: 'UserRepositoryImpl.getUserEntries');
      return Left(ClientFailure(e));
    }
  }

  @override
  Future<Either<Failure, int>> addUser(UserModel user) async {
    try {
      return _usersDatabase
          .insertUser(
            UserTableCompanion(
              id: Value(user.id),
              email: Value(user.email),
              password: Value(user.password),
              firstName: Value(user.firstName),
              lastName: Value(user.lastName),
            ),
          )
          .then(Right.new);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack, label: 'UserRepositoryImpl.addUser');
      return Left(ClientFailure(e));
    }
  }

  Right<Failure, List<UserModel>> _mapUsersToRightEntities(List<User> items) =>
      Right<Failure, List<UserModel>>(items.map(UserModel.fromDbModel).toList());
}

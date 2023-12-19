import 'package:get_it/get_it.dart';
import 'package:moboom_app/core/data/database/moboom_database.dart';
import 'package:moboom_app/features/auth/data/dataproviders/user_db.dart';
import 'package:moboom_app/features/auth/data/repositories/user_repository_impl.dart';
import 'package:moboom_app/features/auth/domain/repositories/user_repository.dart';
import 'package:moboom_app/features/auth/domain/usecases/add_user_use_case.dart';
import 'package:moboom_app/features/auth/domain/usecases/get_all_local_users.dart';
import 'package:moboom_app/features/auth/domain/usecases/get_user_use_case.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signIn/sign_in_cubit.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signUp/add_user_cubit.dart';

Future<void> setupDependencies(GetIt getIt) async {
  getIt
    ..registerSingleton<UsersDatabase>(getIt<MoboomDatabase>())
    ..registerSingleton<UserRepository>(UserRepositoryImpl(getIt()))
    ..registerFactory(() => AddUserUseCase(getIt()))
    ..registerFactory(() => GetUserUseCase(getIt()))
    ..registerFactory(() => AddUserCubit(getIt()))
    ..registerFactory(() => SignInCubit(getIt()));
}

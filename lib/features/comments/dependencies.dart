import 'package:get_it/get_it.dart';
import 'package:moboom_app/features/comments/data/repositories/comment_repository_impl.dart';
import 'package:moboom_app/features/comments/domain/repositories/comment_repository.dart';
import 'package:moboom_app/features/comments/domain/usecases/get_comments_use_case.dart';
import 'package:moboom_app/features/comments/presentation/cubit/comments_cubit.dart';

Future<void> setupDependencies(GetIt getIt) async {
  getIt
    ..registerSingleton<CommentRepository>(CommentRepositoryImpl(getIt()))
    ..registerFactory(() => GetCommentsUseCase(getIt()))
    ..registerLazySingleton(() => CommentsCubit(getIt()));
}

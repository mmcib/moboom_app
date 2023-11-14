import 'package:get_it/get_it.dart';
import 'package:moboom_app/features/photos/data/repositories/photo_repository_impl.dart';
import 'package:moboom_app/features/photos/domain/repositories/photo_repository.dart';
import 'package:moboom_app/features/photos/domain/usecases/get_photos_use_case.dart';
import 'package:moboom_app/features/photos/presentation/cubit/photos_cubit.dart';

Future<void> setupDependencies(GetIt getIt) async {
  getIt
    ..registerSingleton<PhotoRepository>(PhotoRepositoryImpl(getIt()))
    ..registerFactory(() => GetPhotosUseCase(getIt()))
    ..registerLazySingleton(() => PhotosCubit(getIt()));
}

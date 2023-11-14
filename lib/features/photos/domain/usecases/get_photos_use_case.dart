import 'package:dartz/dartz.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/photos/data/models/photo_model.dart';
import 'package:moboom_app/features/photos/domain/repositories/photo_repository.dart';

class GetPhotosUseCase extends UseCase<List<PhotoModel>, NoParams> {
  GetPhotosUseCase(this._photoRepository);

  final PhotoRepository _photoRepository;

  @override
  Future<Either<Failure, List<PhotoModel>>> execute(NoParams noParams) {
    return _photoRepository.getPhotos();
  }
}

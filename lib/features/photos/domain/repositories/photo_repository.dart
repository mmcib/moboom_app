import 'package:dartz/dartz.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/features/photos/data/models/photo_model.dart';

abstract class PhotoRepository {
  Future<Either<Failure, List<PhotoModel>>> getPhotos();
}

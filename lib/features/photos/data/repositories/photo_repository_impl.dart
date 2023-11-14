import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:moboom_app/core/data/api/api_client.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/features/photos/data/models/photo_model.dart';
import 'package:moboom_app/features/photos/domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl extends PhotoRepository {
  PhotoRepositoryImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<Either<Failure, List<PhotoModel>>> getPhotos() async {
    try {
      final response = await _apiClient.get('photos', params: {
        "_limit": 10,
      });

      final comments = (response as List).map((it) => PhotoModel.fromJson(it)).toList();

      return Right(comments);
    } on SocketException catch (_) {
      return Left<Failure, List<PhotoModel>>(NoInternetConnectionFailure());
    } catch (e) {
      // here we can add some logger to print errors and also send those errors to Firebase
      return Left<Failure, List<PhotoModel>>(ClientFailure(e.toString()));
    }
  }
}

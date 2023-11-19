import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
        // I have added the limit, because the API returns enormous amount of photos
        // In such cases we should implement some pagination
      });

      final photos =
          (response as List).map((it) => PhotoModel.fromJson(it)).toList();

      return Right(photos);
    } on ServerFailure catch (e) {
      return Left<Failure, List<PhotoModel>>(
        ServerFailure(
          statusCode: e.statusCode,
          errorMessage: e.errorMessage,
          reason: e.reason?.toString(),
        ),
      );
    } on NoInternetConnectionFailure catch (_) {
      return Left<Failure, List<PhotoModel>>(NoInternetConnectionFailure());
    } on ClientFailure catch (e) {
      if (e.exception.type == DioExceptionType.connectionError ||
          e.exception.type == DioExceptionType.connectionTimeout ||
          e.exception.type == DioExceptionType.receiveTimeout ||
          e.exception.type == DioExceptionType.sendTimeout) {
        return Left<Failure, List<PhotoModel>>(NoInternetConnectionFailure());
      }

      return Left<Failure, List<PhotoModel>>(ClientFailure(e));
    } catch (e) {
      // here we can add some logger to print errors and also send those errors to Firebase
      return Left<Failure, List<PhotoModel>>(ClientFailure(e));
    }
  }
}

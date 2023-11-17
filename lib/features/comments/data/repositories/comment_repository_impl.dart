import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:moboom_app/core/data/api/api_client.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/features/comments/data/models/comment_model.dart';
import 'package:moboom_app/features/comments/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl extends CommentRepository {
  CommentRepositoryImpl(
    this._apiClient,
  );

  final ApiClient _apiClient;

  @override
  Future<Either<Failure, List<CommentModel>>> getComments() async {
    try {
      final response = await _apiClient.get('comments', params: {
        "_limit": 10,
        // I have added the limit, because the API returns enormous amount of comments
      });

        final comments =
            (response as List).map((it) => CommentModel.fromJson(it)).toList();

        return Right(comments);
    } on ServerFailure catch (e) {
      return Left<Failure, List<CommentModel>>(
        ServerFailure(
          statusCode: e.statusCode,
          errorMessage: e.errorMessage,
          reason: e.reason?.toString(),
        ),
      );
    } on NoInternetConnectionFailure catch (_) {
      return Left<Failure, List<CommentModel>>(NoInternetConnectionFailure());
    } on ClientFailure catch (e) {
      if (e.exception.type == DioExceptionType.connectionError ||
          e.exception.type == DioExceptionType.connectionTimeout ||
          e.exception.type == DioExceptionType.receiveTimeout ||
          e.exception.type == DioExceptionType.sendTimeout) {
        return Left<Failure, List<CommentModel>>(NoInternetConnectionFailure());
      }

      return Left<Failure, List<CommentModel>>(ClientFailure(e));
    } catch (e) {
      // here we can add some logger to print errors and also send those errors to Firebase
      return Left<Failure, List<CommentModel>>(ClientFailure(e));
    }
  }
}

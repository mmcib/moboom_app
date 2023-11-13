import 'package:dartz/dartz.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/features/comments/data/models/comment_model.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<CommentModel>>> getComments();
}

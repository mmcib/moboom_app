import 'package:dartz/dartz.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/comments/data/models/comment_model.dart';
import 'package:moboom_app/features/comments/domain/repositories/comment_repository.dart';

class GetCommentsUseCase extends UseCase<List<CommentModel>, NoParams> {
  GetCommentsUseCase(this._commentRepository);

  final CommentRepository _commentRepository;

  @override
  Future<Either<Failure, List<CommentModel>>> execute(NoParams noParams) {
    return _commentRepository.getComments();
  }
}

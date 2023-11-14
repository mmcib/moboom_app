import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/core/presentation/bloc/get_data_state.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/comments/data/models/comment_model.dart';
import 'package:moboom_app/features/comments/domain/usecases/get_comments_use_case.dart';

class CommentsCubit extends Cubit<GetDataState<List<CommentModel>>> {
  CommentsCubit(this._getCommentsUseCase) : super(const GetDataState.initial());

  final GetCommentsUseCase _getCommentsUseCase;

  Future<void> loadComments() async {
    emit(const GetDataState.inProgress());

    final Either<Failure, List<CommentModel>> results = await _getCommentsUseCase.execute(NoParams());
    results.fold(
      (Failure failure) => emit(GetDataState.failure(failure)),
      (comments) => emit(GetDataState.success(comments)),
    );
  }
}

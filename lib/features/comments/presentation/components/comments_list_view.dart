import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moboom_app/core/presentation/bloc/get_data_state.dart';
import 'package:moboom_app/features/comments/data/models/comment_model.dart';
import 'package:moboom_app/features/comments/presentation/components/comment_card_body.dart';
import 'package:moboom_app/features/comments/presentation/cubit/comments_cubit.dart';
import 'package:moboom_app/features/common/presentation/components/failure_view.dart';
import 'package:moboom_app/features/common/presentation/components/progress_view.dart';

// TODO: Update the UI
// TODO: Add responsiveness
// TODO: Add i10n
class CommentsListView extends StatelessWidget {
  const CommentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, GetDataState<List<CommentModel>>>(
      builder: (context, GetDataState<List<CommentModel>> state) {
        return state.maybeWhen(
          success: (List<CommentModel> comments) {
            if (comments.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: ListView.separated(
                  separatorBuilder: (_, __) => SizedBox(height: 16),
                  shrinkWrap: true,
                  itemCount: comments.length,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) => CommentCardBody(comment: comments[index]),
                ),
              );
            }

            return Center(
              child: Text('Comments Not Found'),
            );
          },
          inProgress: () => const ProgressView(color: Colors.deepPurpleAccent),
          failure: (failure) => FailureView(failure: failure),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moboom_app/core/presentation/bloc/get_data_state.dart';
import 'package:moboom_app/features/comments/data/models/comment_model.dart';
import 'package:moboom_app/features/comments/presentation/components/comment_card_body.dart';
import 'package:moboom_app/features/comments/presentation/cubit/comments_cubit.dart';
import 'package:moboom_app/features/common/presentation/components/failure_view.dart';
import 'package:moboom_app/features/common/presentation/components/progress_view.dart';
import 'package:moboom_app/generated/l10n.dart';

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
                padding: EdgeInsets.all(8).r,
                child: ListView.separated(
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  shrinkWrap: true,
                  itemCount: comments.length,
                  padding: EdgeInsets.all(12).r,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) => CommentCardBody(comment: comments[index]),
                ),
              );
            }

            return Center(
              child: Text(S.of(context).commentsNotFound),
            );
          },
          inProgress: () => const ProgressView(color: Colors.deepPurpleAccent),
          failure: (failure) => FailureView(
            failure: failure,
            onRetry: () => context.read<CommentsCubit>().loadComments(),
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

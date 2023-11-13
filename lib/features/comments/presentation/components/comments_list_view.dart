import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moboom_app/core/presentation/bloc/get_data_state.dart';
import 'package:moboom_app/features/comments/data/models/comment_model.dart';
import 'package:moboom_app/features/comments/presentation/cubit/comments_cubit.dart';
import 'package:moboom_app/features/common/presentation/components/failure_view.dart';
import 'package:moboom_app/features/common/presentation/components/progress_view.dart';

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
                  separatorBuilder: (context, index) => SizedBox(height: 24),
                  shrinkWrap: true,
                  itemCount: comments.length,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('name: ${comments[index].name}'),
                        Text('email: ${comments[index].email}'),
                        Text('body: ${comments[index].body}'),
                      ],
                    );
                  },
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

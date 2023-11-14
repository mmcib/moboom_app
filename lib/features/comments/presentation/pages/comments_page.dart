import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moboom_app/core/dependency_injection/domain/dependencies_container.dart';
import 'package:moboom_app/features/comments/presentation/components/comments_list_view.dart';
import 'package:moboom_app/features/comments/presentation/cubit/comments_cubit.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CommentsCubit>()..loadComments(),
      child: Builder(builder: _buildBody),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'Comments',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CommentsListView(),
      ),
    );
  }
}

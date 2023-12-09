import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moboom_app/core/dependency_injection/domain/dependencies_container.dart';
import 'package:moboom_app/features/auth/data/models/user_model.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signIn/sign_in_cubit.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signIn/sign_in_state.dart';
import 'package:moboom_app/features/common/presentation/components/failure_view.dart';
import 'package:moboom_app/features/common/presentation/components/progress_view.dart';
import 'package:moboom_app/generated/l10n.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SignInCubit>(),
      child: Builder(builder: _buildBody),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        // title: Text(S.of(context).comments.capitalize()),
        title: Text('SignIn'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // context.read<AddUserCubit>().addUser('id3', 'email3', 'password3', 'firstName3', 'lastName3');
                context.read<SignInCubit>().getUsers();
              },
              child: const Text(
                'get users',
              ),
            ),

            BlocBuilder<SignInCubit, SignInState>(
              builder: (context, SignInState state) {
                return state.maybeWhen(
                  signedIn: (List<UserModel> users) {
                    if (users.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: users.length,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Text('${users[index].id}'),
                              Text('${users[index].email}'),
                              Text('${users[index].firstName}'),
                              Text('${users[index].lastName}'),
                              Text('${users[index].password}'),
                            ],
                          );
                        },
                      );
                    }

                    return Center(child: Text('S.of(context).localQuotesNotFound'));
                  },
                  inProgress: () => const ProgressView(),
                  failure: (failure) => FailureView(failure: failure),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

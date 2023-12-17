import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moboom_app/core/dependency_injection/domain/dependencies_container.dart';
import 'package:moboom_app/core/presentation/components/button_component.dart';
import 'package:moboom_app/core/util/snack_bar_util.dart';
import 'package:moboom_app/features/auth/data/models/user_model.dart';
import 'package:moboom_app/features/auth/presentation/components/user_text_field.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signIn/sign_in_cubit.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signIn/sign_in_state.dart';
import 'package:moboom_app/generated/l10n.dart';

final GlobalKey<FormState> _formKey = GlobalKey();

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailTextController =
      TextEditingController(text: '');
  final TextEditingController _passwordTextController =
      TextEditingController(text: '');

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildLabel('Email'),
                      UserTextField(
                        controller: _emailTextController,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Wprowadź email';
                          }

                          return null;
                        },
                        maxLines: null,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 16),
                      _buildLabel('Password'),
                      const SizedBox(height: 6),
                      UserTextField(
                        controller: _passwordTextController,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Proszę wprowadzić hasło';
                          }

                          return null;
                        },
                        maxLines: null,
                        hintText: 'Hasło',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildSignInButton(context),
              BlocListener<SignInCubit, SignInState>(
                listener: (context, SignInState state) {
                   state.maybeWhen(
                    authorized: (UserModel user) async {
                      showSuccessSnackBar(context, 'Zalogowano pomyślnie :)');
                      await Future.delayed(const Duration(milliseconds: 1500));

                      return Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    },
                    unauthorized: () => showErrorSnackBar(context, 'Nieprawidłowe dane'),
                    inProgress: () {},
                    orElse: () {},
                  );
                },
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return SimpleButton(
      text: 'Zaloguj',
      onPressed: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        if (_formKey.currentState != null &&
            _formKey.currentState!.validate()) {
          await context.read<SignInCubit>().signIn(
                email: _emailTextController.text,
                password: _passwordTextController.text,
              );
        }
      },
    );
  }

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.deepPurpleAccent,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

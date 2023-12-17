import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moboom_app/core/dependency_injection/domain/dependencies_container.dart';
import 'package:moboom_app/core/presentation/components/button_component.dart';
import 'package:moboom_app/features/auth/presentation/components/user_text_field.dart';
import 'package:moboom_app/features/auth/presentation/cubit/signUp/add_user_cubit.dart';
import 'package:uuid/uuid.dart';

final GlobalKey<FormState> _formKey = GlobalKey();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailTextController =
      TextEditingController(text: '');
  final TextEditingController _passwordTextController =
      TextEditingController(text: '');
  final TextEditingController _firstNameTextController =
      TextEditingController(text: '');
  final TextEditingController _lastNameTextController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AddUserCubit>(),
      child: Builder(builder: _buildBody),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        // title: Text(S.of(context).comments.capitalize()),
        title: Text('SignUp'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
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
                      SizedBox(height: 16.h),
                      _buildLabel('Password'),
                      SizedBox(height: 6.h),
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
                      _buildLabel('Imię'),
                      SizedBox(height: 6.h),
                      UserTextField(
                        controller: _firstNameTextController,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Proszę wprowadzić Imię';
                          }

                          return null;
                        },
                        maxLines: null,
                        hintText: 'Imię',
                      ),
                      _buildLabel('Nazwisko'),
                      SizedBox(height: 6.h),
                      UserTextField(
                        controller: _lastNameTextController,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Proszę wprowadzić Nazwisko';
                          }

                          return null;
                        },
                        maxLines: null,
                        hintText: 'Nazwisko',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              _buildAddNewUserButton(context),
            ],
          ),
        ),
      ),
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

  Widget _buildAddNewUserButton(BuildContext context) {
    return SimpleButton(
        text: 'Zarejestruj',
        onPressed: () async {
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            await context.read<AddUserCubit>().addUser(
                  const Uuid().v4(),
                  _emailTextController.text,
                  _passwordTextController.text,
                  _firstNameTextController.text,
                  _lastNameTextController.text,
                );
          }
        });
  }
}

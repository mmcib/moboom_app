import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moboom_app/core/dependency_injection/domain/dependencies_container.dart';
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
  final TextEditingController _emailTextController = TextEditingController(text: '');
  final TextEditingController _passwordTextController = TextEditingController(text: '');
  final TextEditingController _firstNameTextController = TextEditingController(text: '');
  final TextEditingController _lastNameTextController = TextEditingController(text: '');

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
        child:
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
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
                      _buildLabel('Imię'),
                      const SizedBox(height: 6),
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
                      const SizedBox(height: 6),
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
              const SizedBox(height: 8),
              _buildAddNewUserButton(context),
            ],
          ),
        ),

        // ElevatedButton(
        //   onPressed: () {
        //     context.read<AddUserCubit>().addUser('id3', 'email3', 'password3', 'firstName3', 'lastName3');
        //   },
        //   child: const Text(
        //     'add user',
        //   ),
        // ),


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
    return ElevatedButton(
      child: Text(
        'Zarejestruj',
        style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 16),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(16),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(color: Colors.deepPurpleAccent),
          ),
        ),
      ),
      onPressed: () async {
        if (_formKey.currentState != null && _formKey.currentState!.validate()) {
          await context.read<AddUserCubit>().addUser(
            const Uuid().v4(),
            _emailTextController.text,
            _passwordTextController.text,
            _firstNameTextController.text,
            _lastNameTextController.text,
          );

          // Navigator.pop(context);
        }
      },
    );
  }
}

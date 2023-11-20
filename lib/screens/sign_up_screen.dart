import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocConsumer, ReadContext;

import '../constants/strings.dart';
import '../cubits/auth/auth_cubit.dart';
import '../utilities/snack_bar_shower.dart';
import '../widgets/main_elevated_button.dart';
import '../widgets/main_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  var email = '';
  var password = '';

  @override
  Widget build(context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Column(
                  children: [
                    Image.asset(kLogo),
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 24),
              MainTextFormField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => email = value ?? '',
              ),
              const SizedBox(height: 16),
              MainTextFormField(
                label: 'Password',
                obscureText: true,
                onSaved: (value) => password = value ?? '',
              ),
              const SizedBox(height: 24),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.authStatus == AuthStatus.success) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      kChatScreen,
                      (route) => false,
                      arguments: state.userEmail,
                    );
                  } else if (state.authStatus == AuthStatus.failure) {
                    showSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  return MainElevatedButton(
                    label: 'Sign Up',
                    isLoading: state.authStatus == AuthStatus.loading,
                    onPressed: () {
                      if (isFormValid) {
                        context.read<AuthCubit>().authenticate(
                              isSigningIn: false,
                              email: email,
                              password: password,
                            );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get isFormValid {
    var form = _formKey.currentState;
    if (form == null || !form.validate()) return false;

    form.save();
    return true;
  }
}

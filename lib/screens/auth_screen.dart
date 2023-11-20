import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocConsumer, BlocSelector, ReadContext;

import '../constants/strings.dart';
import '../cubits/auth/auth_cubit.dart';
import '../utilities/snack_bar_shower.dart';
import '../widgets/main_elevated_button.dart';
import '../widgets/main_text_form_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
                      style: TextStyle(fontSize: 32, fontFamily: 'Pacifico'),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: BlocSelector<AuthCubit, AuthState, bool>(
                  selector: (state) => state.isSignIn,
                  builder: (context, isSignIn) => Text(
                    isSignIn ? 'Sign In' : 'Sign Up',
                    style: const TextStyle(fontSize: 24),
                  ),
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
                    Navigator.pushReplacementNamed(
                      context,
                      kChatScreen,
                      arguments: state.userEmail,
                    );
                  } else if (state.authStatus == AuthStatus.failure) {
                    showSnackBar(context, state.message);
                  }
                },
                builder: (context, state) => MainElevatedButton(
                  label: state.isSignIn ? 'Sign In' : 'Sign Up',
                  isLoading: state.authStatus == AuthStatus.loading,
                  onPressed: () {
                    if (isFormValid) {
                      context.read<AuthCubit>().authenticate(
                            isSigningIn: true,
                            email: email,
                            password: password,
                          );
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              BlocSelector<AuthCubit, AuthState, bool>(
                selector: (state) => state.isSignIn,
                builder: (context, isSignIn) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isSignIn
                          ? 'Don\'t have an account?'
                          : 'Already have an account?',
                    ),
                    TextButton(
                      onPressed: context.read<AuthCubit>().toggleAuth,
                      child: Text(isSignIn ? 'Sign Up' : 'Sign In'),
                    ),
                  ],
                ),
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

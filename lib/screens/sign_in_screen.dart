import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../utilities/snack_bar_shower.dart';
import '../widgets/main_elevated_button.dart';
import '../widgets/main_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                    Image.asset('assets/images/scholar.png'),
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
                  'Sign In',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 24),
              MainTextFormField(
                label: 'Email',
                onSaved: (value) => email = value ?? '',
              ),
              const SizedBox(height: 16),
              MainTextFormField(
                label: 'Password',
                onSaved: (value) => password = value ?? '',
              ),
              const SizedBox(height: 24),
              MainElevatedButton(
                label: 'Sign In',
                onPressed: () async {
                  try {
                    if (isFormValid) await signUp();
                    showSnackBar(context, 'Success');
                  } on FirebaseAuthException catch (e) {
                    showSnackBar(context, e.message);
                  }
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, kSignUpScreen),
                    child: const Text('Sign Up'),
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

  Future<void> signUp() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

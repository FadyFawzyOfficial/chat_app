import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utilities/snack_bar_shower.dart';
import '../widgets/main_elevated_button.dart';
import '../widgets/main_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  var email = '';
  var password = '';

  @override
  Widget build(context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                'Sign Up',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 24),
            MainTextField(
              label: 'Email',
              onChanged: (value) => email = value,
            ),
            const SizedBox(height: 16),
            MainTextField(
              label: 'Password',
              onChanged: (value) => password = value,
            ),
            const SizedBox(height: 24),
            MainElevatedButton(
              label: 'Sign Up',
              onPressed: () async {
                try {
                  await signIn();
                } on FirebaseAuthException catch (e) {
                  showSnackBar(context, e.message);
                }
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
    );
  }

  Future<void> signIn() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

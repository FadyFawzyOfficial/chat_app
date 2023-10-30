import 'package:flutter/material.dart';

import '../widgets/main_elevated_button.dart';
import '../widgets/main_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: Padding(
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
                'Sign In',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 24),
            const MainTextField(label: 'Email'),
            const SizedBox(height: 16),
            const MainTextField(label: 'Password'),
            const SizedBox(height: 24),
            MainElevatedButton(label: 'Sign In', onPressed: () {}),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {},
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

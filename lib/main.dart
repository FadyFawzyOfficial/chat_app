import 'package:flutter/material.dart';

import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        'SignInScreen': (context) => const SignInScreen(),
        'SignUpScreen': (context) => const SignUpScreen(),
      },
      initialRoute: 'SignInScreen',
    );
  }
}

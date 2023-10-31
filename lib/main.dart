import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants/strings.dart';
import 'firebase_options.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const App());
}

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
        kSignInScreen: (context) => const SignInScreen(),
        kSignUpScreen: (context) => const SignUpScreen(),
      },
      initialRoute: kSignInScreen,
    );
  }
}

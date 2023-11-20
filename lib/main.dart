import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants/strings.dart';
import 'firebase_options.dart';
import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';

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
        kAuthScreen: (context) => const AuthScreen(),
        kChatScreen: (context) => ChatScreen(),
      },
      initialRoute: kAuthScreen,
    );
  }
}

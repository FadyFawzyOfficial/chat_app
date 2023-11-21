import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;

import 'constants/strings.dart';
import 'firebase_options.dart';
import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';
import 'simple_bloc_observer.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
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

part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthAuthenticated extends AuthEvent {
  final String email;
  final String password;

  AuthAuthenticated({
    required this.email,
    required this.password,
  });
}

class AuthToggled extends AuthEvent {}

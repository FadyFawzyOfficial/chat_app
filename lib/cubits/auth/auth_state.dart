part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  failure,
}

class AuthState {
  final AuthStatus authStatus;
  final String message;
  final String userEmail;

  const AuthState({
    required this.authStatus,
    required this.message,
    required this.userEmail,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    String? message,
    String? userEmail,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      message: message ?? this.message,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  factory AuthState.initial() {
    return const AuthState(
      authStatus: AuthStatus.initial,
      message: '',
      userEmail: '',
    );
  }

  @override
  String toString() =>
      'AuthState(authStatus: $authStatus, message: $message, userEmail: $userEmail)';
}

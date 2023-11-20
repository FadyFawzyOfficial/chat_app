part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  failure,
}

class AuthState {
  final AuthStatus authStatus;
  final bool isSignIn;
  final String message;
  final String userEmail;

  const AuthState({
    required this.authStatus,
    required this.isSignIn,
    required this.message,
    required this.userEmail,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    bool? isSignIn,
    String? message,
    String? userEmail,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      isSignIn: isSignIn ?? this.isSignIn,
      message: message ?? this.message,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  factory AuthState.initial() {
    return const AuthState(
      authStatus: AuthStatus.initial,
      isSignIn: true,
      message: '',
      userEmail: '',
    );
  }

  @override
  String toString() =>
      'AuthState(authStatus: $authStatus, isSignIn: $isSignIn, message: $message, userEmail: $userEmail)';
}

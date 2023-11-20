import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  void authenticate({
    required bool isSigningIn,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      final userCredential = isSigningIn
          ? await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: password,
            )
          : await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );

      emit(
        state.copyWith(
          authStatus: AuthStatus.success,
          userEmail: userCredential.user!.email,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.failure, message: '$e'));
    }
  }
}

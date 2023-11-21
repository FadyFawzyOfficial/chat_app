import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<AuthToggled>(
        (event, emit) => emit(state.copyWith(isSignIn: !state.isSignIn)));

    on<AuthAuthenticated>(
      (event, emit) async {
        emit(state.copyWith(authStatus: AuthStatus.loading));

        try {
          final userCredential = state.isSignIn
              ? await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: event.email,
                  password: event.password,
                )
              : await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: event.email,
                  password: event.password,
                );

          emit(
            state.copyWith(
              authStatus: AuthStatus.success,
              userEmail: userCredential.user!.email,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(state.copyWith(
              authStatus: AuthStatus.failure, message: e.message));
        } catch (e) {
          emit(state.copyWith(authStatus: AuthStatus.failure, message: '$e'));
        }
      },
    );
  }
}

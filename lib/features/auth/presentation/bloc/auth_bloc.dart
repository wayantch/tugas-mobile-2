import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetique/features/auth/domain/entities/user.dart';
import 'package:sweetique/features/auth/domain/usecases/create_user_with_email.dart';
import 'package:sweetique/features/auth/domain/usecases/sign_in_with_email.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signInWithEmail;
  final CreateUserWithEmail registerWithEmail;

  AuthBloc({required this.signInWithEmail, required this.registerWithEmail})
    : super(AuthStateInitial()) {
    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateLoading());
      // proses database
      final data = await signInWithEmail(
        SignInWithEmailParams(email: event.email, password: event.password),
      );
      data.fold(
        (left) {
          emit(AuthStateError(left.toString()));
        },
        (right) {
          emit(AuthStateLoaded(right));
        },
      );
    });
    on<AuthEventRegister>((event, emit) async {
      emit(AuthStateLoading());
      // proses database
      final data = await registerWithEmail(
        CreateUserWithEmailParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      data.fold(
        (left) {
          emit(AuthStateError(left.toString()));
        },
        (right) {
          emit(AuthStateLoaded(right));
        },
      );
    });
    on<AuthEventLogout>((event, emit) async {
      emit(AuthStateLoading());
      await FirebaseAuth.instance.signOut();
      emit(AuthStateInitial());
    });
  }
}

import 'package:dartz/dartz.dart';
import 'package:sweetique/core/errors/failure.dart';
import 'package:sweetique/core/usecase/usecase.dart';
import 'package:sweetique/features/auth/domain/entities/user.dart';
import 'package:sweetique/features/auth/domain/repositories/user_repository.dart';

// UseCase untuk SignIn
class SignInWithEmail implements UseCase<UserEntity, SignInWithEmailParams> {
  final UserRepository repository;

  SignInWithEmail({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(SignInWithEmailParams params) async {
    // Panggil method signInWithEmailAndPassword di repository
    return await repository.signInWithEmailAndPassword(
      params.email,
      params.password,
    );
  }
}

// Parameters untuk SignIn
class SignInWithEmailParams {
  final String email;
  final String password;

  SignInWithEmailParams({required this.email, required this.password});
}

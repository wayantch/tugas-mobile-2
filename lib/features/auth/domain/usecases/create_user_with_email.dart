import 'package:dartz/dartz.dart';
import 'package:sweetique/core/errors/failure.dart';
import 'package:sweetique/core/usecase/usecase.dart';
import 'package:sweetique/features/auth/domain/entities/user.dart';
import 'package:sweetique/features/auth/domain/repositories/user_repository.dart';

// UseCase untuk SignIn
class CreateUserWithEmail implements UseCase<UserEntity, CreateUserWithEmailParams> {
  final UserRepository repository;

  CreateUserWithEmail({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(CreateUserWithEmailParams params) async {
    // Panggil method signInWithEmailAndPassword di repository
    return await repository.createUserWithEmailAndPassword(
      params.email,
      params.password,
      params.name,
    );
  }
}

// Parameters untuk SignIn
class CreateUserWithEmailParams {
  final String email;
  final String password;
  final String name;

  CreateUserWithEmailParams({required this.email, required this.password, required this.name});
}

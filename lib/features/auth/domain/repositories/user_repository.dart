import 'package:dartz/dartz.dart';
import 'package:sweetique/core/errors/failure.dart';
import 'package:sweetique/features/auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  );
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, void>> signOut();
}

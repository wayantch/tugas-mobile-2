import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetique/core/errors/failure.dart';
import 'package:sweetique/features/auth/data/datasources/user_datasource.dart';
import 'package:sweetique/features/auth/domain/entities/user.dart';
import 'package:sweetique/features/auth/domain/repositories/user_repository.dart';

class UserRepoImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepoImpl({required this.remoteDataSource});

    @override
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      // Cek apakah email sudah terdaftar
      final signInResult = await signInWithEmailAndPassword(email, password);
      if (signInResult.isRight()) {
        // Jika email sudah terdaftar, kembalikan error
        return Left(ServerFailure('Email sudah terdaftar.'));
      }

      // Lakukan pendaftaran jika email belum terdaftar
      final user = await remoteDataSource.createUserWithEmailAndPassword(
        email,
        password,
        name,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      // Cek error terkait email sudah digunakan
      if (e.code == 'email-already-in-use') {
        return Left(ServerFailure('Email sudah digunakan.'));
      }
      return Left(ServerFailure('Error: ${e.message ?? 'Unknown error'}'));
    } catch (e) {
      return Left(ServerFailure('An error occurred: ${e.toString()}'));
    }
  }


  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.signInWithEmailAndPassword(
        email,
        password,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(
        ServerFailure('Authentication failed: ${e.message ?? 'Unknown error'}'),
      );
    } catch (e) {
      return Left(ServerFailure('An error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

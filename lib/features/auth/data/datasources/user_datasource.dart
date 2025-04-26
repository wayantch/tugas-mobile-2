import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetique/features/auth/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<UserModel> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  );
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({required this.firebaseAuth, required this.firestore});


  @override
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update displayName
      await credential.user!.updateDisplayName(name);
      await credential.user!.reload(); // biar nama ke-update

      return UserModel.fromFirebaseUser(firebaseAuth.currentUser!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception("Password lemah");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("Email sudah terpakai");
      }
      throw Exception(e.message ?? "Terjadi error saat registrasi");
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}

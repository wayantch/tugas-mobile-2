import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:sweetique/core/components/cubit/option/option_cubit.dart';
import 'package:sweetique/features/auth/data/datasources/user_datasource.dart';
import 'package:sweetique/features/auth/data/repositories/user_repo_impl.dart';
import 'package:sweetique/features/auth/domain/repositories/user_repository.dart';
import 'package:sweetique/features/auth/domain/usecases/create_user_with_email.dart';
import 'package:sweetique/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:sweetique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var myinjection = GetIt.instance;

Future<void> init() async {
  // External Firebase
  myinjection.registerLazySingleton(() => FirebaseAuth.instance);
  myinjection.registerLazySingleton(() => FirebaseFirestore.instance);

  // Cubit
  myinjection.registerFactory(() => OptionCubit());

  /// FEATURE - AUTH
  myinjection.registerFactory(
    () => AuthBloc(
      signInWithEmail: myinjection(), // Pastikan sudah terdaftar
      registerWithEmail: myinjection(), // Pastikan sudah terdaftar
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => SignInWithEmail(
      repository: myinjection(),
    ), // Pastikan repository sudah terdaftar
  );
  myinjection.registerLazySingleton(
    () => CreateUserWithEmail(
      repository: myinjection(),
    ), // Pastikan repository sudah terdaftar
  );

  // REPOSITORY
  myinjection.registerLazySingleton<UserRepository>(
    () => UserRepoImpl(remoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      firebaseAuth: myinjection(),
      firestore: myinjection(),
    ),
  );
}

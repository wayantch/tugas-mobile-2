import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import 'package:sweetique/core/components/cubit/option/option_cubit.dart';

// AUTH
import 'package:sweetique/features/auth/data/datasources/user_datasource.dart';
import 'package:sweetique/features/auth/data/repositories/user_repo_impl.dart';
import 'package:sweetique/features/auth/domain/repositories/user_repository.dart';
import 'package:sweetique/features/auth/domain/usecases/create_user_with_email.dart';
import 'package:sweetique/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:sweetique/features/auth/presentation/bloc/auth_bloc.dart';

// PRODUCT
import 'package:sweetique/features/product/data/datasources/product_datasource.dart';
import 'package:sweetique/features/product/data/repositories/product_repo_impl.dart';
import 'package:sweetique/features/product/domain/repositories/product_repository.dart';
import 'package:sweetique/features/product/domain/usecases/product_usecase.dart';
import 'package:sweetique/features/product/presentation/bloc/product_bloc.dart';

final myinjection = GetIt.instance;

Future<void> init() async {
  // ----------------------------- EXTERNAL ----------------------------- //
  myinjection.registerLazySingleton(() => FirebaseAuth.instance);
  myinjection.registerLazySingleton(() => FirebaseFirestore.instance);

  // ----------------------------- CUBIT ----------------------------- //
  myinjection.registerFactory(() => OptionCubit());

  // ----------------------------- FEATURE: AUTH ----------------------------- //

  // Data Source
  myinjection.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      firebaseAuth: myinjection(),
      firestore: myinjection(),
    ),
  );

  // Repository
  myinjection.registerLazySingleton<UserRepository>(
    () => UserRepoImpl(remoteDataSource: myinjection()),
  );

  // Usecases
  myinjection.registerLazySingleton(
    () => SignInWithEmail(repository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CreateUserWithEmail(repository: myinjection()),
  );

  // Bloc
  myinjection.registerFactory(
    () => AuthBloc(
      signInWithEmail: myinjection(),
      registerWithEmail: myinjection(),
    ),
  );
  // ----------------------------- FEATURE: AUTH ----------------------------- //


  // ----------------------------- FEATURE: PRODUCT ----------------------------- //

  // Data Source
  myinjection.registerLazySingleton<ProductRemoteDataSource>(
    () =>
        ProductRemoteDataSourceImplementation(firebaseFirestore: myinjection()),
  );

  // Repository
  myinjection.registerLazySingleton<ProductRepository>(
    () => ProductRepoImpl(productRemoteDataSource: myinjection()),
  );

  // Usecases
  myinjection.registerLazySingleton(
    () => ProductUsecaseAdd(productRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProductUsecaseDelete(productRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProductUsecaseEdit(productRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProductUsecaseGetAll(productRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProductUsecaseGetById(productRepository: myinjection()),
  );

  // Bloc
  myinjection.registerFactory(
    () => ProductBloc(
      productUsecaseAdd: myinjection(),
      productUsecaseDelete: myinjection(),
      productUsecaseEdit: myinjection(),
      productUsecaseGetAll: myinjection(),
      productUsecaseGetById: myinjection(),
    ),
  );

  // ----------------------------- FEATURE: PRODUCT ----------------------------- //

}

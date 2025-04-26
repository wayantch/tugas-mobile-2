import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetique/core/routes/my_router.dart';
import 'package:sweetique/core/theme/app_theme.dart';
import 'package:sweetique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sweetique/features/product/presentation/bloc/product_bloc.dart';
import 'package:sweetique/my_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Hanya panggil sekali
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init(); // Inisialisasi dependensi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create:
              (context) => AuthBloc(
                signInWithEmail: myinjection(),
                registerWithEmail: myinjection(),
              ),
        ),
        BlocProvider<ProductBloc>(
          create:
              (context) => ProductBloc(
                productUsecaseAdd: myinjection(),
                productUsecaseDelete: myinjection(),
                productUsecaseEdit: myinjection(),
                productUsecaseGetAll: myinjection(),
                productUsecaseGetById: myinjection(),
              ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: MyRouter().router,
        theme: AppThemes.light,
      ),
    );
  }
}

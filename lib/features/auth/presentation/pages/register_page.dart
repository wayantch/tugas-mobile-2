import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetique/core/components/button/app_button.dart';
import 'package:sweetique/core/constant/url_app_constant.dart';
import 'package:sweetique/core/theme/app_icons.dart';
import 'package:sweetique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sweetique/features/auth/presentation/widgets/social_button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 80, width: 80),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: _signinText(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _fullName,
              decoration: InputDecoration(
                hintText: 'Nama Lengkap', // ← kasih hintText di sini bro
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                hintText: 'Email', // ← kasih hintText di sini bro
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                hintText: 'Password', // ← kasih hintText di sini bro
              ),
            ),
            SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.message,
                      ), // Error message from failure
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is AuthStateLoaded) {
                  context.go(
                    UrlAppConstant.home,
                  ); // Navigate to home if success
                }
              },
              builder: (context, state) {
                final isLoading = state is AuthStateLoading;
                return AppButton(
                  onPressed:
                      isLoading
                          ? null
                          : () {
                            final fullNameText = _fullName.text.trim();
                            final emailText = _email.text.trim();
                            final passwordText = _password.text.trim();
                            if (emailText.isEmpty ||
                                passwordText.isEmpty ||
                                fullNameText.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('All fields are required!'),
                                ),
                              );
                              return;
                            }
                            if (!emailText.contains('@')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid email format!'),
                                ),
                              );
                              return;
                            }
                            context.read<AuthBloc>().add(
                              AuthEventRegister(
                                name: fullNameText,
                                email: emailText,
                                password: passwordText,
                              ),
                            );
                          },
                  title: isLoading ? 'Loading...' : 'Daftar Sekarang',
                );
              },
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.2,
                  height: 1,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Masuk Dengan'),
                ),
                Container(
                  width: screenWidth * 0.2,
                  height: 1,
                  color: Colors.black12,
                ),
              ],
            ),
            SizedBox(height: 20),
            SocialButton(
              iconPath: AppIcons.google,
              text: 'Login dengan Google',
              onTap: () => context.go(UrlAppConstant.register),
            ),
            const SizedBox(height: 10),
            SocialButton(
              iconPath: AppIcons.facebook,
              text: 'Login dengan Facebook',
              onTap: () => context.go(UrlAppConstant.home),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sudah punya akun? ', style: TextStyle(fontSize: 14)),
          TextButton(
            onPressed: () {
              context.go(UrlAppConstant.login);
            },
            child: Text('Masuk'),
          ),
        ],
      ),
    );
  }
}

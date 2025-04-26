// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetique/core/components/appbar/basic_app_bar.dart';
import 'package:sweetique/core/components/button/app_button.dart';
import 'package:sweetique/core/constant/url_app_constant.dart';
import 'package:sweetique/core/theme/app_colors.dart';
import 'package:sweetique/core/theme/app_icons.dart';
import 'package:sweetique/core/theme/app_images.dart';
import 'package:sweetique/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sweetique/features/auth/presentation/widgets/social_button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: BasicAppBar(
        title: Image.asset(AppImages.logo, height: 80, width: 80),
      ),
      bottomNavigationBar: _buildSignUpText(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Selamat Datang di Shoply',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            // _buildTextField(hintText: 'Email'),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Email', // ← kasih hintText di sini bro
              ),
            ),

            const SizedBox(height: 10),
            TextFormField(controller: password,
            decoration: InputDecoration(
                hintText: 'Password', // ← kasih hintText di sini bro
              ),
            ),
            // _buildTextField(hintText: 'Password', obscureText: true),
            const SizedBox(height: 10),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red, // Biar error lebih kelihatan
                    ),
                  );
                } else if (state is AuthStateLoaded) {
                  context.go(UrlAppConstant.home); // Pindah halaman setelah login sukses
                }
              },
              builder: (context, state) {
                final isLoading =
                    state is AuthStateLoading; // biar ga bolak-balik cek
                return AppButton(
                  onPressed:
                      isLoading
                          ? null // Disable button kalau lagi loading
                          : () {
                            final emailText = email.text.trim();
                            final passwordText = password.text.trim();
                            if (emailText.isEmpty || passwordText.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Email dan Password wajib diisi!',
                                  ),
                                ),
                              );
                              return;
                            }
                            context.read<AuthBloc>().add(
                              AuthEventLogin(
                                email: emailText,
                                password: passwordText,
                              ),
                            );
                          },
                  title: isLoading ? 'Loading...' : 'Masuk',
                );
              },
            ),


            const SizedBox(height: 20),
            _buildDividerWithText(screenWidth),
            const SizedBox(height: 20),
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


  Widget _buildDividerWithText(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(height: 2, width: screenWidth * 0.2, color: Colors.black12),
        const Text(
          'Masuk Dengan',
          style: TextStyle(color: AppColors.darkGray, fontSize: 16),
        ),
        Container(height: 2, width: screenWidth * 0.2, color: Colors.black12),
      ],
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Belum punya akun? ',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              context.go(UrlAppConstant.register);
            },
            child: const Text('Daftar'),
          ),
        ],
      ),
    );
  }
}

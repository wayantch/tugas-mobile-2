// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetique/core/components/button/app_button.dart';
import 'package:sweetique/core/constant/url_app_constant.dart';
import 'package:sweetique/core/theme/app_images.dart';

class LoginOrRegisterPage extends StatelessWidget {
  const LoginOrRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.srcOver,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Image.asset(AppImages.logo, width: 150),
                    SizedBox(height: 55),
                    Spacer(),
                    Text(
                      'Selamat Datang di shoply!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Masuk untuk melanjutkan belanja buku favorit Anda atau daftar untuk memulai koleksi buku baru bersama kami.',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AppButton(
                            title: 'Daftar',
                            onPressed: () {
                              context.go(UrlAppConstant.register);
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: AppButton(
                            title: 'Masuk',
                            onPressed: () {
                              context.go(UrlAppConstant.login);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

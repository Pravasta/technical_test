import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/common/routes/app_routes.dart';
import 'package:technical_test/constant/app_colors.dart';
import 'package:technical_test/constant/app_text.dart';
import 'package:technical_test/constant/url_assets.dart';
import 'package:technical_test/features/home/view/home_page.dart';
import 'package:technical_test/features/login_register/cubit/auth_cubit.dart';
import 'package:technical_test/features/welcome/view/welcome_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        AppRoutes.toAndRemove(const WelcomePage());
      } else {
        context.read<AuthCubit>().getCurrentUser(user.uid);
        AppRoutes.toAndRemove(const HomePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                UrlAsset.welcome,
                width: 300,
              ),
              const SizedBox(height: 30),
              Text(
                'Search Job',
                style: AppText.text48.copyWith(
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
